//
//  ZJNMapView.h
//  zjnLocal
//
//  Created by 迟钰林 on 2017/6/22.
//  Copyright © 2017年 迟钰林. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>

@interface ZJNMapView : UIView
@property (nonatomic, weak) id<MAMapViewDelegate> delegate;
@property (nonatomic, strong) NSArray *annotations;
@property (nonatomic, assign) CLLocationCoordinate2D centerCoordinate;
///是否支持单击地图获取POI信息(默认为YES), 对应的回调是 -(void)mapView:(MAMapView *) didTouchPois:(NSArray *)
@property (nonatomic, assign) BOOL touchPOIEnabled;

- (void)addAnnotationToMapView:(id<MAAnnotation>)annotation;
- (void)removeAnnotation:(id <MAAnnotation>)annotation;
- (void)removeAnnotations:(NSArray *)annotations;
- (void)addAnnotations:(NSArray *)annotations;
- (void)showAnnotations:(NSArray *)annotations animated:(BOOL)animated;
- (NSSet *)annotationsInMapRect:(MAMapRect)mapRect;

/**
 * @brief 选中标注数据对应的view
 * @param annotation 标注数据
 * @param animated 是否有动画效果
 */
- (void)selectAnnotation:(id <MAAnnotation>)annotation animated:(BOOL)animated;

/**
 * @brief 取消选中标注数据对应的view
 * @param annotation 标注数据
 * @param animated 是否有动画效果
 */
- (void)deselectAnnotation:(id <MAAnnotation>)annotation animated:(BOOL)animated;


@end
