//
//  CYLDayCell.m
//  CYLTimePicker
//
//  Created by 迟钰林 on 2017/6/22.
//  Copyright © 2017年 迟钰林. All rights reserved.
//

#import "CYLDayCell.h"
#import "Masonry.h"

@implementation CYLDayCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setUI];
        self.isSelected = false;
    }
    return self;
}



- (void)setUI
{
    _weekLable = [[UILabel alloc] init];
    _weekLable.textColor = [UIColor darkTextColor];
    _weekLable.font = [UIFont systemFontOfSize:12];
    _weekLable.textAlignment = NSTextAlignmentCenter;
    _weekLable.text = @"星期一";
    [self addSubview:_weekLable];
    
    _dayLable = [[UILabel alloc] init];
    _dayLable.textColor = [UIColor darkTextColor];
    _dayLable.font = [UIFont systemFontOfSize:27];
    _dayLable.textAlignment = NSTextAlignmentCenter;
    _dayLable.text = @"7";
    [self addSubview:_dayLable];
}

- (void)layoutSubviews
{
    [_weekLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(5);
        make.left.right.equalTo(self);
        make.height.mas_equalTo(20);
    }];
    
    [_dayLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.mas_equalTo(_weekLable.mas_bottom).offset(5);
        make.bottom.equalTo(self).offset(-5);
    }];
}

- (void)setIsSelected:(BOOL)isSelected
{
    _isSelected = isSelected;
    
    if (isSelected) {
        self.backgroundColor = [UIColor colorWithRed:253/255.0 green:139/255.0 blue:140/255.0 alpha:1];;
        _weekLable.textColor = [UIColor whiteColor];
        _dayLable.textColor = [UIColor whiteColor];
        
        self.layer.cornerRadius = 9;
        self.layer.borderColor = [UIColor colorWithRed:253/255.0 green:139/255.0 blue:140/255.0 alpha:1].CGColor;
        self.layer.borderWidth = 1;
    }
    else
    {
        self.backgroundColor = [UIColor whiteColor];
        _weekLable.textColor = [UIColor darkTextColor];
        _dayLable.textColor = [UIColor darkTextColor];
        
        self.layer.cornerRadius = 9;
        self.layer.borderColor = [UIColor darkGrayColor].CGColor;
        self.layer.borderWidth = 1;

    }
}
@end
