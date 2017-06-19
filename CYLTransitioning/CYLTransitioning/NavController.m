//
//  NavController.m
//  CYLTransitioning
//
//  Created by 迟钰林 on 2017/6/19.
//  Copyright © 2017年 迟钰林. All rights reserved.
//

#import "NavController.h"
#import "CYLTransitionHeader.h"
#import "SpreadTransitionAnimation.h"

@interface NavController ()<UINavigationControllerDelegate>

@end

@implementation NavController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    return [CYLTansitionManager transitionObjectwithTransitionStyle:operation == UINavigationControllerOperationPush ? CYLTransitionStyle_Push : CYLTransitionStyle_Pop animateDuration:0.5 andTransitionAnimation:[[SpreadTransitionAnimation alloc] init]];
}

@end
