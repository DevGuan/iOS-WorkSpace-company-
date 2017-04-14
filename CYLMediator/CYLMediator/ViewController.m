//
//  ViewController.m
//  CYLMediator
//
//  Created by GARY on 2017/4/12.
//  Copyright © 2017年 GARY. All rights reserved.
//

#import "ViewController.h"
#import "CYLMediator.h"
#import "AModel.h"
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
//    [[CYLMediator sharedMediator] mediatorPresentViewContoller:@"ViewControllerTwo" andParame:@"userID=37&userName=CYL&passWord=73635273" completeHandler:^(NSDictionary *params) {
//      
//        [self.navigationController pushViewController:params[ViewControllerKey] animated:YES];
//        
//        for (NSString *key in params.allKeys) {
//            NSLog(@"key:%@  value:%@", key, params[key]);
//        }
//    }];
    
    AModel *model = [[AModel alloc] initWithName:@"吃钰林" uid:@"22" password:@"password"];
    
//    [[CYLMediator sharedMediator] mediatorPresentViewContoller:@"ViewControllerTwo" withModelObject:model completeHandler:^(NSDictionary *params) {
//       
//        [self.navigationController pushViewController:params[ViewControllerKey] animated:YES];
//        
//                for (NSString *key in params.allKeys) {
//                    NSLog(@"key:%@  value:%@", key, params[key]);
//                }
//    }];
    
    [[CYLMediator sharedMediator] mediatorPresentViewContoller:@"ViewControllerTwo" withModelObject:model andParam:@"userID=37&userName=CYL&passWord=73635273" completeHandler:^(NSDictionary *params) {
        [self.navigationController pushViewController:params[ViewControllerKey] animated:YES];
        
        for (NSString *key in params.allKeys) {
            NSLog(@"key:%@  value:%@", key, params[key]);
        }
    }];
}


@end
