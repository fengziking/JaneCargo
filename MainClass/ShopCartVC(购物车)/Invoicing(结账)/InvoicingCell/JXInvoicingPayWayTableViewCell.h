//
//  JXInvoicingPayWayTableViewCell.h
//  JaneCargo
//
//  Created by 鹏 on 2017/7/31.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JXInvoicingPayWayTableViewCell : UITableViewCell

+ (instancetype)cellWithTable;
- (void)setHiddenLine;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *payWay_str;
@end
