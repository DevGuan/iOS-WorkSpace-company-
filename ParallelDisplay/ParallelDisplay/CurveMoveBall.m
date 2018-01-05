//
//  CurveMoveBall.m
//  ParallelDisplay
//
//  Created by 迟钰林 on 2017/11/9.
//  Copyright © 2017年 迟钰林. All rights reserved.
//

#import "CurveMoveBall.h"

@interface CurveMoveBall()

@end

@implementation CurveMoveBall

+ (void)ballMoveFromPoint:(CGPoint)fromPoint toPoint:(CGPoint)toPoint onView:(UIView *)view
{
    CALayer *ball = [[CALayer alloc] init];
    ball.frame = CGRectMake(fromPoint.x, fromPoint.y, 30, 30);
    ball.cornerRadius = 15;
    ball.backgroundColor = [UIColor redColor].CGColor;
    [view.layer addSublayer:ball];
    
    UIBezierPath *curvePath = [[UIBezierPath alloc] init];
    [curvePath moveToPoint:fromPoint];
    [curvePath addQuadCurveToPoint:toPoint controlPoint:CGPointMake(toPoint.x-20, fromPoint.y)];
    
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
    anim.keyPath = @"position";
    anim.path = curvePath.CGPath;
    anim.duration = 0.8;
    anim.removedOnCompletion = NO;
    anim.fillMode = kCAFillModeForwards;
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [ball addAnimation:anim forKey:nil];
}
@end
