//
//  JXOrderGoodsPriceTableViewCell.h
//  JaneCargo
//
//  Created by 鹏 on 2017/7/10.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MKOrderListModel;
@protocol RefundgoosDelegate <NSObject>
// 退款
- (void)refundgoos_money:(MKOrderListModel *)model;

@end

@interface JXOrderGoodsPriceTableViewCell : UITableViewCell

+ (instancetype)cellWithTable;

@property (nonatomic, assign) BOOL hiddenbt;

@property (nonatomic, assign) id<RefundgoosDelegate>refunddelegate;

@property (nonatomic, strong) MKOrderListModel *model;

@end
