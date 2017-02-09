//
//  ZJNGameViewController.m
//  ZJNPuzzleGame
//
//  Created by GARY on 2017/2/9.
//  Copyright © 2017年 GARY. All rights reserved.
//

/**
 游戏界面的Controller
 */
#import "ZJNGameViewController.h"

@interface ZJNGameViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *stepLabel;

@end

@implementation ZJNGameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

#pragma mark - IBAction
- (IBAction)settingButtonAction:(UIButton *)sender {
}
- (IBAction)restartButtonAction:(UIButton *)sender {
}
- (IBAction)rankButtonAction:(UIButton *)sender {
}


@end
