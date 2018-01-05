//
//  ParallelView.m
//  ParallelDisplay
//
//  Created by 迟钰林 on 2017/11/9.
//  Copyright © 2017年 迟钰林. All rights reserved.
//

#import "ParallelView.h"
#import <CoreMotion/CoreMotion.h>

@interface ParallelView()
@property (nonatomic, strong) CMMotionManager *myManager;
@property (nonatomic, strong) UIImageView *imageV;
@end

@implementation ParallelView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setUI];
        [self setMotionAction];
    }
    return self;
}

- (void)setUI{
    self.layer.cornerRadius = 15;
    self.imageV = [[UIImageView alloc] initWithFrame:self.bounds];
    self.imageV.image = [UIImage imageNamed:@"WechatIMG10.jpeg"];
    [self addSubview:self.imageV];
}

- (void)setMotionAction{
    self.myManager = [[CMMotionManager alloc] init];
    self.myManager.gyroUpdateInterval = 1.0/5;
    if ([self.myManager isGyroAvailable]) {
        
        [self.myManager startDeviceMotionUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMDeviceMotion * _Nullable motion, NSError * _Nullable error) {
            double gravityX = motion.gravity.x;
            double gravityY = motion.gravity.y;
            double gravityZ = motion.gravity.z;
            
            double zTheta = atan2(gravityZ,sqrtf(gravityX*gravityX+gravityY*gravityY))/M_PI*180.0;
            double xyTheta = atan2(motion.gravity.x, motion.gravity.z)*180/M_PI + 180.0;
            
            //z轴
            double zAngle = (zTheta + 90.0) * (M_PI/180.0);
            double xyAngle = (xyTheta) * (M_PI/180.0);
            
//            NSLog(@"%f",xyTheta);
            //地平线夹角
//            NSLog(@"aaaaa%f",(xyTheta));
            //俯仰角
//            NSLog(@"bbbbb%.0f",(atan2(motion.gravity.z, motion.gravity.x)+M_PI_2)*180/M_PI);
            
            CATransform3D trans = CATransform3DPerspect(CATransform3DMakeRotation(xyAngle, 0, 1, 0), CGPointMake(0, 0), 500);
            self.layer.transform = CATransform3DRotate(trans, zAngle, 1, 0, 0);
            
        }];
    }
}

CATransform3D CATransform3DMakePerspective(CGPoint center, float disZ)
{
    CATransform3D transToCenter = CATransform3DMakeTranslation(-center.x, -center.y, 0);
    CATransform3D transBack = CATransform3DMakeTranslation(center.x, center.y, 0);
    CATransform3D scale = CATransform3DIdentity;
    scale.m34 = -1.0f/disZ;
    return CATransform3DConcat(CATransform3DConcat(transToCenter, scale), transBack);
}

CATransform3D CATransform3DPerspect(CATransform3D t, CGPoint center, float disZ)
{
    return CATransform3DConcat(t, CATransform3DMakePerspective(center, disZ));
}
@end
