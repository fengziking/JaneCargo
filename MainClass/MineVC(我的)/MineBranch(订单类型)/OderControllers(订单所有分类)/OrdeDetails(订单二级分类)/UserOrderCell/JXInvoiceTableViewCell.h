//
//  JXInvoiceTableViewCell.h
//  JaneCargo
//
//  Created by 鹏 on 2017/7/10.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JXInvoiceTableViewCell : UITableViewCell

+ (instancetype)cellWithTable;
@property (nonatomic, strong) MKOrderListModel *model;
@end
