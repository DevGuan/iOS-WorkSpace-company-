//
//  CYLBouncyLayout.h
//  bouncyLayout
//
//  Created by 迟钰林 on 2017/10/9.
//  Copyright © 2017年 迟钰林. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, BouncyStyle) {
    BouncyStyle_subtle,
    BouncyStyle_regular,
    BouncyStyle_prominent
};

@interface CYLBouncyLayout : UICollectionViewFlowLayout
- (instancetype)initWithBouncyStyle:(BouncyStyle)style;
@end
