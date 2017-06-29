//
//  ZJNLoacationWithMapController.m
//  zjnLocal
//
//  Created by 迟钰林 on 2017/6/21.
//  Copyright © 2017年 迟钰林. All rights reserved.
//

#import "ZJNLoacationWithMapController.h"
#import "ZJNMapView.h"

#define DefaultLocationTimeout  6
#define DefaultReGeocodeTimeout 3

@interface ZJNLoacationWithMapController ()<MAMapViewDelegate,AMapSearchDelegate>
@property (nonatomic, strong) ZJNMapView *mapView;
@property (nonatomic, strong) ZJNLocateManager *locationManager;
@end

@implementation ZJNLoacationWithMapController

- (void)viewDidLoad
{
    [self initMapView];
    [self pinToCurrentLocation];
}

- (void)pinToCurrentLocation
{
    [[ZJNLocateManager shareInstance] requestLocationWithCompleteBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        
        //根据定位信息，添加annotation
        MAPointAnnotation *annotation = [[MAPointAnnotation alloc] init];
        [annotation setCoordinate:location.coordinate];
        
        //有无逆地理信息，annotationView的标题显示的字段不一样
        if (regeocode)
        {
            [annotation setTitle:[NSString stringWithFormat:@"%@", regeocode.formattedAddress]];
            [annotation setSubtitle:[NSString stringWithFormat:@"%@-%@-%.2fm", regeocode.citycode, regeocode.adcode, location.horizontalAccuracy]];
        }
        else
        {
            [annotation setTitle:[NSString stringWithFormat:@"lat:%f;lon:%f;", location.coordinate.latitude, location.coordinate.longitude]];
            [annotation setSubtitle:[NSString stringWithFormat:@"accuracy:%.2fm", location.horizontalAccuracy]];
        }
        
        
        
//        [self.mapView addAnnotationToMapView:annotation];
        
    }];

}

- (void)initMapView{
    
    if (self.mapView == nil) {
        self.mapView = [[ZJNMapView alloc] initWithFrame:self.view.bounds];
        self.mapView.delegate = self;
        [self.view addSubview:self.mapView];
    }
    
}

#pragma mark - Method


#pragma mark - MAMapView Delegate

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *pointReuseIndetifier = @"pointReuseIndetifier";
        
        MAPinAnnotationView *annotationView = (MAPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndetifier];
        }
        
        annotationView.canShowCallout   = YES;
        annotationView.animatesDrop     = YES;
        annotationView.draggable        = NO;
        annotationView.pinColor         = MAPinAnnotationColorPurple;
        
        return annotationView;
    }
    
    return nil;
}

#pragma mark - poi delegate
/* POI 搜索回调. */
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response
{
    [self.mapView removeAnnotations:self.mapView.annotations];
    
    if (response.pois.count == 0)
    {
        return;
    }
    
    NSMutableArray *poiAnnotations = [NSMutableArray arrayWithCapacity:response.pois.count];
    
    [response.pois enumerateObjectsUsingBlock:^(AMapPOI *obj, NSUInteger idx, BOOL *stop) {
        [poiAnnotations addObject:[[POIAnnotation alloc] initWithPOI:obj]];
        NSLog(@"%@",obj.name);
    }];
    
    /* 将结果以annotation的形式加载到地图上. */
    [self.mapView addAnnotations:poiAnnotations];
    
    /* 如果只有一个结果，设置其为中心点. */
    if (poiAnnotations.count == 1)
    {
        [self.mapView setCenterCoordinate:[poiAnnotations[0] coordinate]];
    }
    /* 如果有多个结果, 设置地图使所有的annotation都可见. */
    else
    {
        [self.mapView showAnnotations:poiAnnotations animated:NO];
    }
}

- (void)onInputTipsSearchDone:(AMapInputTipsSearchRequest *)request response:(AMapInputTipsSearchResponse *)response
{
    
}


@end
