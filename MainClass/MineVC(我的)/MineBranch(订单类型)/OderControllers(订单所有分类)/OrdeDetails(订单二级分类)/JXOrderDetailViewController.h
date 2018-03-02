//
//  JXOrderDetailViewController.h
//  JaneCargo
//
//  Created by 鹏 on 2017/7/10.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import <UIKit/UIKit.h>


#import "JXOrderdetailImageTableViewCell.h"
#import "JXDeliveryinformationTableViewCell.h"
#import "JXOrderdetailsAddressTableViewCell.h"
#import "JXBranchOrderTableViewCell.h"
#import "JXBranchGoodsTableViewCell.h"
#import "JXOrderGoodsPriceTableViewCell.h"
#import "JXInvoiceTableViewCell.h"
#import "JXOrderInformationTableViewCell.h"
#import "JXRefundTableViewCell.h"
#import "JXReturnRefundTableViewCell.h"

// 地址管理
#import "JXAddressViewController.h"

@protocol WXpaySuccessdelegate <NSObject>

- (void)paySuccess;

@end


@interface JXOrderDetailViewController : UIViewController <RefundgoosDelegate>


@property (nonatomic, strong) MKOrderListModel *model;

@property (nonatomic, assign)id<WXpaySuccessdelegate>paySuccessdelegate;

@end
