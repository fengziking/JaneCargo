//
//  JXChecklogisticsfTableViewCell.h
//  JaneCargo
//
//  Created by 鹏 on 2017/8/11.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JXChecklogisticsfTableViewCell : UITableViewCell

+ (instancetype)cellWithTable;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) JXHomepagModel *model;

@end
