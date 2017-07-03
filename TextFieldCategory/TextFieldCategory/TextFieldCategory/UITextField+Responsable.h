//
//  UITextField+Responsable.h
//  TextFieldCategory
//
//  Created by 迟钰林 on 2017/7/3.
//  Copyright © 2017年 迟钰林. All rights reserved.
//

#import <UIKit/UIKit.h>

static const NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
static const NSString *mobileRegex = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[0678])\\d{8}$";
static const NSString *urlRegex = @"[a-zA-z]+://[^\\s]*";
static const NSString *citizenIDRegex = @"\\d{15}|\\d{18}";

@interface UITextField (Responsable)
@property (nonatomic, strong) UIColor *selectedColor;
@property (nonatomic, strong) UIColor *errorColor;
@property (nonatomic, strong) UIColor *passColor;
@property (nonatomic, assign) BOOL isSetUpForCheck;

/**
 错误时显示的提示语
 */
@property (nonatomic, strong) NSString *errorPlaceHolder;

//用于check功能的准备
- (void)setUpForCheck;

//检查输入的字符串是否符合正则表达式
- (BOOL)checkInputWithPattern:(NSString*)pattern;
@end
