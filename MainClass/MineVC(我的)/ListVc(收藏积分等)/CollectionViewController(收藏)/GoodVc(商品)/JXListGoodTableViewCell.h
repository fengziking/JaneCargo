//
//  JXListGoodTableViewCell.h
//  JaneCargo
//
//  Created by 鹏 on 2017/8/8.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JXHomepagModel;
@interface JXListGoodTableViewCell : UITableViewCell

+ (instancetype)cellWithTable;
@property (nonatomic, strong) JXHomepagModel *model;

@end
