//
//  ZJNMapView.m
//  zjnLocal
//
//  Created by 迟钰林 on 2017/6/22.
//  Copyright © 2017年 迟钰林. All rights reserved.
//

#import "ZJNMapView.h"

@interface ZJNMapView ()
@property (nonatomic, strong) MAMapView *mapView;
@end

@implementation ZJNMapView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initMapView];
    }
    return self;
}


- (void)initMapView
{
    if (self.mapView == nil)
    {
        self.mapView = [[MAMapView alloc] initWithFrame:self.bounds];
        [self.mapView setDelegate:_delegate];
        
        [self addSubview:self.mapView];
    }
}

#pragma mark - MAMapView Method
- (void)addAnnotationToMapView:(id<MAAnnotation>)annotation
{
    [self.mapView addAnnotation:annotation];
    [self.mapView selectAnnotation:annotation animated:YES];
    [self.mapView setZoomLevel:15.1 animated:NO];
    [self.mapView setCenterCoordinate:annotation.coordinate animated:YES];
}

- (void)removeAnnotations:(NSArray *)annotations
{
    [self.mapView removeAnnotations:annotations];
}

- (void)addAnnotations:(NSArray *)annotations
{
    [self.mapView addAnnotations:annotations];
}

- (void)showAnnotations:(NSArray *)annotations animated:(BOOL)animated
{
    [self.mapView showAnnotations:annotations animated:animated];
}

- (void)removeAnnotation:(id <MAAnnotation>)annotation
{
    [self.mapView removeAnnotation:annotation];
}

- (NSSet *)annotationsInMapRect:(MAMapRect)mapRect;
{
    return [self.mapView annotationsInMapRect:mapRect];
}

- (void)selectAnnotation:(id <MAAnnotation>)annotation animated:(BOOL)animated
{
    [self.mapView selectAnnotation:annotation animated:YES];
}


- (void)deselectAnnotation:(id <MAAnnotation>)annotation animated:(BOOL)animated
{
    [self.mapView deselectAnnotation:annotation animated:YES];
}

- (void)setTouchPOIEnabled:(BOOL)touchPOIEnabled
{
    [self.mapView setTouchPOIEnabled:touchPOIEnabled];
}

#pragma mark - getter setter
- (void)setDelegate:(id<MAMapViewDelegate>)delegate
{
    _delegate = delegate;
    [self.mapView setDelegate:delegate];
}

- (NSArray *)annotations
{
    return self.mapView.annotations;
}

- (void)setCenterCoordinate:(CLLocationCoordinate2D)centerCoordinate
{
    _centerCoordinate = centerCoordinate;
    [self.mapView setCenterCoordinate:centerCoordinate];
}
@end
