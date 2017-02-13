//
//  FoePlane.h
//  HitPlane
//
//  Created by GARY on 2017/2/10.
//  Copyright © 2017年 GARY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SharedTextureAtlas.h"

@interface FoePlane : SKSpriteNode
@property (nonatomic,assign) NSInteger hp;
@property (nonatomic,assign) SKTextureType type;

+ (NSMutableArray*)collesionActionByType:(SKTextureType)type;
@end
