//
//  ZJNGameViewController.m
//  ZJNPuzzleGame
//
//  Created by GARY on 2017/2/9.
//  Copyright © 2017年 GARY. All rights reserved.
//

/**
 游戏界面的Controller
 */
#import "ZJNGameViewController.h"

#pragma mark - gameCell
@interface GameCell :UICollectionViewCell
@property (nonatomic, strong) UIImageView *cellImage;
@property (nonatomic, assign) NSInteger index;
@end

@implementation GameCell
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _cellImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        
        [self.contentView addSubview:_cellImage];
    }
    return self;
}
@end


@interface ZJNGameViewController ()<UINavigationControllerDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *stepLabel;
@property (weak,nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;

@property (nonatomic,strong) NSMutableArray *imageArr;
@property (nonatomic, strong) NSMutableArray *shuffleArr;
@property (nonatomic, strong) GameCell *emptyCell;
@end

@implementation ZJNGameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _imageView.image = _mainImage;
    _imageArr = [UIImage clipImageWithImage:_mainImage withConuntM:_diffCount withCountN:_diffCount];
    
    _shuffleArr = [self changeArrayOrderWithArray:_imageArr];
    
    [self setUpCollectionView];
}

- (void)setUpCollectionView
{
    [_collectionView registerClass:[GameCell class] forCellWithReuseIdentifier:@"gameCell"];
    
    _collectionView.contentSize = _collectionView.frame.size;
    _collectionView.backgroundColor = [UIColor whiteColor];
    CGFloat imageSize = (_collectionView.frame.size.width - (_diffCount+1)*1)/_diffCount;
    _flowLayout.itemSize = CGSizeMake(imageSize, imageSize);
    _flowLayout.minimumLineSpacing = 1;
    _flowLayout.minimumInteritemSpacing =1;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
}


#pragma mark - CollectionView Delegate/Datasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _imageArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    GameCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"gameCell" forIndexPath:indexPath];
    
    //确保emptyCell上的图片为最后一张图
    if (_shuffleArr[indexPath.item] == _imageArr[_imageArr.count-1]) {
        _emptyCell = cell;
    }
    else
    {
        cell.cellImage.image = _shuffleArr[indexPath.item];
    }
    
    return cell;
}

- (NSMutableArray *)changeArrayOrderWithArray:(NSArray*)imageArray {
    NSMutableArray *tempArry = [NSMutableArray arrayWithArray:imageArray];
    int n = (int)imageArray.count/3;

    for (int i = 0 ; i < n*n; i++) {
        NSInteger random = arc4random_uniform((int)tempArry.count-2);
        UIImage *temp = tempArry[random];
        tempArry[random] = tempArry[random+1];
        tempArry[random+1] = tempArry[random+2];
        tempArry[random+2] = temp;
        
    }
    
    return tempArry;
}

#pragma mark - IBAction
- (IBAction)settingButtonAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)restartButtonAction:(UIButton *)sender {
}
- (IBAction)rankButtonAction:(UIButton *)sender {
}
@end

