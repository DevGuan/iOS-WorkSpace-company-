//
//  MagicMoveTransitionAnimation.h
//  CYLTransitioning
//
//  Created by 迟钰林 on 2017/6/23.
//  Copyright © 2017年 迟钰林. All rights reserved.
//

#import "CYLBaseTransitionAnimation.h"

@interface MagicMoveTransitionAnimation : CYLBaseTransitionAnimation
@property (nonatomic, assign) CYLTransitionStyle style;
+(instancetype)shareAnimator;
@end
