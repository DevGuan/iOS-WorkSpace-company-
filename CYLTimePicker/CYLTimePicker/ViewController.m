//
//  ViewController.m
//  CYLTimePicker
//
//  Created by 迟钰林 on 2017/6/22.
//  Copyright © 2017年 迟钰林. All rights reserved.
//

#import "ViewController.h"
#import "CYLTimePicker.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CYLTimePicker *p = [[CYLTimePicker alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, 250)];
    [self.view addSubview:p];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
