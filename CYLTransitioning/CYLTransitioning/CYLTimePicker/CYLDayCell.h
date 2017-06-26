//
//  CYLDayCell.h
//  CYLTimePicker
//
//  Created by 迟钰林 on 2017/6/22.
//  Copyright © 2017年 迟钰林. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CYLDayCell : UICollectionViewCell
@property (nonatomic, strong) UILabel *weekLable;
@property (nonatomic, strong) UILabel *dayLable;
@property (nonatomic, assign) BOOL isSelected;
@end
