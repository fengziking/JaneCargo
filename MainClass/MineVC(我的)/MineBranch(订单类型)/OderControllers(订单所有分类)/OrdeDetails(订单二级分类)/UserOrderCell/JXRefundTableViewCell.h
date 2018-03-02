//
//  JXRefundTableViewCell.h
//  JaneCargo
//
//  Created by 鹏 on 2017/8/4.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JXRefundTableViewCell : UITableViewCell
+ (instancetype)cellWithTable;
@property (nonatomic, strong) MKOrderListModel *model;
@end
