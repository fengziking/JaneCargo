//
//  MKGoodsModel.h
//  发大财
//
//  Created by FDC-iOS on 17/1/9.
//  Copyright © 2017年 meilun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MKGoodsModel : NSObject
//@property(nonatomic,copy)NSString * goods_thumb; //商品图片
//@property(nonatomic,copy)NSString * goods_id;    //商品id
//@property(nonatomic,assign)float  shop_price;    //商品单价(订单中心)
//@property(nonatomic,assign)float  goods_price;   //商品单价(订单详情)
//@property(nonatomic,assign)float  goods_number;  //商品数量
//@property(nonatomic,copy)NSString * goods_amount;//商品总价(订单中心)
//@property(nonatomic,assign)float subtotal;       //商品总价(订单详情)
//@property(nonatomic,copy)NSString * goods_name;  //商品名称
//@property(nonatomic,copy)NSString * vend_name;   //厂商名称
//@property(nonatomic,copy)NSString * vend_id;     //订单类型
//@property(nonatomic,copy)NSString * choose_num;  //面料编号
//
//
//@property(nonatomic,copy)NSString * rec_id;      //购物车id = rec_id

// ===============

// 录入时间
@property (nonatomic, strong) NSNumber *create_time;
@property (nonatomic, strong) NSNumber *good_id;
@property (nonatomic, strong) NSString *good_img;
@property (nonatomic, strong) NSString *good_name;
@property (nonatomic, assign) float  good_price;
@property (nonatomic, assign) float market_price;
@property (nonatomic, assign) float number;
@property (nonatomic, assign) float price;
@property (nonatomic, strong) NSNumber *id;
@property (nonatomic, strong) NSNumber *is_assess;
//  规格属性
@property (nonatomic, strong) NSString *key_name;

@property (nonatomic, strong) NSString *ordersn;

@property (nonatomic, strong) NSString *seller_id;
@property (nonatomic, strong) NSString *spec_id;
// 1上架0下架
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *total;
@property (nonatomic, strong) NSNumber *uid;

@property(nonatomic,assign)BOOL isSelected;
@property (nonatomic, strong) NSIndexPath *indexPath;


@property (assign, nonatomic) CGFloat cellHeight;


// 用户订单










@end
