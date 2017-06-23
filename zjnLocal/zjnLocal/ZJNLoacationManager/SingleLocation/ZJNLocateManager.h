//
//  ZJNLocateManager.h
//  zjnLocal
//
//  Created by 迟钰林 on 2017/6/21.
//  Copyright © 2017年 迟钰林. All rights reserved.
//

/*
 系统依赖库
 JavaScriptcore.framework 基础库 1.3.0版本、定位2.1.1版本之后必需
 SystemConfiguration.framework
 CoreTelephony.framework
 libz.dylib iOS 9之前
 libc++.dylib iOS 9之前
 libstdc++.6.0.9.dylib iOS 9之前
 libz.tbd iOS 9之后
 libc++.tbd iOS 9之后
 libstdc++.6.0.9.tbd iOS 9之后
 Security.framework
 GLKit
 －*/

#import <Foundation/Foundation.h>
#import <MAMapKit/MAMapKit.h>
#import <AMapLocationKit/AMapLocationKit.h>

@interface ZJNLocateManager : NSObject<AMapLocationManagerDelegate>
@property (nonatomic, strong) AMapLocationManager *locationManager;

+ (instancetype) shareInstance;

//单次获取当前定位
- (void)requestLocationWithCompleteBlock:(AMapLocatingCompletionBlock)completeBlock;

//提示是否去开启定位
- (BOOL)isOpenGpsWithViewController:(UIViewController*)viewController;
@end
