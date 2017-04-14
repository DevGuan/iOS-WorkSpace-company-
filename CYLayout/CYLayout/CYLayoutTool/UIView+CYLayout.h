//
//  UIView+CYLayout.h
//  CYLayout
//
//  Created by GARY on 2017/4/12.
//  Copyright © 2017年 GARY. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CYLayoutAlignType) {
    CYLayoutAlignType_CenterX = NSLayoutAttributeCenterX,
    CYLayoutAlignType_CenterY = NSLayoutAttributeCenterY,
    CYLayoutAlignType_Top = NSLayoutAttributeTop,
    CYLayoutAlignType_Left = NSLayoutAttributeLeft,
    CYLayoutAlignType_Bottom = NSLayoutAttributeBottom,
    CYLayoutAlignType_Right = NSLayoutAttributeRight,
    CYLayoutAlignType_Baseline = NSLayoutAttributeBaseline
};

@interface UIView (CYLayout)


/**
 view与父控件贴边重合
 */
- (void)autoFillParent;


/**
 添加子控件view

 @param edgeInsets 子view与父控件相差边距
 */
- (void)autoFillParentWithEdgeInsets:(UIEdgeInsets)edgeInsets;



/**
 子控件相对于父控件布局
 
 @param types 相对于父控件布局的方式
 */
- (void)autoAlignParentWithAlignTypes:(NSArray<NSNumber*>*)types;
- (void)autoAlignParentWithAlignTypes:(NSArray<NSNumber*>*)types EdgeInsets:(UIEdgeInsets)edgeInsets;

@end
