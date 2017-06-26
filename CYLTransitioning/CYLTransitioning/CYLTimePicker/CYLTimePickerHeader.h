//
//  CYLTimePickerHeader.h
//  CYLTimePicker
//
//  Created by 迟钰林 on 2017/6/22.
//  Copyright © 2017年 迟钰林. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^didClickBtn)();
@interface CYLTimePickerHeader : UIView
@property (nonatomic, copy) didClickBtn didClickCancleBtnBlock;
@property (nonatomic, copy) didClickBtn didClickTodayBtnBlock;
@property (nonatomic, strong) UIButton *cancleBtn;
@property (nonatomic, strong) UIButton *todayBtn;
@property (nonatomic, strong) UILabel *todayLable;
@end
