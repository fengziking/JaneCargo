//
//  JXCourierCell.h
//  JaneCargo
//
//  Created by 鹏 on 2017/10/25.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JXCourierCell : UITableViewCell
+ (instancetype)cellWithTable;
@property (nonatomic, strong) JXHomepagModel *model;
@end
