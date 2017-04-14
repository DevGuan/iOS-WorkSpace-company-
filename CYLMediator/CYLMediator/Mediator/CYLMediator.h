//
//  CYLMediator.h
//  CYLMediator
//
//  Created by GARY on 2017/4/12.
//  Copyright © 2017年 GARY. All rights reserved.
//

#import <Foundation/Foundation.h>

#define ViewControllerKey @"ViewController"

@interface CYLMediator : NSObject
+ (instancetype)sharedMediator;


/**
 带参数 跳转到目标控制器
 
 @param className 目标控制器的类名字符串
 @param param 参数 param1=11&param2=long&param3=0122
 @param handler 返回参数字典
 */
- (void)mediatorPresentViewContoller:(NSString*)className andParame:(NSString*)param completeHandler:(void(^)(NSDictionary*))handler;


/**
 带参数 跳转到目标控制器
 
 @param className 目标控制器的类名字符串
 @param model 传入模型
 @param handler 返回参数字典
 */
- (void)mediatorPresentViewContoller:(NSString*)className withModelObject:(id)model completeHandler:(void(^)(NSDictionary*))handler;

- (void)mediatorPresentViewContoller:(NSString*)className withModelObject:(id)model andParam:(NSString *)param completeHandler:(void(^)(NSDictionary*))handler;
@end
