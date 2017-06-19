//
//  ViewController.m
//  CYLTransitioning
//
//  Created by 迟钰林 on 2017/6/15.
//  Copyright © 2017年 迟钰林. All rights reserved.
//

#import "ViewController.h"
#import "ViewControllerTwo.h"
#import "CYLTransitionHeader.h"
#import "SpreadTransitionAnimation.h"

@interface ViewController ()<UINavigationControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _spreadBtn = [[UIButton alloc] initWithFrame:CGRectMake(150, 500, 40, 40)];
    _spreadBtn.backgroundColor = [UIColor purpleColor];
    _spreadBtn.layer.cornerRadius = 20;
    [_spreadBtn addTarget:self action:@selector(doThing) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_spreadBtn];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}

- (void)doThing
{
//    [self.navigationController presentViewController:[[ViewControllerTwo alloc] init] animated:YES completion:nil];
    [self.navigationController pushViewController:[[ViewControllerTwo alloc] init] animated:YES];
}

//- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    UITouch *touch = touches.anyObject;
//    CGPoint p = [touch preciseLocationInView:self.view];
//    _spreadBtn.center = p;
//}
@end
