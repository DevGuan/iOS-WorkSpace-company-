//
//  GameViewController.m
//  HitPlane
//
//  Created by GARY on 2017/2/10.
//  Copyright © 2017年 GARY. All rights reserved.
//

#import "GameViewController.h"
#import "GameScene.h"

@implementation GameViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    SKView *skView = (SKView *)self.view;
    GameScene *scene = [GameScene sceneWithSize:skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;

    // Present the scene
    [skView presentScene:scene];
    
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
