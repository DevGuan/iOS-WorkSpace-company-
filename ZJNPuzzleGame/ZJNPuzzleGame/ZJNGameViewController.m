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
        
        [self.contentView addSubview:_cellImage];
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

@property (nonatomic, strong) UIButton *rankViewButton;

@end

@implementation ZJNGameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _imageView.image = _mainImage;
    _imageArr = [UIImage clipImageWithImage:_mainImage withConuntM:_diffCount withCountN:_diffCount];
    _shuffleArr = [self changeArrayOrderWithArray:_imageArr];
    
    [self setUpCollectionView];
    [self restartButtonAction:nil];

}

- (void)setUpCollectionView
{
    [_collectionView registerClass:[GameCell class] forCellWithReuseIdentifier:@"gameCell"];
    
    _collectionView.contentSize = _collectionView.frame.size;
    _collectionView.backgroundColor = [UIColor whiteColor];
    CGFloat imageSize = (ScreenSize.width - 2*40 - (_diffCount+1)*1)/_diffCount;
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
    cell.cellImage.image = nil;
    cell.index = indexPath.item;
    //确保emptyCell上的图片为最后一张图
    if (_shuffleArr[indexPath.item] == _imageArr[_imageArr.count-1]) {
        _emptyCell = cell;
        _emptyCell.index = indexPath.item;
    }
    else
    {
        cell.cellImage.image = _shuffleArr[indexPath.item];
    }
    
    return cell;

}



- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    _stepNum += 1;
    GameCell *cell = (GameCell*)[collectionView cellForItemAtIndexPath:indexPath];
    NSInteger value = labs(cell.index - _emptyCell.index);
    if (value == _diffCount || (value == 1 && cell.index/_diffCount == _emptyCell.index/_diffCount)) {
        _emptyCell.cellImage.image = cell.cellImage.image;
        _emptyCell = cell;
        cell.cellImage.image = nil;
    }
    
    if (_emptyCell.index == _imageArr.count-1) {
        
        BOOL iscomplete = YES;
        for (int i = 0; i < _imageArr.count - 1; i++) {
            
            NSIndexPath *index = [NSIndexPath indexPathForItem:i inSection:0];
            GameCell *cell = (GameCell*)[collectionView cellForItemAtIndexPath:index];
            BOOL isSame = cell.cellImage.image == _imageArr[i];
            iscomplete = iscomplete == isSame;
            
            if (!iscomplete) {
                break;
            }
        }
        
        if (iscomplete) {
            [_timer invalidate];
            _emptyCell.cellImage.image = _imageArr.lastObject;
            collectionView.userInteractionEnabled = NO;
            
            UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"恭喜！！" message:nil preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *diff1 = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:nil];
            
            [alertC addAction:diff1];
            
            [self presentViewController:alertC animated:YES completion:nil];
            
        }
    }
    
}


- (NSMutableArray *)changeArrayOrderWithArray:(NSArray*)imageArray {
    NSMutableArray *tempArry = [NSMutableArray arrayWithArray:imageArray];
    int n = (int)imageArray.count/3;

    for (int i = 0 ; i < n*n; i++) {
        NSInteger random = arc4random_uniform((int)tempArry.count-3);
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
    _collectionView.userInteractionEnabled = YES;
    
    [_timer invalidate];
    _time = 0;
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.95 target:self
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
    
    _stepLabel.text = [NSString stringWithFormat:@"%ld",(long)_stepNum];
}

- (IBAction)rankButtonAction:(UIButton *)sender {
    
    [self showRankView];
}

-(UIButton *)rankViewButton{
    if (!_rankViewButton) {
        _rankViewButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _rankViewButton.frame = self.view.frame;
        _rankViewButton.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
        
        [_rankViewButton addTarget:self action:@selector(dismissRankView) forControlEvents:UIControlEventTouchUpInside];
        
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0.6*ScreenSize.width, 0.6*ScreenSize.height)];
        tableView.center = self.view.center;
        [_rankViewButton addSubview:tableView];
    }
    return _rankViewButton;
}

-(void)showRankView{
    [self.view addSubview:self.rankViewButton];
}

-(void)dismissRankView{
    [self.rankViewButton removeFromSuperview];
}

@end

