//
//  JXIconTableViewCell.h
//  JaneCargo
//
//  Created by cxy on 2017/7/5.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MineLoginblock)();

@interface JXIconTableViewCell : UITableViewCell


+ (instancetype)cellWithtable;
@property (nonatomic, copy) MineLoginblock login;


@end
