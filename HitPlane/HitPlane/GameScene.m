//
//  GameScene.m
//  HitPlane
//
//  Created by GARY on 2017/2/10.
//  Copyright © 2017年 GARY. All rights reserved.
//

#import "GameScene.h"
#import "SharedTextureAtlas.h"
#import "FoePlane.h"

// 角色类别
typedef NS_ENUM(uint32_t, SKRoleCategory){
    SKRoleCategoryBullet = 1,
    SKRoleCategoryFoePlane = 4,
    SKRoleCategoryPlayerPlane = 8
};

@interface GameScene ()<SKPhysicsContactDelegate>
@property (nonatomic, strong) SKSpriteNode *backGround1;
@property (nonatomic, strong) SKSpriteNode *backGround2;
@property (nonatomic, strong) SKSpriteNode *playerPlane;
@property (nonatomic, assign) NSInteger adjustmentHeight;
@property (nonatomic, strong) NSTimer *bulletTimer;
@end

@implementation GameScene

- (instancetype)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size]) {
        
        self.physicsWorld.contactDelegate = self;
        self.physicsWorld.gravity = CGVectorMake(0, 0);
        [self initBackGround];
        [self initPlayerPlane];
        [self fireBullet];
        [self initFoePlane];
    }
    return self;
}

- (void)initPlayerPlane
{
    _playerPlane = [SKSpriteNode spriteNodeWithTexture:[SharedTextureAtlas textureWithType:SKTextureTypePlayerPlane]];
    _playerPlane.position = CGPointMake(160, 50);
    
    _playerPlane.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:_playerPlane.size];
    _playerPlane.physicsBody.categoryBitMask = SKRoleCategoryPlayerPlane;
    _playerPlane.physicsBody.contactTestBitMask = SKRoleCategoryFoePlane;
    _playerPlane.physicsBody.collisionBitMask = 0;
    
    [self addChild:_playerPlane];
}

- (void)initFoePlane
{
    __block NSInteger count = 0;
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
        SKTextureType type = SKTextureTypeSmallFoePlane;
        int x = arc4random()%(int)self.size.width;
        x<60 ? x=(x+60) : x;
        x>self.size.width-60 ? x = (x-60) : x;
        count += 1;
        if (count%3==0) {
            
            type = SKTextureTypeSmallFoePlane;
            CGPoint point = CGPointMake(x, self.size.height);
            [self CreatFoePlaneWithTextureType:type atPoint:point];
        }
        else if (count%7==0)
        {
            
            type = SKTextureTypeMediumFoePlane;
            CGPoint point = CGPointMake(x, self.size.height);
            [self CreatFoePlaneWithTextureType:type atPoint:point];
        }
        else if (count%11==0)
        {
            
            type = SKTextureTypeBigFoePlane;
            CGPoint point = CGPointMake(x, self.size.height);
            [self CreatFoePlaneWithTextureType:type atPoint:point];
        }
    }];
    
    [timer fire];
}

- (void)initBackGround
{
    _adjustmentHeight = 0;
     _backGround1 = [SKSpriteNode spriteNodeWithTexture:[SharedTextureAtlas textureWithType:SKTextureTypeBackGround]];
    _backGround1.position = CGPointMake(self.size.width/2, 0);
    _backGround1.anchorPoint = CGPointMake(0.5, 0);
    _backGround1.zPosition = 0;
    
    
    _backGround2 = [SKSpriteNode spriteNodeWithTexture:[SharedTextureAtlas textureWithType:SKTextureTypeBackGround]];
    _backGround2.position = CGPointMake(self.size.width/2, _adjustmentHeight-1);
    _backGround2.anchorPoint = CGPointMake(0.5, 0);
    _backGround2.zPosition = 0;
    
    [self addChild:_backGround1];
    [self addChild:_backGround2];
}

- (void)scrollBackGround
{
    _adjustmentHeight--;
    
    if (_adjustmentHeight <= 0)
    {
        _adjustmentHeight = 568;
    }
    
    [_backGround1 setPosition:CGPointMake(self.size.width / 2, _adjustmentHeight - 568)];
    [_backGround2 setPosition:CGPointMake(self.size.width / 2, _adjustmentHeight - 1)];

}

- (void)fireBullet
{
    _bulletTimer = [NSTimer scheduledTimerWithTimeInterval:.5 repeats:YES block:^(NSTimer * _Nonnull timer) {
        
        SKSpriteNode *bullet = [SKSpriteNode spriteNodeWithTexture:[SharedTextureAtlas textureWithType:SKTextureTypeBullet]];
        bullet.position = CGPointMake(_playerPlane.position.x, _playerPlane.position.y);
        
        bullet.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:bullet.size];
        bullet.physicsBody.categoryBitMask = SKRoleCategoryBullet;
        bullet.physicsBody.contactTestBitMask = SKRoleCategoryFoePlane;
        bullet.physicsBody.collisionBitMask = 0;
        
        SKAction *runBullet = [SKAction moveTo:CGPointMake(bullet.position.x, bullet.position.y+568) duration:1.5];
        SKAction *remove = [SKAction removeFromParent];
        
        [bullet runAction:[SKAction sequence:@[runBullet,remove]]];
        
        [self addChild:bullet];
    }];
    
    [_bulletTimer fire];
}

- (void)update:(NSTimeInterval)currentTime
{
    [self scrollBackGround];
}


- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    for (UITouch *touch in touches) {
        
        CGPoint point = [touch locationInNode:self];
        
        SKAction *move = [SKAction moveTo:point duration:.01];
        
        [_playerPlane runAction:move];
    }
}

#pragma mark - ContactDelegate
- (void)didBeginContact:(SKPhysicsContact *)contact
{
    if (contact.bodyA.categoryBitMask & SKRoleCategoryFoePlane || contact.bodyB.categoryBitMask & SKRoleCategoryFoePlane) {
        
        FoePlane *sprite = (contact.bodyA.categoryBitMask & SKRoleCategoryFoePlane) ? (FoePlane *)contact.bodyA.node : (FoePlane *)contact.bodyB.node;
        
        if (contact.bodyA.categoryBitMask & SKRoleCategoryPlayerPlane || contact.bodyB.categoryBitMask & SKRoleCategoryPlayerPlane) {
            
            SKSpriteNode *playerPlane = (contact.bodyA.categoryBitMask & SKRoleCategoryPlayerPlane) ? (SKSpriteNode *)contact.bodyA.node : (SKSpriteNode *)contact.bodyB.node;
            [self playerPlaneCollisionAnimation:playerPlane];
        }else{
            SKSpriteNode *bullet = (contact.bodyA.categoryBitMask & SKRoleCategoryFoePlane) ? (SKSpriteNode *)contact.bodyB.node : (SKSpriteNode *)contact.bodyA.node;
            [bullet removeFromParent];
            [self foePlaneCollisionAnimation:sprite];
        }
    }

}
#pragma mark - animation
- (void)playerPlaneCollisionAnimation:(SKSpriteNode*)player
{
    NSLog(@"dead");
    [player runAction:[SKAction removeFromParent]];
    [_bulletTimer invalidate];
}

- (void)foePlaneCollisionAnimation:(FoePlane*)foe
{
    foe.hp--;
    if (foe.hp <= 0) {
        
        [foe runAction:[SKAction animateWithTextures:[FoePlane collesionActionByType:foe.type] timePerFrame:.05] completion:^{
            
            [foe runAction:[SKAction removeFromParent]];
        }];
    }
}

#pragma mark - Creat Foe Plane
- (void)CreatFoePlaneWithTextureType:(SKTextureType)type atPoint:(CGPoint)point
{
    FoePlane *foePlane = [FoePlane spriteNodeWithTexture:[SharedTextureAtlas textureWithType:type]];
    foePlane.type = type;
    NSTimeInterval speed = 3.0;
    
    switch (foePlane.type) {
        case SKTextureTypeSmallFoePlane:
            speed = 3.0;
            break;
        case SKTextureTypeMediumFoePlane:
            speed = 5.0;
            break;
        case SKTextureTypeBigFoePlane:
            speed = 7.0;
            break;
            
        default:
            break;
    }
    
    foePlane.position = point;
    foePlane.anchorPoint = CGPointMake(0.5, 0);
    
    foePlane.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:foePlane.size];
    foePlane.physicsBody.categoryBitMask = SKRoleCategoryFoePlane;
    foePlane.physicsBody.contactTestBitMask = SKRoleCategoryBullet | SKRoleCategoryPlayerPlane;
    foePlane.physicsBody.collisionBitMask = 0;
    
    SKAction *move = [SKAction moveTo:CGPointMake(foePlane.position.x, 0) duration:speed];
    SKAction *remove = [SKAction removeFromParent];
    [foePlane runAction:[SKAction sequence:@[move,remove]]];
    
    [self addChild:foePlane];
}
@end
