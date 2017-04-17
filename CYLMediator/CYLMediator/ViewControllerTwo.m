//
//  ViewControllerTwo.m
//  CYLMediator
//
//  Created by GARY on 2017/4/13.
//  Copyright © 2017年 GARY. All rights reserved.
//

#import "ViewControllerTwo.h"
#import "AModel.h"
@interface ViewControllerTwo ()
@property (nonatomic,copy) NSString *userName;
@property (nonatomic,copy) NSNumber *userID;
@property (nonatomic,copy) NSString *passWord;
@property (nonatomic,strong) AModel *model;
@end

@implementation ViewControllerTwo

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blueColor];
    
    NSLog(@"%@,%@,%@",self.userName,self.userID,self.passWord);
    NSLog(@"%@",[self.model description]);
}

@end
