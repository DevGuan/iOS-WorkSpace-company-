//
//  CYLBouncyLayout.m
//  bouncyLayout
//
//  Created by 迟钰林 on 2017/10/9.
//  Copyright © 2017年 迟钰林. All rights reserved.
//

#import "CYLBouncyLayout.h"

@interface CYLBouncyLayout()
@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (nonatomic, assign) BouncyStyle style;
@property (nonatomic, strong) NSMutableSet *visibleItemIndexPathSet;
@property (nonatomic, assign) CGFloat latestDelta;
@end

@implementation CYLBouncyLayout

- (instancetype)initWithBouncyStyle:(BouncyStyle)style
{
    if (self = [super init]) {
        self.style = style;
        self.minimumInteritemSpacing = 10;
        self.minimumLineSpacing = 10;
        self.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    }
    return self;
}

- (void)prepareLayout
{
    [super prepareLayout];
    
    CGRect visibleRect = CGRectInset((CGRect){.origin = self.collectionView.bounds.origin, .size = self.collectionView.frame.size}, 0, -600);
    NSArray *visibleItemArray = [super layoutAttributesForElementsInRect:visibleRect];
    NSSet *visibleItemPathSet = [NSSet setWithArray:[visibleItemArray valueForKey:@"indexPath"]];
    
    //移除不再显示的behavior
    NSArray *noLongerVisibleBehaviours = [self.animator.behaviors filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(UIAttachmentBehavior *behaviour, NSDictionary *bindings) {
        BOOL currentlyVisible = [visibleItemPathSet member:[((UICollectionViewLayoutAttributes*)[[behaviour items] firstObject]) indexPath]] != nil;
        return !currentlyVisible;
    }]];
    
    [noLongerVisibleBehaviours enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.animator removeBehavior:obj];
        [self.visibleItemIndexPathSet removeObject:[((UICollectionViewLayoutAttributes*)[[obj items] firstObject]) indexPath]];
    }];
    
    //为新出现的item 添加behavior
    NSArray *newlyVisibleItemArray = [visibleItemArray filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(UICollectionViewLayoutAttributes*  _Nullable attributes, NSDictionary<NSString *,id> * _Nullable bindings) {
        
        BOOL isNew = [self.visibleItemIndexPathSet member:attributes.indexPath] != nil;
        return !isNew;
    }]];
    
    CGPoint curLocation = [self.collectionView.panGestureRecognizer locationInView:self.collectionView];
    
    [newlyVisibleItemArray enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes*  _Nonnull attributes, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UIAttachmentBehavior *behavior = [[UIAttachmentBehavior alloc] initWithItem:attributes attachedToAnchor:attributes.center];
        
        switch (self.style) {
            case BouncyStyle_subtle:
                behavior.length = 0;
                behavior.damping = 0.8;
                behavior.frequency = 1.0;
                break;
            case BouncyStyle_regular:
                behavior.length = 0;
                behavior.damping = 0.7;
                behavior.frequency = 1.5;
                break;
            case BouncyStyle_prominent:
                behavior.length = 0;
                behavior.damping = 1;
                behavior.frequency = 2;
                break;
            default:
                break;
        }
        
        if (!CGPointEqualToPoint(curLocation, CGPointZero)) {
            CGFloat yDistance = fabs(curLocation.y - behavior.anchorPoint.y);
            CGFloat xDistance = fabs(curLocation.x - behavior.anchorPoint.x);
            CGFloat resistance = (xDistance + yDistance)/1500.0f;
            
            CGPoint center = ((UICollectionViewLayoutAttributes*)behavior.items.firstObject).center;
            if (self.latestDelta < 0) {
                center.y += MAX(self.latestDelta, self.latestDelta*resistance);
            }
            else
            {
                center.y += MIN(self.latestDelta, self.latestDelta*resistance);
            }
            
            ((UICollectionViewLayoutAttributes*)behavior.items.firstObject).center = center;
        }

        
        [self.visibleItemIndexPathSet addObject:attributes.indexPath];
        [self.animator addBehavior:behavior];
        
    }];
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return (NSArray<UICollectionViewLayoutAttributes *> *)[self.animator itemsInRect:rect];
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.animator layoutAttributesForCellAtIndexPath:indexPath]) {
        return [self.animator layoutAttributesForCellAtIndexPath:indexPath];
    }
    else
    {
        return  [super layoutAttributesForItemAtIndexPath:indexPath];
    }
}


- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    UIScrollView *scrollView = (UIScrollView*)self.collectionView;
    CGFloat delta = newBounds.origin.y - scrollView.bounds.origin.y;
    self.latestDelta = delta;
    CGPoint touchLocation = [self.collectionView.panGestureRecognizer locationInView:self.collectionView];
    
    [self.animator.behaviors enumerateObjectsUsingBlock:^(__kindof UIAttachmentBehavior * _Nonnull springBehaviour, NSUInteger idx, BOOL * _Nonnull stop) {
        
        CGFloat yDistanceFromTouch = fabs(touchLocation.y - springBehaviour.anchorPoint.y);
        CGFloat xDistanceFromTouch = fabs(touchLocation.x - springBehaviour.anchorPoint.x);
        CGFloat scrollResistance = (yDistanceFromTouch + xDistanceFromTouch) / 1500.0f;
        
        UICollectionViewLayoutAttributes *item = (UICollectionViewLayoutAttributes*)springBehaviour.items.firstObject;
        CGPoint center = item.center;
        if (delta < 0) {
            center.y += MAX(delta, delta*scrollResistance);
        }
        else {
            center.y += MIN(delta, delta*scrollResistance);
        }
        item.center = center;
        
        [self.animator updateItemUsingCurrentState:item];
    }];
    
    return NO;
}


#pragma mark - setter

- (NSMutableSet *)visibleItemIndexPathSet
{
    if (!_visibleItemIndexPathSet) {
        _visibleItemIndexPathSet = [NSMutableSet set];
    }
    return _visibleItemIndexPathSet;
}

- (UIDynamicAnimator *)animator
{
    if (!_animator) {
        _animator = [[UIDynamicAnimator alloc] initWithCollectionViewLayout:self];
    }
    return _animator;
}

@end
