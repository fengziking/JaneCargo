//
//  JXInvoicingTitleShopTableViewCell.h
//  JaneCargo
//
//  Created by 鹏 on 2017/7/28.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MKOrderListModel;
@interface JXInvoicingTitleShopTableViewCell : UITableViewCell

+ (instancetype)cellWithTable;
@property (nonatomic, strong) MKOrderListModel *listmodel;
@end
