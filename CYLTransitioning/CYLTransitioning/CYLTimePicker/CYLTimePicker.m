//
//  CYLTimePicker.m
//  CYLTimePicker
//
//  Created by 迟钰林 on 2017/6/22.
//  Copyright © 2017年 迟钰林. All rights reserved.
//

#import "CYLTimePicker.h"
#import "Masonry.h"
#import "CYLTimePickerHeader.h"
#import "CYLDayCollectionView.h"
#import "CYLDayCell.h"

#define numOfDays 15
static NSString *identifier = @"collctionCell";

@interface CYLTimePicker ()<UICollectionViewDelegate, UICollectionViewDataSource,UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) CYLTimePickerHeader *header;
@property (nonatomic, strong) CYLDayCollectionView *dayCollectionView;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UIPickerView *timePicker;
@property (nonatomic, strong) UIButton *doneBtn;
@property (nonatomic, strong) NSIndexPath *lastSelected;
@property (nonatomic, strong) NSDate *todayDate;
@property (nonatomic, strong) NSMutableArray *datesArr;
@property (nonatomic, strong) NSDate *selectedDate;
@property (nonatomic, strong) NSMutableArray *minsArr;
@end

@implementation CYLTimePicker

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setUI];
    }
    return self;
}

- (void)setUI
{
    _lastSelected = [NSIndexPath indexPathForRow:0 inSection:0];
    
    _line = [[UIView alloc] init];
    _line.backgroundColor = [UIColor colorWithRed:128/255.0 green:137/255.0 blue:147/255.0 alpha:0.5];
    [self addSubview:_line];
    
    [self addSubview:self.header];
    [self addSubview:self.dayCollectionView];
    [self addSubview:self.timePicker];
    [self addSubview:self.doneBtn];
    [self initTime];
    [self layoutIfNeeded];
    [self setCell];
    [self setPicker];
}

- (void)setCell
{
    self.dayCollectionView.flowLayout.itemSize = CGSizeMake((self.dayCollectionView.bounds.size.width/6) - 10, self.dayCollectionView.bounds.size.height /3 * 2);
    [self.dayCollectionView reloadData];
}

- (void)setPicker
{
    [self.timePicker selectRow:0 inComponent:0 animated:YES];
    [self pickerView:self.timePicker didSelectRow:0 inComponent:0];
}

- (void)layoutIfNeeded
{
    [_header mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.mas_equalTo(self.bounds.size.height/10);
    }];
    
    [_dayCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_header.mas_bottom);
        make.left.right.equalTo(self);
        make.height.mas_equalTo(self.bounds.size.height/10 * 4);
    }];
    
    [_timePicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_dayCollectionView.mas_bottom).offset(5);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.width.mas_equalTo(self.bounds.size.width/3);
        make.height.mas_equalTo(self.bounds.size.height/10 * 3);
    }];
    
    [_doneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_timePicker.mas_bottom).offset(15);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.width.mas_equalTo(self.bounds.size.width/3 * 2);
        make.height.mas_equalTo(self.bounds.size.height/10 * 1.6);
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.dayCollectionView.mas_bottom);
        make.height.mas_equalTo(1);
    }];
    
    [super layoutIfNeeded];
}

- (void)initTime
{
    _todayDate = [NSDate date];
    _selectedDate = _todayDate;
    _header.todayLable.text = [NSString stringWithFormat:@"%ld-%ld-%ld",_todayDate.year, _todayDate.month, _todayDate.day];
    
    _datesArr = [NSMutableArray array];
    
    for (int i = 0; i < numOfDays; i++) {
        [_datesArr addObject:[_todayDate dateByAddingDays:i]];
    }
}


#pragma mark - delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return numOfDays;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CYLDayCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.isSelected = false;
    cell.isSelected = indexPath.row == _lastSelected.row ? true : false;
    
    cell.weekLable.text = [NSDate weekdayStringFromDate:_datesArr[indexPath.row]];
    cell.dayLable.text = [NSString stringWithFormat:@"%ld",[_todayDate dateByAddingDays:(indexPath.row%(_todayDate.daysInMonth))].day];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_lastSelected.row != indexPath.row) {
        CYLDayCell *lastCell = (CYLDayCell*)[collectionView cellForItemAtIndexPath:_lastSelected];
        lastCell.isSelected = false;
    }
    
    CYLDayCell *cell = (CYLDayCell*)[collectionView cellForItemAtIndexPath:indexPath];
    cell.isSelected = true;
    _lastSelected = indexPath;
    _selectedDate = self.datesArr[indexPath.row];
    self.header.todayLable.text = [NSString stringWithFormat:@"%ld-%ld-%ld",(long)_selectedDate.year,(long)_selectedDate.month,(long)_selectedDate.day];
    
    [collectionView reloadData];
    [_timePicker reloadAllComponents];
    [self setPicker];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        if (_selectedDate.day == _todayDate.day) {
            return 22 - _selectedDate.hour;
        }
        else
        {
            return 13;
        }
    }
    else
    {
        return self.minsArr.count;
    }
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *l = [[UILabel alloc] init];
    l.textAlignment = NSTextAlignmentCenter;
    l.textColor = [UIColor darkGrayColor];
    l.font = [UIFont systemFontOfSize:15];
    
    if (component == 0) {
        if (_selectedDate.day == _todayDate.day) {
            
            if (_selectedDate.minute < 30) {
                //此小时前30分钟时 可选择当前的小时时间
                NSDate *date = [_todayDate dateByAddingHours:row];
                l.text = [NSString stringWithFormat:@"%@点",[date formattedDateWithFormat:@"HH"]];
            }
            else
            {
                NSDate *date = [_todayDate dateByAddingHours:row+1];
                l.text = [NSString stringWithFormat:@"%@点",[date formattedDateWithFormat:@"HH"]];
            }
        }
        else
        {
            //非今天 显示固定时间段
            l.text = [NSString stringWithFormat:@"%ld点",row+10];
        }
        
    }
    else
    {
        l.text = [NSString stringWithFormat:@"%@分",self.minsArr[row]];
    }
    return l;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0) {
        
        [self.minsArr removeAllObjects];
        
        if (_selectedDate.day == _todayDate.day)
        {
            
            if (row == 0) {
                
                if (_selectedDate.minute < 30) {
                    [_minsArr addObject:@"30"];
                }
                else
                {
                    [_minsArr addObject:@"00"];
                    [_minsArr addObject:@"30"];
                }
            }
            else
            {
                [_minsArr addObject:@"00"];
                [_minsArr addObject:@"30"];
            }
            
        }
        else
        {
            [_minsArr addObject:@"00"];
            [_minsArr addObject:@"30"];
        }
    }
    
    [pickerView reloadAllComponents];
}

#pragma mark - method
- (void)getAppointTime
{
    
}

#pragma mark - lzay
- (CYLTimePickerHeader *)header
{
    if (!_header) {
        _header = [[CYLTimePickerHeader alloc] init];
        _header.didClickTodayBtnBlock = ^(){
            [self.dayCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
            [self collectionView:self.dayCollectionView didSelectItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        };
    }
    return _header;
}

- (UICollectionView *)dayCollectionView
{
    if (!_dayCollectionView) {
        _dayCollectionView = [[CYLDayCollectionView alloc] initWithFrame:CGRectZero];
        _dayCollectionView.dataSource = self;
        _dayCollectionView.delegate = self;
        _dayCollectionView.showsHorizontalScrollIndicator = NO;
        _dayCollectionView.backgroundColor = [UIColor colorWithRed:239/255.0 green:243/255.0 blue:244/255.0 alpha:1];
        [_dayCollectionView registerClass:[CYLDayCell class] forCellWithReuseIdentifier:identifier];
    }
    return _dayCollectionView;
}

- (UIPickerView *)timePicker
{
    if (!_timePicker) {
        _timePicker = [[UIPickerView alloc] init];
        _timePicker.delegate = self;
        _timePicker.dataSource = self;
    }
    return _timePicker;
}

- (UIButton *)doneBtn
{
    if (!_doneBtn) {
        _doneBtn = [[UIButton alloc] init];
        _doneBtn.layer.cornerRadius = 5;
        _doneBtn.backgroundColor = [UIColor colorWithRed:128/255.0 green:137/255.0 blue:147/255.0 alpha:1];
        [_doneBtn setTitle:@"完成" forState:UIControlStateNormal];
        [_doneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _doneBtn;
}

- (NSMutableArray *)minsArr
{
    if (!_minsArr) {
        _minsArr = [NSMutableArray array];
    }
    return _minsArr;
}
@end
