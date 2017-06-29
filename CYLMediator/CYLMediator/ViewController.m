//
//  ViewController.m
//  CYLMediator
//
//  Created by GARY on 2017/4/12.
//  Copyright © 2017年 GARY. All rights reserved.
//

#import "ViewController.h"
#import "CYLMediator.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 100, 44, 44)];
    btn.backgroundColor = [UIColor greenColor];
    [btn setTitle:@"tiaozhuan" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(goToControllerTwo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}


- (void)goToControllerTwo
{
    [[CYLMediator sharedMediator] mediatorPresentViewContoller:@"ViewControllerTwo"
                                                 andParameDict:@{@"userName":@"cyl",
                                                                 @"userID":@12,
                                                                 @"passWord":@"233234234"}
                                                completeHandler:^(NSDictionary *dict) {
                                                    
                                                    [self.navigationController pushViewController:dict[ViewControllerKey] animated:YES];
                                                    
    
                                                }];
}


@end
