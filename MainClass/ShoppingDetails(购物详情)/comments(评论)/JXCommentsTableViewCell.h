//
//  JXCommentsTableViewCell.h
//  JaneCargo
//
//  Created by 鹏 on 2017/7/18.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JXHomepagModel;

@interface JXCommentsTableViewCell : UITableViewCell

+ (instancetype)cellWithTable;

@property (nonatomic, strong) JXHomepagModel *model;

@end
