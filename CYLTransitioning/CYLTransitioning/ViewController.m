//
//  ViewController.m
//  CYLTransitioning
//
//  Created by 迟钰林 on 2017/6/26.
//  Copyright © 2017年 迟钰林. All rights reserved.
//

#import "ViewController.h"
#import "CYLTimePicker.h"
#import "CYLCardPopUpController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)test
{
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(200, 200, 44, 44)];
    btn.backgroundColor = [UIColor purpleColor];
    [btn addTarget:self action:@selector(push) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)push
{
    CYLTimePicker *timePicker = [[CYLTimePicker alloc] initWithFrame:CGRectMake(0, 0, 375, 300)];
    CYLCardPopUpController *ccv = [[CYLCardPopUpController alloc] initWithDisplayLayer:timePicker];
    [self.navigationController pushViewController:ccv animated:YES];
}
@end
