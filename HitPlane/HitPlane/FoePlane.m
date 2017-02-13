//
//  FoePlane.m
//  HitPlane
//
//  Created by GARY on 2017/2/10.
//  Copyright © 2017年 GARY. All rights reserved.
//

#import "FoePlane.h"

@implementation FoePlane

- (void)setType:(SKTextureType)type
{
    _type = type;
    
    switch (type) {
        case SKTextureTypeSmallFoePlane:
            _hp = 1;
            break;
        case SKTextureTypeMediumFoePlane:
            _hp = 3;
            break;
        case SKTextureTypeBigFoePlane:
            _hp = 5;
            break;
        default:
            _hp = 1;
            break;
    }
}

+ (NSMutableArray*)collesionActionByType:(SKTextureType)type
{
    NSMutableArray *textures = [NSMutableArray array];
    switch (type) {
        case SKTextureTypeSmallFoePlane:
            for (int i = 1; i <5; i++) {
                SKTexture *texture = [SKTexture textureWithImageNamed:[NSString stringWithFormat:@"enemy1_blowup_%d.png",i]];
                [textures addObject:texture];
            }
            break;
            
        case SKTextureTypeMediumFoePlane:
            for (int i = 1; i <8; i++) {
                
                SKTexture *texture = [SKTexture textureWithImageNamed:[NSString stringWithFormat:@"enemy2_blowup_%d.png",i]];
                [textures addObject:texture];
            }
            break;
            
        case SKTextureTypeBigFoePlane:
            for (int i = 1; i <5; i++) {
                
                SKTexture *texture = [SKTexture textureWithImageNamed:[NSString stringWithFormat:@"enemy3_blowup_%d.png",i]];
                [textures addObject:texture];
            }
            break;
            
        default:
            break;
    }
    
    return textures;
}

@end
