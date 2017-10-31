//
//  ViewController.m
//  RollingStars
//
//  Created by 迟钰林 on 2017/10/12.
//  Copyright © 2017年 迟钰林. All rights reserved.
//

#import "ViewController.h"
#import <CoreMotion/CoreMotion.h>

@interface ViewController ()
@property (nonatomic, strong) NSMutableArray *picsArr;
@property (nonatomic, assign) NSInteger numOfBalls;
@property (nonatomic, strong) UIDynamicAnimator *animator;

@property (nonatomic, strong) UIGravityBehavior *gravityBehavior;
@property (nonatomic, strong) UICollisionBehavior *collisionBehavior;
@property (nonatomic, strong) UIDynamicItemBehavior *dynamicItemBehavior;
@property (nonatomic, strong) CMMotionManager *motionManager;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _numOfBalls = 30;
    
    [self configBalls];
    
    [self setUpBallProperty];
    
    [self setGyroPush];
}




//- (NSString*)crypt
//{
//    NSInteger time = [[NSDate date] timeIntervalSince1970];
//    NSString *json = [NSString stringWithFormat:@"{\"mk@9040Zi\":%ld, \"os\": \"ios\"}",(long)time];
//    NSString *hexString = [self hexStringFromString:json];
//    
//    NSString *subString = [hexString substringWithRange:NSMakeRange(0, 15)];
//    hexString = [hexString stringByReplacingOccurrencesOfString:subString withString:@""];
//    
//    subString = [self fanZhuan:subString];
//    
//    NSString *subSubString = [subString substringWithRange:NSMakeRange(6, 4)];
//    
//    subSubString = [self fanZhuan:subSubString];
//    
//    subString = [subString stringByReplacingCharactersInRange:NSMakeRange(6, 4) withString:subSubString];
//    
//    subString = [NSString stringWithFormat:@"%@%@",subString,hexString];
//    return subString;
//}
//
//- (NSString *)hexStringFromString:(NSString *)string{
//    NSData *myD = [string dataUsingEncoding:NSUTF8StringEncoding];
//    Byte *bytes = (Byte *)[myD bytes];
//    //下面是Byte 转换为16进制。
//    NSString *hexStr=@"";
//    for(int i=0;i<[myD length];i++)
//        
//    {
//        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff];///16进制数
//        
//        if([newHexStr length]==1)
//            
//            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
//        
//        else
//            
//            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];   
//    }   
//    return hexStr;   
//}
//
//- (NSString *)fanZhuan:(NSString *)str{
//    
//    unsigned long len;
//    len = [str length];
//    unichar a[len];
//    for(int i = 0; i < len; i++)
//    {
//        unichar c = [str characterAtIndex:len-i-1];
//        a[i] = c;
//    }
//    NSString *str1=[NSString stringWithCharacters:a length:len];
//    return  str1;
//}

-(void)viewDidDisappear:(BOOL)animated{
    
    //停止加速仪更新（很重要！）
    [self.motionManager stopAccelerometerUpdates];
}

- (void)configBalls
{
    CGFloat width = 50;
    for (NSInteger i = 0; i < _numOfBalls; i++) {
        
        UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(arc4random()%((int)(self.view.bounds.size.width - width)), arc4random()%((int)(40)), width, width)];
        imgV.backgroundColor = [UIColor purpleColor];
        imgV.layer.cornerRadius = width/2;
        imgV.clipsToBounds = YES;
        imgV.tag = i;
        
        [self.view addSubview:imgV];
        [self.picsArr addObject:imgV];
    }
}

- (void)setUpBallProperty
{
    //重力
    self.gravityBehavior = [[UIGravityBehavior alloc] initWithItems:self.picsArr];
    [self.animator addBehavior:self.gravityBehavior];
    
    //碰撞
    self.collisionBehavior = [[UICollisionBehavior alloc] initWithItems:self.picsArr];
    self.collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    [self.animator addBehavior:self.collisionBehavior];
    
    //弹性
    self.dynamicItemBehavior = [[UIDynamicItemBehavior alloc] initWithItems:self.picsArr];
    self.dynamicItemBehavior.elasticity = 0.7;
    self.dynamicItemBehavior.allowsRotation = YES;
    [self.animator addBehavior:self.dynamicItemBehavior];
}

- (void)setGyroPush
{
    self.motionManager = [[CMMotionManager alloc] init];
    self.motionManager.accelerometerUpdateInterval = 1.0/15.0;
    self.motionManager.deviceMotionUpdateInterval = 1.0/15.0;
    [self.motionManager startDeviceMotionUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMDeviceMotion * _Nullable motion, NSError * _Nullable error) {
        double rotation = atan2(motion.attitude.pitch, motion.attitude.roll);
        self.gravityBehavior.angle = rotation;
    }];
}


- (NSMutableArray *)picsArr
{
    if (!_picsArr) {
        _picsArr = [NSMutableArray array];
    }
    return _picsArr;
}

- (UIDynamicAnimator *)animator
{
    if (!_animator) {
        _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    }
    return _animator;
}
@end
