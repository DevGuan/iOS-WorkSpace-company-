//
//  ZJNMainViewController.m
//  ZJNPuzzleGame
//
//  Created by GARY on 2017/2/9.
//  Copyright © 2017年 GARY. All rights reserved.
//

/**
 首页的Controller
 */
#import "ZJNMainViewController.h"
#import "ZJNGameViewController.h"
#define marge 10

@interface ZJNMainViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic, strong) UIImageView *mainImageV;
@property (nonatomic, strong) UIButton *selPicBtn;
@property (nonatomic, strong) UIButton *startBtn;
@property (nonatomic, strong) UIButton *setDiff;
@property (nonatomic, assign) NSInteger diffCount;
@end

@implementation ZJNMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (void)initUI
{
    _diffCount = 3;
    self.view.backgroundColor = [UIColor whiteColor];
    
    _mainImageV = [[UIImageView alloc] init];
    _mainImageV.image = [UIImage imageNamed:@"luffy"];
    _mainImageV.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:_mainImageV];
    
    _selPicBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _selPicBtn.backgroundColor = [UIColor grayColor];
    [_selPicBtn setTitle:@"选择图片" forState:UIControlStateNormal];
    [_selPicBtn addTarget:self action:@selector(selectImage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_selPicBtn];
    
    _setDiff = [UIButton buttonWithType:UIButtonTypeCustom];
    _setDiff.backgroundColor = [UIColor grayColor];
    [_setDiff setTitle:@"选择难度" forState:UIControlStateNormal];
    [_setDiff addTarget:self action:@selector(setDiffcault) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_setDiff];
    
    _startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_startBtn setTitle:@"开始游戏" forState:UIControlStateNormal];
    _startBtn.backgroundColor = [UIColor grayColor];
    [_startBtn addTarget:self action:@selector(startGame) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_startBtn];
}

- (void)setDiffcault
{
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"请选择难度" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *diff1 = [UIAlertAction actionWithTitle:@"简单" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        _diffCount = 3;
    }];
    
    UIAlertAction *diff2 = [UIAlertAction actionWithTitle:@"中等" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        _diffCount = 5;
    }];
    
    UIAlertAction *diff3 = [UIAlertAction actionWithTitle:@"困难" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        _diffCount = 7;
    }];
    
    [alertC addAction:diff1];
    [alertC addAction:diff2];
    [alertC addAction:diff3];
    
    [self presentViewController:alertC animated:YES completion:nil];
}

- (void)selectImage
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    picker.allowsEditing = YES;
    [self presentViewController:picker animated:true completion:nil];
}

- (void)startGame
{
    ZJNGameViewController *gameVC = [[ZJNGameViewController alloc] init];
    gameVC.mainImage = self.mainImageV.image;
    gameVC.diffCount = _diffCount;
    [self presentViewController:gameVC animated:YES completion:nil];
}

#pragma mark - imagePickerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *image = info[@"UIImagePickerControllerEditedImage"];
    _mainImageV.image = [UIImage clipImageWithImage:image];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewWillLayoutSubviews
{
    [_mainImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(ScreenSize.height/5);
        make.width.height.mas_equalTo(ScreenSize.width - 2*marge);
    }];
    
    [_selPicBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.mas_equalTo(self.mainImageV.mas_bottom).offset(marge);
        make.width.mas_equalTo(ScreenSize.width/2);
        make.height.mas_equalTo(44);
    }];
    
    [_setDiff mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.mas_equalTo(self.selPicBtn.mas_bottom).offset(marge);
        make.width.mas_equalTo(ScreenSize.width/2);
        make.height.mas_equalTo(44);
    }];
    
    [_startBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.mas_equalTo(self.setDiff.mas_bottom).offset(marge);
        make.width.mas_equalTo(ScreenSize.width/2);
        make.height.mas_equalTo(44);
    }];
}

@end
