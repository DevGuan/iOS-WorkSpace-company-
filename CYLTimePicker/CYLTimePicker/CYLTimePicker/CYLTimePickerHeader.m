//
//  CYLTimePickerHeader.m
//  CYLTimePicker
//
//  Created by 迟钰林 on 2017/6/22.
//  Copyright © 2017年 迟钰林. All rights reserved.
//

#import "CYLTimePickerHeader.h"
#import "Masonry.h"

@interface CYLTimePickerHeader ()
@property (nonatomic, strong) UIView *line;
@end

@implementation CYLTimePickerHeader

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setUI];
    }
    return self;
}

- (void)setUI
{
    _cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    _cancleBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [_cancleBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [self addSubview:_cancleBtn];
    
    _todayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_todayBtn setTitle:@"今天" forState:UIControlStateNormal];
    _todayBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [_todayBtn addTarget:self action:@selector(todayClicled) forControlEvents:UIControlEventTouchUpInside];
    [_todayBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self addSubview:_todayBtn];
    
    _todayLable = [[UILabel alloc] init];
    _todayLable.textColor = [UIColor blackColor];
    _todayLable.font = [UIFont systemFontOfSize:15];
    _todayLable.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_todayLable];
    
    _line = [[UIView alloc] init];
    _line.backgroundColor = [UIColor colorWithRed:128/255.0 green:137/255.0 blue:147/255.0 alpha:0.5];
    [self addSubview:_line];
}

- (void)todayClicled
{
    if (self.didClickTodayBtnBlock) {
        self.didClickTodayBtnBlock();
    }
}

- (void)layoutSubviews
{
    [_cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.bottom.equalTo(self).offset(-5);
        make.top.equalTo(self);
        make.width.mas_equalTo(30);
    }];
    
    [_todayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-15);
        make.top.equalTo(self);
        make.bottom.equalTo(self).offset(-5);
        make.width.mas_equalTo(30);
    }];
    
    [_todayLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_cancleBtn.mas_right).offset(5);
        make.top.equalTo(self);
        make.right.equalTo(_todayBtn.mas_left).offset(-5);
        make.bottom.equalTo(self).offset(-5);
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(0);
        make.right.equalTo(self).offset(0);
        make.bottom.equalTo(self).offset(0);
        make.height.mas_equalTo(1);
        
    }];
}

@end
