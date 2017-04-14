//
//  UIView+CYLayout.m
//  CYLayout
//
//  Created by GARY on 2017/4/12.
//  Copyright © 2017年 GARY. All rights reserved.
//

#import "UIView+CYLayout.h"
#import <Masonry.h>

@implementation UIView (CYLayout)

- (void)autoFillParent
{
    [self autoFillParentWithEdgeInsets:UIEdgeInsetsZero];
}

- (void)autoFillParentWithEdgeInsets:(UIEdgeInsets)edgeInsets
{
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.superview).with.insets(edgeInsets);
    }];
}

- (void)autoAlignParentWithAlignTypes:(NSArray<NSNumber*>*)types EdgeInsets:(UIEdgeInsets)edgeInsets
{
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        
        for (NSNumber *layoutType in types) {
            CYLayoutAlignType type = [layoutType integerValue];
            
            switch (type) {
                case CYLayoutAlignType_Top:
                    make.top.equalTo(self.superview.mas_top).offset(edgeInsets.top);
                    break;
                    
                case CYLayoutAlignType_Left:
                    make.top.equalTo(self.superview.mas_left).offset(edgeInsets.left);
                    break;
                    
                case CYLayoutAlignType_Right:
                    make.top.equalTo(self.superview.mas_right).offset(edgeInsets.right);
                    break;
                    
                case CYLayoutAlignType_Bottom:
                    make.top.equalTo(self.superview.mas_bottom).offset(edgeInsets.bottom);
                    break;
                    
                case CYLayoutAlignType_CenterX:
                    make.top.equalTo(self.superview.mas_centerX);
                    break;
                    
                case CYLayoutAlignType_CenterY:
                    make.top.equalTo(self.superview.mas_centerY);
                    break;
                    
                case CYLayoutAlignType_Baseline:
                    make.top.equalTo(self.superview.mas_baseline);
                    break;
                default:
                    break;
            }
        }
    }];

}

- (void)autoAlignParentWithAlignTypes:(NSArray<NSNumber *> *)types
{
    [self autoAlignParentWithAlignTypes:types EdgeInsets:UIEdgeInsetsZero];
}



@end
