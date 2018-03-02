//
//  JXHomepagModel.h
//  JaneCargo
//
//  Created by cxy on 2017/6/23.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JXHomepagModel : NSObject


// 快递名称
@property (nonatomic, strong) NSString *exbs;
@property (nonatomic, strong) NSString *exname;

// 推送
@property (nonatomic, strong) NSString *cat_id;
@property (nonatomic, strong) NSString *is_show;
@property (nonatomic, strong) NSString *stat;

// 发票
@property (nonatomic, strong) NSString *money;
@property (nonatomic, strong) NSString *orderid;
// 快递信息
@property (nonatomic, strong) NSString *ischeck;
@property (nonatomic, strong) NSString *com;
@property (nonatomic, strong) NSString *nu;
@property (nonatomic, strong) NSString *context;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSString *ftime;
@property (nonatomic, strong) NSString *state;

@property (nonatomic, strong) NSString *answer;
@property (nonatomic, strong) NSString *answer_time;
@property (nonatomic, strong) NSString *question;
@property (nonatomic, strong) NSString *question_time;


@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, strong) NSString *seller_img;
@property (nonatomic, strong) NSString *good_type_name;
@property (nonatomic, strong) NSString *tximg;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *assess_con;
@property (nonatomic, strong) NSNumber *assess_num;
@property (nonatomic, strong) NSString *good_id;
@property (nonatomic, strong) NSString *uid;
// 1已关注 0未关注
@property (nonatomic, strong) NSString *info;

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *imgs;
@property (nonatomic, strong) NSString *url;

@property (nonatomic, strong) NSString *ico_img;
@property (nonatomic, strong) NSString *good_img;
@property (nonatomic, strong) NSString *good_keyword;
@property (nonatomic, strong) NSString *good_name;
@property (nonatomic, strong) NSString *good_price;
@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *market_price;
@property (nonatomic, strong) NSString *good_number;
@property (nonatomic, strong) NSString *value;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *color;
@property (nonatomic, strong) NSDictionary *good;
@property (nonatomic, strong) NSDictionary *banner;
@property (nonatomic, strong) NSNumber *number;
@property (nonatomic, strong) NSString *keyword;
// 商品详情主要内容
@property (nonatomic, strong) NSNumber *good_type_id;
// 评论
@property (nonatomic, strong) NSString *count;
// 商品详情内容
@property (nonatomic, strong) NSString *content;
// 此商品是否可以积分兑换 1支付0兑换2两种方式都可以
@property (nonatomic, strong) NSNumber *pay_type;
// 录入时间
@property (nonatomic, strong) NSString *create_time;
// 上架时间
@property (nonatomic, strong) NSString *up_time;
// 下架时间
@property (nonatomic, strong) NSString *down_time;
// 状态 1上架0下架
@property (nonatomic, strong) NSNumber *status;
// 排序
@property (nonatomic, strong) NSNumber *sort;
// 规格属性ID
@property (nonatomic, strong) NSNumber *goods_cat_id;
// 购买人数
@property (nonatomic, strong) NSNumber *buy_num;
// 商家id
@property (nonatomic, strong) NSString *seller_id;
// 情况 0普通1热卖2新品3清仓
@property (nonatomic, strong) NSNumber *type;
// 是否热卖
@property (nonatomic, strong) NSNumber *is_hot;
// 是否清仓
@property (nonatomic, strong) NSNumber *is_clear;
// 是否新品
@property (nonatomic, strong) NSNumber *is_new;

// 相册
@property (nonatomic, strong) NSString *img;
@property (nonatomic, strong) NSString *phone_img;

//  规格属性
@property (nonatomic, strong) NSString *key_name;
//  价格
@property (nonatomic, strong) NSNumber *price;
//  库存数量
@property (nonatomic, strong) NSNumber *store_count;
// 品牌
@property (nonatomic, strong) NSString *brand;
// 规格
@property (nonatomic, strong) NSString *specifications;
// 产地
@property (nonatomic, strong) NSString *place_product;
// 保质期
@property (nonatomic, strong) NSString *quality_time;
// 特产品类
@property (nonatomic, strong) NSString *product_type;
// 存储方法
@property (nonatomic, strong) NSString *save_way;
// spec_id
@property (nonatomic, strong) NSNumber *spec_id;


// 地址
@property (nonatomic, strong) NSString *address;
// 1是0否 默认地址
@property (nonatomic, strong) NSString *is_default;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *s_city;
@property (nonatomic, strong) NSString *s_county;
@property (nonatomic, strong) NSString *s_province;
@property (nonatomic, strong) NSString *user_id;

@property (nonatomic, assign) BOOL isSelects;


// 记录首页抢购model第几个
@property (nonatomic, assign) NSInteger type_model;

@property (nonatomic, strong) NSString *docs;
@property (nonatomic, strong) NSString *is_pay;
@property (nonatomic, strong) NSString *pay_time;

// 支付宝账号
@property (nonatomic, strong) NSString *alipay_no;
// 提现银行名称
@property (nonatomic, strong) NSString *bank;
// 提现银行卡号
@property (nonatomic, strong) NSString *bank_no;
@property (nonatomic, strong) NSString *is_ali;
@property (nonatomic, strong) NSString *is_bank;
@property (nonatomic, strong) NSString *realname;
@property (nonatomic, strong) NSString *zlj_money;
@property (nonatomic, strong) NSString *is_dl;

+ (instancetype)jxStratdic:(NSDictionary *)dic;
@property (assign, nonatomic) CGFloat cellHeight;


@end
