//
//  ViewController.m
//  TextFieldCategory
//
//  Created by 迟钰林 on 2017/7/3.
//  Copyright © 2017年 迟钰林. All rights reserved.
//

#import "ViewController.h"
#import "UITextField+Responsable.h"

@interface ViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UITextField *textField2;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(20, 100, 300, 40)];
    _textField.delegate = self;
    _textField.errorPlaceHolder = @"请输入正确的ddd";
    [_textField setUpForCheck];
    [self.view addSubview:_textField];
    
    _textField2 = [[UITextField alloc] initWithFrame:CGRectMake(20, 200, 300, 40)];
    _textField2.borderStyle = UITextBorderStyleRoundedRect;
    _textField2.layer.borderColor = [UIColor grayColor].CGColor;
    [self.view addSubview:_textField2];
}


- (void)textFieldDidEndEditing:(UITextField *)textField
{
   BOOL check = [textField checkInputWithPattern:citizenIDRegex];
    NSLog(@"%d",check);
}

@end
