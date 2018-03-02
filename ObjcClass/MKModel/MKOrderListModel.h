//
//  MKOrderListModel.h
//  发大财
//
//  Created by FDC-iOS on 17/1/9.
//  Copyright © 2017年 meilun. All rights reserved.
//

#import <Foundation/Foundation.h>
//@class MKGoodsModel;


@interface MKOrderListModel : NSObject

// 退货 退款
//@property (nonatomic, strong) NSString *decs;
//@property (nonatomic, strong) NSString *content;
//@property (nonatomic, strong) NSString *agree_time;
//@property (nonatomic, strong) NSString *deal_time;
//@property (nonatomic, strong) NSString *deliver_time;
//@property (nonatomic, strong) NSString *receive_time;

@property (nonatomic, strong) NSMutableDictionary *return_good;
@property(nonatomic,assign) BOOL groupSelected;     // 组选中
@property (nonatomic, strong) NSArray * cart;
@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, strong) NSString *seller_id;
@property (nonatomic, strong) NSString *receiver;
@property (nonatomic, strong) NSString *phone;

@property (nonatomic, strong) NSNumber *total;
@property (nonatomic, strong) NSDictionary *address;

@property (nonatomic, strong) NSString *ex_money;

/// 省市区
@property (nonatomic, strong) NSString *s_province;
@property (nonatomic, strong) NSString *s_city;
@property (nonatomic, strong) NSString *s_county;
@property (nonatomic, strong) NSString *r_address;

// 用户订单
@property (nonatomic, strong) NSNumber *address_id;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *create_time;
@property (nonatomic, strong) NSString *do_time;
@property (nonatomic, strong) NSString *express_name;
@property (nonatomic, strong) NSString *express_number;
@property (nonatomic, strong) NSNumber *id;
@property (nonatomic, strong) NSString *is_jf;
@property (nonatomic, strong) NSString *is_pay;
@property (nonatomic, strong) NSString *orderdate;
@property (nonatomic, strong) NSString *ordersn;
@property (nonatomic, strong) NSString *pay_id;
@property (nonatomic, strong) NSString *pay_time;
@property (nonatomic, strong) NSString *recipient_time;
@property (nonatomic, strong) NSString *rise;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *tax;
@property (nonatomic, strong) NSString *user_id;
@property (nonatomic, strong) NSString *is_bill;
@property (nonatomic, strong) NSString *is_cancel;
@property (nonatomic, strong) NSString *is_return_good;
@property (nonatomic, strong) NSString *is_sign;
@property (nonatomic, strong) NSString *iss_bill;
@property (nonatomic, strong) NSString *pay_no;
@property (nonatomic, strong) NSString *is_return;
// 总数量
@property (nonatomic, strong) NSNumber *num;

// 单独添加typeIndex
@property (nonatomic, assign) NSInteger typeIndex;

@property (assign, nonatomic) CGFloat cellHeight;


@end
