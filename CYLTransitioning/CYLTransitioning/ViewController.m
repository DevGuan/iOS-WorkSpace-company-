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
#import "MagicMoveTransitionAnimation.h"

@interface ViewController ()<UINavigationControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.delegate = self;
//    [self magicMove];
    [self spread];
}

- (void)magicMove
{
    self.smallImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"haiti"]];
    self.smallImageView.frame = CGRectMake(20, 120, 100, 100);
    self.smallImageView.userInteractionEnabled = YES;
    [self.smallImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)]];
    [self.view addSubview:self.smallImageView];
}

- (void)tap
{
    [self doThing];
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

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = touches.anyObject;
    CGPoint p = [touch preciseLocationInView:self.view];
    _smallImageView.center = p;
}

- (void)spread
{
    _spreadBtn = [[UIButton alloc] initWithFrame:CGRectMake(150, 500, 40, 40)];
    _spreadBtn.backgroundColor = [UIColor purpleColor];
    _spreadBtn.layer.cornerRadius = 20;
    [_spreadBtn addTarget:self action:@selector(doThing) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_spreadBtn];
    
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
        return [CYLTansitionManager transitionObjectwithTransitionStyle:operation == UINavigationControllerOperationPush ? CYLTransitionStyle_Push : CYLTransitionStyle_Pop animateDuration:0.5 andTransitionAnimation:[[SpreadTransitionAnimation alloc] init]];
    
//    return [CYLTansitionManager transitionObjectwithTransitionStyle:operation == UINavigationControllerOperationPush ? CYLTransitionStyle_Push : CYLTransitionStyle_Pop animateDuration:0.5 andTransitionAnimation:[[MagicMoveTransitionAnimation alloc] init]];
}

@end
