//
//  JXUserDefaultsObjc.m
//  JaneCargo
//
//  Created by 鹏 on 2017/7/18.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXUserDefaultsObjc.h"

@implementation JXUserDefaultsObjc

#pragma mark --- 分类一级ID
+ (void)storageClassificationID:(NSString *)uuid {
    
    [[NSUserDefaults standardUserDefaults] setObject:uuid forKey:@"ClassificationID"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (NSString *)classificationID {
    
    NSString *uuidStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"ClassificationID"];
    return uuidStr;
}

#pragma mark -- 获取登录的sid
+ (void)storageLoginUserSid:(NSDictionary *)usersid {
    
    [[NSUserDefaults standardUserDefaults] setObject:usersid forKey:@"LoginUserSid"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (NSDictionary *)loginUserSid {
    
    NSDictionary *usersid = [[NSUserDefaults standardUserDefaults] objectForKey:@"LoginUserSid"];
    return usersid;
}


#pragma mark --- 用户登录信息缓存
+ (void)storageLoginUserInfo:(NSDictionary *)userInfo {
    
    [[NSUserDefaults standardUserDefaults] setObject:userInfo forKey:@"LoginUserInfo"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (NSDictionary *)loginUserInfo {
    
    NSDictionary *userinfo = [[NSUserDefaults standardUserDefaults] objectForKey:@"LoginUserInfo"];
    return userinfo;
}

#pragma mark --- 在线状态
+ (void)storageOnlineStatus:(BOOL)online {
    
    [[NSUserDefaults standardUserDefaults] setBool:online forKey:@"OnlineStatus"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (BOOL)onlineStatus {
    
    BOOL online = [[NSUserDefaults standardUserDefaults] boolForKey:@"OnlineStatus"];
    return online;
}

#pragma mark --- 导航颜色
+ (void)storageONavigationColor:(BOOL)color {
    
    [[NSUserDefaults standardUserDefaults] setBool:color forKey:@"NavigationColor"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (BOOL)navigationColor {
    
    BOOL online = [[NSUserDefaults standardUserDefaults] boolForKey:@"NavigationColor"];
    return online;
}

#pragma mark --- 保存默认地址
+ (void)storagedefault:(NSDictionary *)defaultaddress {
    
    [[NSUserDefaults standardUserDefaults] setObject:defaultaddress forKey:@"Defaultaddress"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (NSDictionary *)defaultaddress {
    
    NSDictionary *userinfo = [[NSUserDefaults standardUserDefaults] objectForKey:@"Defaultaddress"];
    return userinfo;
}

#pragma mark --- 保存购物车地址
+ (void)storagedefaultCart:(NSDictionary *)defaultaddress {
    
    [[NSUserDefaults standardUserDefaults] setObject:defaultaddress forKey:@"DefaultaddressCart"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (NSDictionary *)defaultaddresscart {
    
    NSDictionary *userinfo = [[NSUserDefaults standardUserDefaults] objectForKey:@"DefaultaddressCart"];
    return userinfo;
}


#pragma mark -- 记录加入购物车的商品id
+ (void)storageJoinGood_id:(NSArray *)goods_id {

    [[NSUserDefaults standardUserDefaults] setObject:goods_id forKey:@"JoinGoodsid"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (NSArray *)defaultgoods_id {
    
    NSArray *goosid = [[NSUserDefaults standardUserDefaults] objectForKey:@"JoinGoodsid"];
    return goosid;
}

// 退出登录
#pragma mark --- 清除购物车的id
+ (void)deletegoos_idForCart {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"JoinGoodsid"];
    
}
+ (void)deletegoos_idForsid {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"LoginUserSid"];
    
}

#pragma mark --- 改变登录状态
+ (void)changeLoginStrat {
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"OnlineStatus"];
}
#pragma mark --- 清除默认地址
+ (void)deleteAddress {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Defaultaddress"];
    
}

#pragma mark --- 清除用户信息
+ (void)deleteUserInfo {
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"LoginUserInfo"];
    
}

#pragma mark --- 用户搜索本地记录
+ (void)storageSearchUserInfo:(NSArray *)search {

    [[NSUserDefaults standardUserDefaults] setObject:search forKey:@"LocalSearch"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (NSArray *)defaultsearch {
    
    NSArray *searchdic = [[NSUserDefaults standardUserDefaults] objectForKey:@"LocalSearch"];
    return searchdic;
}

#pragma mark --- 清除本地搜索数据
+ (void)deletesearchdic {
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"LocalSearch"];
    
}



@end
