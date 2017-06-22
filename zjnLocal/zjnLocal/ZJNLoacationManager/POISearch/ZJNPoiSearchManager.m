
//
//  ZJNPoiSearchManager.m
//  zjnLocal
//
//  Created by 迟钰林 on 2017/6/21.
//  Copyright © 2017年 迟钰林. All rights reserved.
//

#import "ZJNPoiSearchManager.h"

@implementation ZJNPoiSearchManager

static ZJNPoiSearchManager* _instance = nil;

+(instancetype) shareInstance
{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init] ;
        _instance.search = [[AMapSearchAPI alloc] init];
    }) ;
    
    return _instance ;
}

- (void)requestAPoiKeywordsSearch:(NSString *)keyWords city:(NSString *)city responseResolveBy:(id)receiver
{
    AMapPOIKeywordsSearchRequest *req = [[AMapPOIKeywordsSearchRequest alloc] init];
    self.search.delegate = receiver;
    req.keywords = keyWords;
    req.city = city;
    req.cityLimit = YES;
    
    [self.search AMapPOIKeywordsSearch:req];
}

- (void)requestAroundPoiWithKeyWords:(NSString *)keyWords location:(CLLocation *)location responseResolveBy:(id)receiver
{
    AMapPOIAroundSearchRequest *req = [[AMapPOIAroundSearchRequest alloc] init];
    self.search.delegate = receiver;
    req.keywords = keyWords;
    req.location = [AMapGeoPoint locationWithLatitude:location.coordinate.latitude longitude:location.coordinate.longitude];
    req.sortrule = 0;
    req.requireExtension = YES;
    
    [self.search AMapPOIAroundSearch:req];
}

- (void)requestInputTipsSearch:(NSString *)keyWords city:(NSString *)city responseResolveBy:(id<AMapSearchDelegate>)receiver
{
    AMapInputTipsSearchRequest *req = [[AMapInputTipsSearchRequest alloc] init];
    req.keywords = keyWords;
    req.city = city;
    req.cityLimit = YES;
    self.search.delegate = receiver;
    
    [self.search AMapInputTipsSearch:req];
}
@end
