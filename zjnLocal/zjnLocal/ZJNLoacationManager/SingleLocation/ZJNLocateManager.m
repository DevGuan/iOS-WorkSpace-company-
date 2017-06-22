//
//  ZJNLocateManager.m
//  zjnLocal
//
//  Created by 迟钰林 on 2017/6/21.
//  Copyright © 2017年 迟钰林. All rights reserved.
//

#import "ZJNLocateManager.h"
#define DefaultLocationTimeout  6
#define DefaultReGeocodeTimeout 3

@implementation ZJNLocateManager
static ZJNLocateManager* _instance = nil;
#warning 此高德框架集成了idfa 上架时需要注意
+(instancetype) shareInstance
{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init] ;
        [_instance configLocationManager];
        
    }) ;
    
    return _instance ;
}

- (void)requestLocationWithCompleteBlock:(AMapLocatingCompletionBlock)completeBlock
{
    [self.locationManager requestLocationWithReGeocode:YES completionBlock:completeBlock];
}

- (void)configLocationManager
{
    self.locationManager = [[AMapLocationManager alloc] init];
    
    [self.locationManager setDelegate:self];
    
    //设置期望定位精度
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
    
    //设置不允许系统暂停定位
    [self.locationManager setPausesLocationUpdatesAutomatically:NO];
    
    //设置允许在后台定位
    [self.locationManager setAllowsBackgroundLocationUpdates:YES];
    
    //设置定位超时时间
    [self.locationManager setLocationTimeout:DefaultLocationTimeout];
    
    //设置逆地理超时时间
    [self.locationManager setReGeocodeTimeout:DefaultReGeocodeTimeout];
    
    //设置开启虚拟定位风险监测，可以根据需要开启
    [self.locationManager setDetectRiskOfFakeLocation:NO];
}


@end
