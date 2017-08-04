//
//  UITextField+Responsable.m
//  TextFieldCategory
//
//  Created by 迟钰林 on 2017/7/3.
//  Copyright © 2017年 迟钰林. All rights reserved.
//

#import "UITextField+Responsable.h"
#import <objc/runtime.h>

static const char *selectedColorKey = "selectedColor";
static const char *errorColorKey = "errorColor";
static const char *setUpKey = "setUpKey";
static const char *passColorKey = "passColorKey";
static const char *errorPlaceholderKey = "errorPlaceholderKey";

@implementation UITextField (Responsable)

- (void)setUpForCheck
{
    self.borderStyle = UITextBorderStyleRoundedRect;
    self.layer.borderWidth = 1.0;
    self.layer.cornerRadius = 5;
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.isSetUpForCheck = YES;
    [self setNeedsDisplay];
}

- (BOOL)checkInputWithPattern:(NSString *)pattern
{
    NSAssert(self.isSetUpForCheck, @"pls invoke 'setUpForCheck' for prepare first");
    
    if (self.text.length == 0) {
        return NO;
    }
    
    NSPredicate *check = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
    
    BOOL result = [check evaluateWithObject:self.text];
    
    result ? [self setPass] : [self setError];
    
    return result;
}

- (void)setError
{
    self.text = nil;
    self.placeholder = self.errorPlaceHolder;
    [self errorAnimation];
}

- (void)setPass
{
    [self passAnimation];
}

- (void)errorAnimation
{
    CAKeyframeAnimation *shake = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
    shake.values = @[@(-5),@(10),@(-3),@(6),@(-1),@(2),@(0)];
    
    CABasicAnimation *error = [CABasicAnimation animationWithKeyPath:@"borderColor"];
    error.toValue = (__bridge id _Nullable)(self.errorColor.CGColor);
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[shake, error];
    group.duration = 0.5;
    group.removedOnCompletion = NO;
    group.fillMode = kCAFillModeBoth;
    [self.layer addAnimation:group forKey:nil];
}

- (void)passAnimation
{
    CAKeyframeAnimation *pass = [CAKeyframeAnimation animationWithKeyPath:@"borderColor"];
    pass.values = @[(__bridge id _Nullable)self.passColor.CGColor, (__bridge id _Nullable)self.layer.borderColor];
    pass.duration = 0.5;
    pass.removedOnCompletion = false;
    pass.fillMode = kCAFillModeBoth;
    [self.layer addAnimation:pass forKey:nil];
}

#pragma mark - property

- (void)setSelectedColor:(UIColor *)selectedColor
{
    objc_setAssociatedObject(self, selectedColorKey, selectedColor, OBJC_ASSOCIATION_RETAIN);
}

- (UIColor *)selectedColor
{
    UIColor *selectedC = (UIColor*)objc_getAssociatedObject(self, selectedColorKey);
    
    if (!selectedC) {
        selectedC = [UIColor colorWithCGColor:self.layer.borderColor];
    }
    
    return selectedC;
}


- (void)setErrorColor:(UIColor *)errorColor
{
    objc_setAssociatedObject(self, errorColorKey, errorColor, OBJC_ASSOCIATION_RETAIN);
}

- (UIColor *)errorColor
{
    UIColor *errC = (UIColor*)objc_getAssociatedObject(self, errorColorKey);
    
    if (!errC) {
        errC = [UIColor redColor];
    }
    
    return errC;
}


- (void)setPassColor:(UIColor *)passColor
{
    objc_setAssociatedObject(self, passColorKey, passColor, OBJC_ASSOCIATION_RETAIN);
}

- (UIColor *)passColor
{
    UIColor *passC = (UIColor*)objc_getAssociatedObject(self, passColorKey);
    
    if (!passC) {
        passC = [UIColor colorWithRed:37/255.0 green:220/255.0 blue:136/255.0 alpha:1];
    }
    
    return passC;
}

- (void)setIsSetUpForCheck:(BOOL)isSetUpForCheck
{
    objc_setAssociatedObject(self, setUpKey, @(isSetUpForCheck), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)isSetUpForCheck
{
    BOOL isSetUP = objc_getAssociatedObject(self, setUpKey);
    
    if (!isSetUP) {
        return false;
    }
    
    return isSetUP;
}

- (void)setErrorPlaceHolder:(NSString *)errorPlaceHolder
{
    objc_setAssociatedObject(self, errorPlaceholderKey, errorPlaceHolder, OBJC_ASSOCIATION_RETAIN);
}

- (NSString *)errorPlaceHolder
{
    NSString *placeHolder = (NSString*)objc_getAssociatedObject(self, errorPlaceholderKey);
    
    if (!placeHolder) {
        placeHolder = @"";
    }
    
    return placeHolder;
}
@end
