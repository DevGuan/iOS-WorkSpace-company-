//
//  SharedTextureAtlas.m
//  HitPlane
//
//  Created by GARY on 2017/2/10.
//  Copyright © 2017年 GARY. All rights reserved.
//

#import "SharedTextureAtlas.h"

static SharedTextureAtlas *share = nil;
@implementation SharedTextureAtlas

+ (SharedTextureAtlas*)shared
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        share = (SharedTextureAtlas*)[SharedTextureAtlas atlasNamed:@"gameArts-hd"];
    });
    return share;
}

+ (SKTexture*)textureWithType:(SKTextureType)type
{
    SKTexture *texture = [[SKTexture alloc] init];
    switch (type) {
        case SKTextureTypeBackGround:
            texture = [[[self class] shared] textureNamed:@"background_2.png"];
            break;
        case SKTextureTypeBullet:
            texture = [[[self class] shared] textureNamed:@"bullet2.png"];
            break;
        case SKTextureTypePlayerPlane:
            texture = [[[self class] shared] textureNamed:@"hero_fly_1.png"];
            break;
        case SKTextureTypeSmallFoePlane:
            texture = [[[self class] shared] textureNamed:@"enemy1_fly_1.png"];
            break;
        case SKTextureTypeMediumFoePlane:
            texture = [[[self class] shared] textureNamed:@"enemy3_fly_1.png"];
            break;
        case SKTextureTypeBigFoePlane:
            texture = [[[self class] shared] textureNamed:@"enemy2_fly_1.png"];
            break;
            
        default:
            break;
    }
    return texture;
}

@end
