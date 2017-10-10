//
//  ViewController.m
//  CYLTransitioning
//
//  Created by 迟钰林 on 2017/6/26.
//  Copyright © 2017年 迟钰林. All rights reserved.
//

#import "ViewController.h"
#import "CYLCardPopUpController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self test];
    
}

- (void)test
{
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(200, 200, 44, 44)];
    btn.backgroundColor = [UIColor purpleColor];
    [btn addTarget:self action:@selector(push) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *imagV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"haiti"]];
    imagV.frame = CGRectMake(0, 100, 300, 300);
    [self.view addSubview:imagV];
    [self.view addSubview:btn];
}

- (void)push
{
//    CYLTimePicker *timePicker = [[CYLTimePicker alloc] initWithFrame:CGRectMake(0, 0, 375, 300)];
//    CYLCardPopUpController *ccv = [[CYLCardPopUpController alloc] initWithDisplayLayer:timePicker];
//    timePicker.header.didClickCancleBtnBlock = ^{
//        [ccv dismissViewControllerAnimated:YES completion:nil];
//    };
//    [self.navigationController presentViewController:ccv animated:YES completion:nil];
}
@end
