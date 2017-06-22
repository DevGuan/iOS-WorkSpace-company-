//
//  ViewController.m
//  zjnLocal
//
//  Created by 迟钰林 on 2017/6/21.
//  Copyright © 2017年 迟钰林. All rights reserved.
//

#import "ViewController.h"
#import "ZJNLoacationWithMapController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    ZJNLoacationWithMapController *mapv = [[ZJNLoacationWithMapController alloc] init];
    [self.view addSubview:mapv.view];
    [self addChildViewController:mapv];
    
}



@end
