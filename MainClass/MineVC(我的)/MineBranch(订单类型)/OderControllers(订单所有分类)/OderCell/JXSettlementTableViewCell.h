//
//  JXSettlementTableViewCell.h
//  JaneCargo
//
//  Created by 鹏 on 2017/7/9.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MKOrderListModel;
@interface JXSettlementTableViewCell : UITableViewCell

+ (instancetype)cellWithTable;
@property (nonatomic, strong) MKOrderListModel *model;
@end
