//
//  JXDeletehisTableViewCell.h
//  JaneCargo
//
//  Created by 鹏 on 2017/7/13.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DeleteHisblock)();

@interface JXDeletehisTableViewCell : UITableViewCell

+ (instancetype)cellWithTable;
@property (nonatomic, copy) DeleteHisblock deletehis;

@end
