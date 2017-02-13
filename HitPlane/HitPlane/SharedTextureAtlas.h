//
//  SharedTextureAtlas.h
//  HitPlane
//
//  Created by GARY on 2017/2/10.
//  Copyright © 2017年 GARY. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

typedef NS_ENUM(NSInteger,SKTextureType)
{
    SKTextureTypeBackGround = 1,
    SKTextureTypeBullet = 2,
    SKTextureTypeSmallFoePlane = 3,
    SKTextureTypeMediumFoePlane = 4,
    SKTextureTypeBigFoePlane = 5,
    SKTextureTypePlayerPlane = 6
    
};

@interface SharedTextureAtlas : SKTextureAtlas
+ (SharedTextureAtlas*)shared;
+ (SKTexture*)textureWithType:(SKTextureType)type;
@end
