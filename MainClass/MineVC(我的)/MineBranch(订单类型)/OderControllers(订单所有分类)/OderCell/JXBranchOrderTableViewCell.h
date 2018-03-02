//
//  JXBranchOrderTableViewCell.h
//  JaneCargo
//
//  Created by cxy on 2017/7/7.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MKOrderListModel;
@interface JXBranchOrderTableViewCell : UITableViewCell

+ (instancetype)cellWithTable;

@property (nonatomic, strong) MKOrderListModel *model;

@property (nonatomic, assign) BOOL hiddenStart;
@end
