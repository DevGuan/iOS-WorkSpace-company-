//
//  ZJNPoiSearchManager.h
//  zjnLocal
//
//  Created by 迟钰林 on 2017/6/21.
//  Copyright © 2017年 迟钰林. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import "POIAnnotation.h"

typedef void(^searchComplete)(AMapPOISearchResponse *response);

@interface ZJNPoiSearchManager : NSObject

@property (nonatomic, strong) AMapSearchAPI *search;

+ (instancetype) shareInstance;

//根据关键字搜索poi
- (void)requestAPoiKeywordsSearch:(NSString*)keyWords city:(NSString*)city responseResolveBy:(id<AMapSearchDelegate>)receiver;
//根据关键字搜索周围的poi
- (void)requestAroundPoiWithKeyWords:(NSString*)keyWords location:(CLLocation*)location responseResolveBy:(id<AMapSearchDelegate>)receiver;
//根据输入的查询关键字联想给出poi
- (void)requestInputTipsSearch:(NSString*)keyWords city:(NSString*)city responseResolveBy:(id<AMapSearchDelegate>)receiver;
@end
