//
//  ViewControllerTwo.m
//  CYLTransitioning
//
//  Created by 迟钰林 on 2017/6/16.
//  Copyright © 2017年 迟钰林. All rights reserved.
//

#import "ViewControllerTwo.h"
#import "CYLTransitionHeader.h"
#import "SpreadTransitionAnimation.h"

@interface ViewControllerTwo ()<UIViewControllerTransitioningDelegate>
@property (nonatomic, strong) UIButton *spreadBtn;
@end

@implementation ViewControllerTwo

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self magicMove];
}

- (void)magicMove
{
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
    self.imageView.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2);
    [self.view addSubview:self.imageView];
}

- (void)doThing
{
    [self.navigationController popViewControllerAnimated:YES];
}


//- (void)spead
//{
//    //    self.transitioningDelegate = self;
//    ////    self.navigationController.delegate = self;
//    //    self.modalPresentationStyle = UIModalPresentationCustom;
//    
//    _spreadBtn = [[UIButton alloc] initWithFrame:CGRectMake(200, 300, 40, 40)];
//    _spreadBtn.backgroundColor = [UIColor redColor];
//    _spreadBtn.layer.cornerRadius = 20;
//    [_spreadBtn addTarget:self action:@selector(doThing) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:_spreadBtn];
//
//}

//- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
//{
//    return [CYLTansitionManager transitionObjectwithTransitionStyle:CYLTransitionStyle_Dismiss animateDuration:0.5 andTransitionAnimation:[[SpreadTransitionAnimation alloc] init]];
//}
//
//- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
//{
//    return [CYLTansitionManager transitionObjectwithTransitionStyle:CYLTransitionStyle_Present animateDuration:0.5 andTransitionAnimation:[[SpreadTransitionAnimation alloc] init]];
//}
//
@end
