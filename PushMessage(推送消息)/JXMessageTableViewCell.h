//
//  JXMessageTableViewCell.h
//  JaneCargo
//
//  Created by 鹏 on 2017/8/21.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JXMessageTableViewCell : UITableViewCell
+ (instancetype)cellwithTable;
@property (nonatomic, strong) JXHomepagModel *model;
@end
