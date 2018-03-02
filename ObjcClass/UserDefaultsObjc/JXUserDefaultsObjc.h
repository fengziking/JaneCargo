//
//  JXUserDefaultsObjc.h
//  JaneCargo
//
//  Created by 鹏 on 2017/7/18.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JXUserDefaultsObjc : NSObject

#pragma mark --- 分类一级ID
+ (void)storageClassificationID:(NSString *)uuid;
+ (NSString *)classificationID;

#pragma mark -- 获取登录的sid
+ (void)storageLoginUserSid:(NSDictionary *)usersid;
+ (NSDictionary *)loginUserSid;

#pragma mark --- 用户信息缓存
+ (void)storageLoginUserInfo:(NSDictionary *)userInfo;
+ (NSDictionary *)loginUserInfo;
#pragma mark --- 用户在线状态
+ (void)storageOnlineStatus:(BOOL)online;
+ (BOOL)onlineStatus;

#pragma mark --- 导航颜色
+ (void)storageONavigationColor:(BOOL)color;
+ (BOOL)navigationColor;
#pragma mark --- 保存默认地址
+ (void)storagedefault:(NSDictionary *)defaultaddress;
+ (NSDictionary *)defaultaddress;
+ (void)storagedefaultCart:(NSDictionary *)defaultaddress;
+ (NSDictionary *)defaultaddresscart;


#pragma mark -- 记录加入购物车的商品id
+ (void)storageJoinGood_id:(NSArray *)goods_id;
+ (NSArray *)defaultgoods_id;

#pragma mark --- 用户搜索本地记录
+ (void)storageSearchUserInfo:(NSArray *)search;
+ (NSArray *)defaultsearch;
#pragma mark --- 清除本地搜索数据
+ (void)deletesearchdic;

// 退出登录
#pragma mark --- 清除购物车的id
+ (void)deletegoos_idForCart;
#pragma mark --- 改变登录状态
+ (void)changeLoginStrat;
#pragma mark --- 清除默认地址
+ (void)deleteAddress;
#pragma mark --- 清除用户信息
+ (void)deleteUserInfo;
#pragma mark --- 清除sid
+ (void)deletegoos_idForsid;


@end
