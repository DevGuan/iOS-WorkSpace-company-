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

+(instancetype) shareInstance
{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init] ;
        [_instance configLocationManager];
        
    }) ;
    
    return _instance ;
}

- (BOOL)isOpenGpsWithViewController:(UIViewController*)viewController
{
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    BOOL isOpen = true;
    
    if (kCLAuthorizationStatusDenied == status || kCLAuthorizationStatusRestricted == status) {
        isOpen = false;
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"您的定位尚未开启，是否前去开启定位" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        }];
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"再等等" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alertC addAction:action];
        [alertC addAction:cancel];
        [viewController.navigationController presentViewController:alertC animated:YES completion:nil];
    }
    return isOpen;
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
