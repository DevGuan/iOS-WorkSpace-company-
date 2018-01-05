//
//  ViewController.m
//  ParallelDisplay
//
//  Created by 迟钰林 on 2017/11/9.
//  Copyright © 2017年 迟钰林. All rights reserved.
//

#import "ViewController.h"
#import "ParallelView.h"
#import "CurveMoveBall.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    CGSize mainScreenSize = [UIScreen mainScreen].bounds.size;
//    ParallelView *pv = [[ParallelView alloc] initWithFrame:CGRectMake(mainScreenSize.width/2-110, mainScreenSize.height/2-110, 220, 220)];
//    pv.backgroundColor = [UIColor cyanColor];
//    [self.view addSubview:pv];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint cur = [[touches anyObject] locationInView:self.view];
    CGRect bounds = [UIScreen mainScreen].bounds;
    [CurveMoveBall ballMoveFromPoint:cur toPoint:CGPointMake(bounds.size.width/2, bounds.size.height) onView:self.view];
}


@end
