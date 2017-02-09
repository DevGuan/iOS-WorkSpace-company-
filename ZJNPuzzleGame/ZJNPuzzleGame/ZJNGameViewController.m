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

#pragma mark - gameCell
@interface GameCell :UICollectionViewCell
@property (nonatomic, strong) UIImageView *cellImage;
@property (nonatomic, assign) NSInteger index;
@end

@implementation GameCell
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _cellImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    }
    return self;
}
@end


@interface ZJNGameViewController ()<UINavigationControllerDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *stepLabel;
@property (weak,nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;


@property (nonatomic, strong) NSMutableArray *imageArr;
@property (nonatomic, strong) NSMutableArray *shuffleArr;
@property (nonatomic, strong) GameCell *emptyCell;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic) NSInteger time;
@property (nonatomic) NSInteger stepNum;

@end

@implementation ZJNGameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _imageView.image = _mainImage;
    _imageArr = [UIImage clipImageWithImage:_mainImage withConuntM:3 withCountN:3];
    
    [self setUpCollectionView];

}

- (void)setUpCollectionView
{
    [_collectionView registerClass:[GameCell class] forCellWithReuseIdentifier:@"gameCell"];
    
    _collectionView.contentSize = _collectionView.frame.size;
    _collectionView.backgroundColor = [UIColor colorWithRed:82.0/255 green:139.0/255 blue:139.0/255 alpha:1];
    CGFloat imageSize = (_collectionView.frame.size.width - 4*1)/3;
    _flowLayout.itemSize = CGSizeMake(imageSize, imageSize);
    _flowLayout.minimumLineSpacing = 1;
    _flowLayout.minimumInteritemSpacing =1;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
}

#pragma mark - CollectionView Delegate/Datasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _imageArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    GameCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"gameCell" forIndexPath:indexPath];
    
    //确保emptyCell上的图片为最后一张图
    if (indexPath.item == _imageArr.count-1) {
        _emptyCell = cell;
    }
    else
    {
        cell.cellImage.image = _imageArr[indexPath.item];
    }
    
    return cell;

}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    GameCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"gameCell" forIndexPath:indexPath];
    
    //确保emptyCell上的图片为最后一张图
    if (indexPath.item == _imageArr.count-1) {
        _emptyCell = cell;
    }
    else
    {
        cell.cellImage.image = _imageArr[indexPath.item];
    }
    
    return cell;
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
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)restartButtonAction:(UIButton *)sender {
    [_timer invalidate];
    _time = 0;
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self
                                            selector:@selector(changeTime) userInfo:nil repeats:true];
    
    _stepNum = 0;
    _stepLabel.text = @"0";
    _shuffleArr = [self changeArrayOrderWithArray:_imageArr];
    [_collectionView reloadData];
}


- (void)changeTime {
    NSInteger mintue = _time / 60;
    NSInteger second = _time % 60;
    _timeLabel.text = [NSString stringWithFormat:@"%02ld:%02ld", mintue, second];
    _time ++;
}

- (IBAction)rankButtonAction:(UIButton *)sender {
    // 数据库真的不想写了 有问题可以交流
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"牛人榜" message:@"这个码农太懒，不想写数据库，还是自己截图完成的时候记得截图吧" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertAction1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
    }];
    [alertC addAction:alertAction1];
    [self presentViewController:alertC animated:YES completion:nil];
}
@end

