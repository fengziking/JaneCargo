//
//  JXJudgeStrObjc.h
//  JaneCargo
//
//  Created by 鹏 on 2017/8/3.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JXJudgeStrObjc : NSObject

// 判断空值
+ (NSString *)judgestr:(NSString *)string;
// 用户订单名称
+ (NSString *)judgeType:(MKOrderListModel *)type recycle:(NSInteger)recycle;

+ (void)distinguishTheCategory:(MKOrderListModel*)model delivery:(void(^)())delivery goods:(void(^)())goods orderfinished:(void(^)())orderfinished returngoods:(void(^)())returngoods payment:(void(^)())payment recycling:(void(^)())recycling evaluation:(void(^)())evaluation refund:(void(^)())refund rejected:(void(^)())rejected complete:(void(^)())complete refundon:(void(^)())refundon agreerefund:(void(^)())agreerefund;

#pragma mark -- 添加购物车id 更改当前状态
+ (void)addgoods_idCart:(NSString *)good_id;
#pragma mark -- 删除购物车id 更改当前状态
+ (void)delegateGoods_idCart:(NSString *)goods_id;
#pragma mark -- 时间戳转换
+ (NSString *)s_returnTimeStamp:(NSString *)stamp;

#pragma mark -- 分段加密
+ (NSMutableDictionary *)blockEncryption:(NSMutableDictionary *)encryArray;
#pragma mark -- 添加本地搜索
+ (void)addSearchrecords:(NSString *)searchName;
#pragma mark -- 登录状态
+ (void)is_login:(void(^)(NSInteger message))notlogged;
@end
