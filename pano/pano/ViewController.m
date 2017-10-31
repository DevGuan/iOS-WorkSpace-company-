//
//  ViewController.m
//  pano
//
//  Created by 迟钰林 on 2017/10/13.
//  Copyright © 2017年 迟钰林. All rights reserved.
//

#import "ViewController.h"
#import <CoreMotion/CoreMotion.h>

@import SceneKit;
@import SpriteKit;

static NSInteger cameraFov = 45;
static CGFloat sScaleMax = 3.0;
static CGFloat sScaleMin = 1.0;
static CGFloat camera_Height = 50;

@interface ViewController ()
@property (nonatomic, strong) SCNView *sView;
@property (nonatomic, strong) SCNScene *scene;
@property (nonatomic, strong) SCNNode *cameraNode;
//gesture
@property (nonatomic, assign) CGPoint beginPoint;
@property (nonatomic, assign) CGFloat fingerRotateRecordX;
@property (nonatomic, assign) CGFloat fingerRotateRecordY;

@property (nonatomic, assign) CGFloat curScale;
@property (nonatomic, assign) CGFloat prevScale;

@property (nonatomic, strong) CMMotionManager *motionManager;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view insertSubview:self.sView atIndex:0];
    
    [self configCamera];
    
    [self configPic];
    
    [self configGesture];
    
    [self configMotion];
}

- (void)configCamera
{
    SCNCamera *camera = [SCNCamera camera];
    camera.xFov = cameraFov;
    camera.yFov = cameraFov;
    camera.automaticallyAdjustsZRange = YES;
    
    _cameraNode = [SCNNode node];
    _cameraNode.camera = camera;
    _cameraNode.position = SCNVector3Make(0, 0, 0);
    [self.sView.scene.rootNode addChildNode:_cameraNode];
}

- (void)configPic
{
    SCNNode *panoramaNode = [SCNNode node];
    panoramaNode.geometry = [SCNSphere sphereWithRadius:100];
    panoramaNode.geometry.firstMaterial.cullMode = SCNCullModeFront;
    panoramaNode.geometry.firstMaterial.doubleSided = false;
    panoramaNode.geometry.firstMaterial.diffuse.contents = [UIImage imageNamed:@"sun.jpg"];
    panoramaNode.position = SCNVector3Make(0, 0, 0);
    [self.sView.scene.rootNode addChildNode:panoramaNode];
}

- (void)configGesture
{
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(rotate:)];
    [self.sView addGestureRecognizer:pan];
    
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinch:)];
    [self.sView addGestureRecognizer:pinch];
}

- (void)configMotion
{
    self.motionManager = [[CMMotionManager alloc] init];
    self.motionManager.deviceMotionUpdateInterval = 1.0/60.0;
    [self.motionManager startDeviceMotionUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMDeviceMotion * _Nullable motion, NSError * _Nullable error) {
        SCNVector3 vector = SCNVector3Zero;
        if ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) {
            vector.x = motion.attitude.pitch;
            vector.y = motion.attitude.roll;
        }
        self.cameraNode.eulerAngles = vector;
    }];
}

- (void)rotate:(UIPanGestureRecognizer*)pan
{
    CGPoint curPoint = [pan locationInView:self.sView];
    
    if (pan.state == UIGestureRecognizerStateBegan) {
        self.beginPoint = curPoint;
    }
    else if(pan.state == UIGestureRecognizerStateChanged)
    {
        CGFloat dist_x = curPoint.x - self.beginPoint.x;
        CGFloat dist_y = curPoint.y - self.beginPoint.y;
        
        dist_x *= -0.00015;
        dist_y *= -0.00015;
        
        _fingerRotateRecordX += dist_x;
        _fingerRotateRecordY += dist_y;
        
        SCNMatrix4 modelMatrix = SCNMatrix4MakeRotation(0, 0, 0, 0);
        modelMatrix = SCNMatrix4Rotate(modelMatrix, _fingerRotateRecordX, 0, 1, 0);
        modelMatrix = SCNMatrix4Rotate(modelMatrix, _fingerRotateRecordY, 1, 0, 0);
        self.cameraNode.pivot = modelMatrix;
    }
}


- (void)pinch:(UIPinchGestureRecognizer*)pinch
{
    if (pinch.state != UIGestureRecognizerStateEnded && pinch.state != UIGestureRecognizerStateFailed) {
        
        if (pinch.scale != 0.0) {
            
            CGFloat scale = pinch.scale - 1;
            
            if (scale < 0) {
                scale *= (sScaleMax - sScaleMin);
            }
            
            _curScale = scale + _prevScale;
            _curScale = [self validateScale:_curScale];
            
            CGFloat scaleRatio = 1 - (_curScale - 1) * 0.15;
            
            CGFloat xFov = cameraFov * scaleRatio;
            CGFloat yFov = camera_Height * scaleRatio;
            
            _cameraNode.camera.xFov = xFov;
            _cameraNode.camera.yFov = yFov;
        }
    }else if(pinch.state == UIGestureRecognizerStateEnded)
    {
        _prevScale = _curScale;
    }
}

- (CGFloat)validateScale:(CGFloat)scale
{
    if (scale < sScaleMin) {
        scale = sScaleMin;
    }
    else if (scale > sScaleMax)
    {
        scale = sScaleMax;
    }
    return scale;
}

- (IBAction)resetBtn:(UIButton *)sender {
    [UIView animateWithDuration:0.5 animations:^{
        self.cameraNode.pivot = SCNMatrix4Identity;
    }];
    _fingerRotateRecordX = 0;
    _fingerRotateRecordY = 0;
}

- (SCNView *)sView
{
    if (!_sView) {
        _sView = [[SCNView alloc] initWithFrame:self.view.frame];
        _scene = [[SCNScene alloc] init];
        _sView.scene = _scene;
    }
    return _sView;
}
@end
