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

- (NSMutableArray *)changeArrayOrderWithArray:(NSArray*)imageArray {
    NSMutableArray *tempArry = [NSMutableArray arrayWithArray:imageArray];
    int n = (int)imageArray.count/3;

    for (int i = 0 ; i < n*n; i++) {
        NSInteger random = arc4random_uniform((int)tempArry.count-2);
        UIImage *temp = tempArry[random];
        tempArry[random] = tempArry[random+1];
        tempArry[random+1] = tempArry[random+2];
        tempArry[random+2] = temp;
        
    }
    
    return tempArry;
}

#pragma mark - IBAction
- (IBAction)settingButtonAction:(UIButton *)sender {
}
- (IBAction)restartButtonAction:(UIButton *)sender {
}
- (IBAction)rankButtonAction:(UIButton *)sender {
}


@end
