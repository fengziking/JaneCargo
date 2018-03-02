//
//  JXInvoicingViewController.h
//  JaneCargo
//
//  Created by 鹏 on 2017/7/28.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, OrderDataType) {
    OrdergoodShop = 0, // 购物车
    OrderOtherPag,     // 其他
    
};



@interface JXInvoicingViewController : UIViewController

@property (nonatomic, strong) NSArray *dateArray;
@property (nonatomic, assign) float totalNum;  // 合计价格
@property (nonatomic, assign) NSInteger goodsNumber;

@property (nonatomic, strong) MKOrderListModel *is_model;

@property (nonatomic, assign) OrderDataType retweetType;

@end
