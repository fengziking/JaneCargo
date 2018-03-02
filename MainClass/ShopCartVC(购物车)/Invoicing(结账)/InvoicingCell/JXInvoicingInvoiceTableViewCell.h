//
//  JXInvoicingInvoiceTableViewCell.h
//  JaneCargo
//
//  Created by 鹏 on 2017/7/31.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^InvoicingSwitch)(BOOL on);

@interface JXInvoicingInvoiceTableViewCell : UITableViewCell

+ (instancetype)cellWithTable;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) BOOL switchOn;
@property (nonatomic, copy) InvoicingSwitch switchblock;

@end
