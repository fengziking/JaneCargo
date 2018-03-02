//
//  JXNetworkRequest.m
//  JaneCargo
//
//  Created by 鹏 on 2017/8/12.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXNetworkRequest.h"

@implementation JXNetworkRequest

+ (id)shareInstance{
    static JXNetworkRequest *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[JXNetworkRequest alloc]init];
    });
    return manager;
}

#pragma mark -- 首页接口 index
+ (void)asyncHomePageIs_Cache:(BOOL)is_Cache refreshCache:(BOOL)refreshCache completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail {
    [[self shareInstance] asyncHomePageIs_Cache:is_Cache refreshCache:refreshCache completed:completed statisticsFail:statisticsFail fail:fail];
}
- (void)asyncHomePageIs_Cache:(BOOL)is_Cache refreshCache:(BOOL)refreshCache completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail{

    [ZYNetWorking getWithUrl:@"index" params:nil Cache:is_Cache refreshCache:refreshCache success:^(id response) {
        if ([response[@"status"] integerValue] == 200) {
            completed(response);
        }else {
            statisticsFail(response);
        }
    } fail:^(NSError *error) {
        fail(error);
    }];
}


#pragma mark -- 热搜 搜索记录 清除搜索记录 搜索结果 hot_select
+ (void)asyncSearchForHotis_Cache:(BOOL)is_Cache refreshCache:(BOOL)refreshCache completed:(void(^)(NSDictionary *messagedic))completed fail:(void(^)(NSError *error))fail {
    [[self shareInstance] asyncSearchForHotis_Cache:is_Cache refreshCache:refreshCache completed:completed fail:fail];
}
- (void)asyncSearchForHotis_Cache:(BOOL)is_Cache refreshCache:(BOOL)refreshCache completed:(void(^)(NSDictionary *messagedic))completed fail:(void(^)(NSError *error))fail {
    
    [ZYNetWorking getWithUrl:@"hot_select" params:nil Cache:is_Cache refreshCache:refreshCache success:^(id response) {
        if ([response[@"status"] integerValue] == 200) {
            completed(response);
        }
    } fail:^(NSError *error) {
        fail(error);
    }];
}

// 搜索记录 history_keyword
+ (void)asyncSearchRecordsis_Cache:(BOOL)is_Cache refreshCache:(BOOL)refreshCache localdata:(void(^)(NSArray *messagedic))localdata completed:(void(^)(NSDictionary *messagedic))completed fail:(void(^)(NSError *error))fail {
    [[self shareInstance] asyncSearchRecordsis_Cache:is_Cache refreshCache:refreshCache localdata:localdata completed:completed fail:fail];
}
- (void)asyncSearchRecordsis_Cache:(BOOL)is_Cache refreshCache:(BOOL)refreshCache  localdata:(void(^)(NSArray *messagedic))localdata completed:(void(^)(NSDictionary *messagedic))completed fail:(void(^)(NSError *error))fail {
    NSDictionary *sidic = [JXUserDefaultsObjc loginUserSid];
    NSString *sid = sidic[@"info"];
    NSMutableDictionary *mutdic = @{}.mutableCopy;
    if (!kStringIsEmpty(sid)) {
        [mutdic setObject:sid forKey:@"sid"];
        [ZYNetWorking postWithUrl:@"history_keyword" params:[JXJudgeStrObjc blockEncryption:mutdic] Cache:is_Cache refreshCache:refreshCache success:^(id response) {
            if ([response[@"status"] integerValue] == 200) {
                completed(response);
            }
        } fail:^(NSError *error) {
            fail(error);
        }];
    }else {
        // 没登录的用户使用本地搜索
        NSArray *localRecordsdic = [JXUserDefaultsObjc defaultsearch];
        localdata(localRecordsdic);
    }
}
// 清除搜索记录 clear_history_keyword
+ (void)asyncDeleteSearchRecordsis_Cache:(BOOL)is_Cache refreshCache:(BOOL)refreshCache completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail {
    [[self shareInstance] asyncDeleteSearchRecordsis_Cache:is_Cache refreshCache:refreshCache  completed:completed statisticsFail:statisticsFail fail:fail];
}
- (void)asyncDeleteSearchRecordsis_Cache:(BOOL)is_Cache refreshCache:(BOOL)refreshCache completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail {
    NSDictionary *sidic = [JXUserDefaultsObjc loginUserSid];
    NSString *sid = sidic[@"info"];
    NSMutableDictionary *mutdic = @{}.mutableCopy;
    if (!kStringIsEmpty(sid)) {
        [mutdic setObject:sid forKey:@"sid"];
    }
    [ZYNetWorking postWithUrl:@"clear_history_keyword" params:[JXJudgeStrObjc blockEncryption:mutdic] Cache:is_Cache refreshCache:refreshCache success:^(id response) {
        if ([response[@"status"] integerValue] == 200) {
            completed(response);
        }else {
            statisticsFail(response);
        }
    } fail:^(NSError *error) {
        fail(error);
    }];
}

// good_find 搜索
+ (void)asyncSearchGoodkeywords:(NSString *)keyWords pagNumber:(NSInteger)pagNumber ordernum:(NSInteger)ordernum orderprice:(NSInteger)orderprice is_Cache:(BOOL)is_Cache refreshCache:(BOOL)refreshCache completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail {
    [[self shareInstance] asyncSearchGoodkeywords:keyWords pagNumber:pagNumber ordernum:ordernum orderprice:orderprice is_Cache:is_Cache refreshCache:refreshCache completed:completed statisticsFail:statisticsFail fail:fail];
}
- (void)asyncSearchGoodkeywords:(NSString *)keyWords pagNumber:(NSInteger)pagNumber ordernum:(NSInteger)ordernum orderprice:(NSInteger)orderprice is_Cache:(BOOL)is_Cache refreshCache:(BOOL)refreshCache completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail{
    NSDictionary *sidic = [JXUserDefaultsObjc loginUserSid];
    NSString *sid = sidic[@"info"];
    NSMutableDictionary *mutdic = @{}.mutableCopy;
    if (!kStringIsEmpty(sid)) {
        [mutdic setObject:sid forKey:@"sid"];
    }
    [mutdic setObject:keyWords forKey:@"good_name"];
    [mutdic setObject:[NSString stringWithFormat:@"%ld",pagNumber] forKey:@"p"];
    if (ordernum == 1 || ordernum == 2) {
        [mutdic setObject:[NSString stringWithFormat:@"%ld",ordernum] forKey:@"ordernum"];
    }
    if (orderprice == 1 || orderprice == 2) {
        [mutdic setObject:[NSString stringWithFormat:@"%ld",orderprice] forKey:@"orderprice"];
    }
    [ZYNetWorking postWithUrl:@"good_find" params:[JXJudgeStrObjc blockEncryption:mutdic] Cache:NO refreshCache:NO success:^(id response) {
        if ([response[@"status"] integerValue] == 200) {
            completed(response);
        }else {
            statisticsFail(response);
        }
        
    } fail:^(NSError *error) {
        fail(error);
    }];
}

#pragma mark -- 分类列表 good_list
+ (void)asyncClassificationGood_type_id:(NSInteger)good_type_id son_good_type_id:(NSInteger)son_good_type_id is_Cache:(BOOL)is_Cache refreshCache:(BOOL)refreshCache completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail {
    [[self shareInstance] asyncClassificationGood_type_id:good_type_id son_good_type_id:son_good_type_id is_Cache:is_Cache refreshCache:refreshCache completed:completed statisticsFail:statisticsFail fail:fail];
}
- (void)asyncClassificationGood_type_id:(NSInteger)good_type_id son_good_type_id:(NSInteger)son_good_type_id is_Cache:(BOOL)is_Cache refreshCache:(BOOL)refreshCache completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail{
    
    NSMutableDictionary *mutdic = @{}.mutableCopy;
    if (good_type_id!=0) {
        [mutdic setObject:[NSString stringWithFormat:@"%ld",good_type_id] forKey:@"good_type_id"];
    }
    if (son_good_type_id!=0) {
        [mutdic setObject:[NSString stringWithFormat:@"%ld",son_good_type_id] forKey:@"son_good_type_id"];
    }
    [ZYNetWorking getWithUrl:@"good_list" params:mutdic Cache:is_Cache refreshCache:refreshCache success:^(id response) {
        if ([response[@"status"] integerValue] == 200) {
            completed(response);
        }else {
            statisticsFail(response);
        }
        
    } fail:^(NSError *error) {
        fail(error);
    }];
}

#pragma mark -- 商品详情接口 good_info
+ (void)asyncGoodsdetails:(NSString*)goodsid is_Cache:(BOOL)is_Cache refreshCache:(BOOL)refreshCache completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail {
    [[self shareInstance] asyncGoodsdetails:goodsid is_Cache:is_Cache refreshCache:refreshCache completed:completed statisticsFail:statisticsFail fail:fail];
}
- (void)asyncGoodsdetails:(NSString*)goodsid is_Cache:(BOOL)is_Cache refreshCache:(BOOL)refreshCache completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail{
    
    NSDictionary *sidic = [JXUserDefaultsObjc loginUserSid];
    NSString *sid = sidic[@"info"];
    NSMutableDictionary *mutdic = @{}.mutableCopy;
    if (!kStringIsEmpty(sid)) {
        [mutdic setObject:sid forKey:@"sid"];
    }
    [mutdic setObject:goodsid forKey:@"id"];
    [ZYNetWorking postWithUrl:@"good_info" params:[JXJudgeStrObjc blockEncryption:mutdic] Cache:is_Cache refreshCache:refreshCache success:^(id response) {
        if ([response[@"status"] integerValue] == 200) {
            completed(response);
        }else {
            statisticsFail(response);
        }
        
    } fail:^(NSError *error) {
        fail(error);
    }];
}

#pragma mark -- 商品评论接口 good_assess
+ (void)asyncGoodseValuation:(NSString*)goodsid page:(NSInteger)page is_Cache:(BOOL)is_Cache refreshCache:(BOOL)refreshCache completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail {
    [[self shareInstance] asyncGoodseValuation:goodsid page:page is_Cache:is_Cache refreshCache:refreshCache completed:completed statisticsFail:statisticsFail fail:fail];
}
- (void)asyncGoodseValuation:(NSString*)goodsid page:(NSInteger)page is_Cache:(BOOL)is_Cache refreshCache:(BOOL)refreshCache completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail{
    
    NSMutableDictionary *mutdic = @{}.mutableCopy;
    [mutdic setObject:goodsid forKey:@"id"];
    [mutdic setObject:[NSString stringWithFormat:@"%ld",page] forKey:@"p"];
    [ZYNetWorking getWithUrl:@"good_assess" params:mutdic Cache:is_Cache refreshCache:refreshCache success:^(id response) {
        if ([response[@"status"] integerValue] == 200) {
            completed(response);
        }else {
            statisticsFail(response);
        }
        
    } fail:^(NSError *error) {
        fail(error);
    }];
}

#pragma mark -- 注册接口 register
+ (void)asyncRegisteredUserName:(NSString *)userName password:(NSString *)password phoneNumber:(NSString *)phoneNumber verificationCode:(NSString *)verification status:(NSString *)status is_Cache:(BOOL)is_Cache refreshCache:(BOOL)refreshCache completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail {
    [[self shareInstance] asyncRegisteredUserName:userName password:password phoneNumber:phoneNumber verificationCode:verification status:status is_Cache:is_Cache refreshCache:refreshCache completed:completed statisticsFail:statisticsFail fail:fail];
}

- (void)asyncRegisteredUserName:(NSString *)userName password:(NSString *)password phoneNumber:(NSString *)phoneNumber verificationCode:(NSString *)verification status:(NSString *)status is_Cache:(BOOL)is_Cache refreshCache:(BOOL)refreshCache completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail{
    
    NSMutableDictionary *mutdic = @{}.mutableCopy;
    [mutdic setObject:userName forKey:@"username"];
    [mutdic setObject:password forKey:@"password"];
    [mutdic setObject:phoneNumber forKey:@"phone"];
    [mutdic setObject:verification forKey:@"phonecode"];
    [mutdic setObject:status forKey:@"status"];
    [ZYNetWorking postWithUrl:@"register" params:[JXJudgeStrObjc blockEncryption:mutdic] Cache:is_Cache refreshCache:refreshCache success:^(id response) {
        if ([response[@"status"] integerValue] == 200) {
            completed(response);
        }else {
            statisticsFail(response);
        }
        
    } fail:^(NSError *error) {
        fail(error);
    }];
}

#pragma mark --- 账户查询（账户是否已经存在） is_exist
+ (void)asyncUserqueryStatus:(NSString*)status value:(NSString *)value is_Cache:(BOOL)is_Cache refreshCache:(BOOL)refreshCache completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail {
    [[self shareInstance] asyncUserqueryStatus:status value:value is_Cache:is_Cache refreshCache:refreshCache completed:completed statisticsFail:statisticsFail fail:fail];
}
- (void)asyncUserqueryStatus:(NSString*)status value:(NSString *)value is_Cache:(BOOL)is_Cache refreshCache:(BOOL)refreshCache completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail{
    
    NSMutableDictionary *mutdic = @{}.mutableCopy;
    [mutdic setObject:status forKey:@"status"];
    [mutdic setObject:value forKey:@"value"];
    [ZYNetWorking postWithUrl:@"is_exist" params:[JXJudgeStrObjc blockEncryption:mutdic] Cache:is_Cache refreshCache:refreshCache success:^(id response) {
        if ([response[@"status"] integerValue] == 200) {
            completed(response);
        }else {
            statisticsFail(response);
        }
        
    } fail:^(NSError *error) {
        fail(error);
    }];
}

#pragma mark --- 短信验证
+ (void)asyncVerificationCodeStatus:(NSString*)status phoneNumber:(NSString *)phone is_Cache:(BOOL)is_Cache refreshCache:(BOOL)refreshCache completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail {
    [[self shareInstance] asyncVerificationCodeStatus:status phoneNumber:phone is_Cache:is_Cache refreshCache:refreshCache completed:completed statisticsFail:statisticsFail fail:fail];
}
- (void)asyncVerificationCodeStatus:(NSString*)status phoneNumber:(NSString *)phone is_Cache:(BOOL)is_Cache refreshCache:(BOOL)refreshCache completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail{
    
    NSMutableDictionary *mutdic = @{}.mutableCopy;
    [mutdic setObject:status forKey:@"status"];
    [mutdic setObject:phone forKey:@"phone"];
    [ZYNetWorking postWithUrl:@"sms" params:[JXJudgeStrObjc blockEncryption:mutdic] Cache:is_Cache refreshCache:refreshCache success:^(id response) {
        if ([response[@"status"] integerValue] == 200) {
            completed(response);
        }else {
            statisticsFail(response);
        }
    } fail:^(NSError *error) {
        fail(error);
    }];
}

#pragma mark --- 我的
+ (void)asyncUserInfomationsid:(NSString*)sid is_Cache:(BOOL)is_Cache refreshCache:(BOOL)refreshCache completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail {
    [[self shareInstance] asyncUserInfomationsid:sid is_Cache:is_Cache refreshCache:refreshCache completed:completed statisticsFail:statisticsFail fail:fail];
}
- (void)asyncUserInfomationsid:(NSString*)sid is_Cache:(BOOL)is_Cache refreshCache:(BOOL)refreshCache completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail{
    
    NSMutableDictionary *mutdic = @{}.mutableCopy;
    if (!kStringIsEmpty(sid)) {
        [mutdic setObject:sid forKey:@"sid"];
    }
    [ZYNetWorking postWithUrl:@"main" params:[JXJudgeStrObjc blockEncryption:mutdic] Cache:is_Cache refreshCache:refreshCache success:^(id response) {
        if ([response[@"status"] integerValue] == 200) {
            completed(response);
        }else {
            statisticsFail(response);
        }
        
    } fail:^(NSError *error) {
        fail(error);
    }];
}

#pragma mark --- 获取用户信息
+ (void)asyncAllUserInfomationIs_Cache:(BOOL)is_Cache refreshCache:(BOOL)refreshCache completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail {
    [[self shareInstance] asyncAllUserInfomationIs_Cache:is_Cache refreshCache:refreshCache completed:completed statisticsFail:statisticsFail fail:fail];
}
- (void)asyncAllUserInfomationIs_Cache:(BOOL)is_Cache refreshCache:(BOOL)refreshCache completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail{
    
    NSDictionary *sidic = [JXUserDefaultsObjc loginUserSid];
    NSString *sid = sidic[@"info"];
    NSMutableDictionary *mutableParams = @{}.mutableCopy;
    if (!kStringIsEmpty(sid)) {
        [mutableParams setObject:sid forKey:@"sid"];
    }
    [ZYNetWorking postWithUrl:@"userinfo" params:[JXJudgeStrObjc blockEncryption:mutableParams] Cache:is_Cache refreshCache:refreshCache success:^(id response) {
        if ([response[@"status"] integerValue] == 200) {
            completed(response);
        }else {
            statisticsFail(response);
        }
        
    } fail:^(NSError *error) {
        fail(error);
    }];
}



#pragma mark --- 账户密码登录
+ (void)asyncUserLoginUsername:(NSString*)username password:(NSString *)password completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail {
    [[self shareInstance] asyncUserLoginUsername:username password:password completed:completed statisticsFail:statisticsFail fail:fail];
}
- (void)asyncUserLoginUsername:(NSString*)username password:(NSString *)password completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail{

    // 登录账号密码
    NSMutableDictionary *mutableParams = @{}.mutableCopy;
    [mutableParams setObject:username forKey:@"username"];
    [mutableParams setObject:password forKey:@"password"];
    [ZYNetWorking postWithUrl:@"login" params:[JXJudgeStrObjc blockEncryption:mutableParams] Cache:NO refreshCache:NO success:^(id response) {
        if ([response[@"status"] integerValue] == 200) {
            completed(response);
        }else {
            statisticsFail(response);
        }
    } fail:^(NSError *error) {
        fail(error);
    }];
}

#pragma mark -- 退出登录
+ (void)asyncExitcompleted:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail {
    [[self shareInstance] asyncExitcompleted:completed statisticsFail:statisticsFail fail:fail];
}
- (void)asyncExitcompleted:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail{
    
    NSDictionary *sidic = [JXUserDefaultsObjc loginUserSid];
    NSString *sid = sidic[@"info"];
    NSMutableDictionary *mutableParams = @{}.mutableCopy;
    if (!kStringIsEmpty(sid)) {
        [mutableParams setObject:sid forKey:@"sid"];
    }
    [ZYNetWorking postWithUrl:@"LoginOut" params:[JXJudgeStrObjc blockEncryption:mutableParams] Cache:NO refreshCache:NO success:^(id response) {
        if ([response[@"status"] integerValue] == 200) {
            completed(response);
        }else {
            statisticsFail(response);
        }
    } fail:^(NSError *error) {
        fail(error);
    }];
}

#pragma mark --- 第三方登录 1-qq 2-wx 3-ali
+ (void)asyncThirdPartyLoginToken:(NSString*)token openId:(NSString *)openId is_login:(NSInteger)is_login completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail {
    [[self shareInstance] asyncThirdPartyLoginToken:token openId:openId is_login:is_login completed:completed statisticsFail:statisticsFail fail:fail];
}
- (void)asyncThirdPartyLoginToken:(NSString*)token openId:(NSString *)openId is_login:(NSInteger)is_login completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail{
    
    NSMutableDictionary *mutableParams = @{}.mutableCopy;
    [mutableParams setObject:token forKey:@"token"];
    [mutableParams setObject:openId forKey:@"openid"];
    [mutableParams setObject:[NSString stringWithFormat:@"%ld",is_login] forKey:@"is_login"];
    [ZYNetWorking postWithUrl:@"three_callback" params:[JXJudgeStrObjc blockEncryption:mutableParams] Cache:NO refreshCache:NO success:^(id response) {
        completed(response);
    } fail:^(NSError *error) {
        fail(error);
    }];
}

#pragma mark --- 加入购物车
+ (void)asyncJoinGoodsCartsession_id:(NSString*)session_id good_id:(NSString *)good_id goods_number:(NSInteger)goods_number spec_id:(NSString *)spec_id completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail {
    [[self shareInstance] asyncJoinGoodsCartsession_id:session_id good_id:good_id goods_number:goods_number spec_id:spec_id completed:completed statisticsFail:statisticsFail fail:fail];
}
- (void)asyncJoinGoodsCartsession_id:(NSString*)session_id good_id:(NSString *)good_id goods_number:(NSInteger)goods_number spec_id:(NSString *)spec_id completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail{
    
    NSMutableDictionary *mutableParams = @{}.mutableCopy;
    if (!kStringIsEmpty(session_id)) {
        [mutableParams setObject:session_id forKey:@"sid"];
    }
    [mutableParams setObject:good_id forKey:@"good_id"];
    [mutableParams setObject:[NSString stringWithFormat:@"%ld",goods_number] forKey:@"number"];
    if (spec_id !=nil ||spec_id.length>0) {
        [mutableParams setObject:spec_id forKey:@"spec_id"];
    }
    [ZYNetWorking postWithUrl:@"add_cart" params:[JXJudgeStrObjc blockEncryption:mutableParams] Cache:NO refreshCache:NO success:^(id response) {
        if ([response[@"status"] integerValue] == 200) {
            completed(response);
        }else {
            statisticsFail(response);
        }
    } fail:^(NSError *error) {
        fail(error);
    }];
}

#pragma mark ----- 购物车列表
+ (void)asyncGoodsCartcompleted:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail {
    [[self shareInstance] asyncGoodsCartcompleted:completed statisticsFail:statisticsFail fail:fail];
}
- (void)asyncGoodsCartcompleted:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail{
    
    NSDictionary *sidic = [JXUserDefaultsObjc loginUserSid];
    NSString *sid = sidic[@"info"];
    NSMutableDictionary *mutableParams = @{}.mutableCopy;
    if (!kStringIsEmpty(sid)) {
        [mutableParams setObject:sid forKey:@"sid"];
    }
    [ZYNetWorking postWithUrl:@"cart" params:[JXJudgeStrObjc blockEncryption:mutableParams] Cache:NO refreshCache:NO success:^(id response) {
        if ([response[@"status"] integerValue] == 200) {
            completed(response);
        }else {
            statisticsFail(response);
        }
    } fail:^(NSError *error) {
        fail(error);
    }];
}

#pragma mark --- 第三方登录绑定手机获取验证-- 完善信息
// 获取验证
+ (void)asyncThirVerificationphoneNumber:(NSString*)phoneNumber completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail {
    [[self shareInstance] asyncThirVerificationphoneNumber:phoneNumber completed:completed statisticsFail:statisticsFail fail:fail];
}
- (void)asyncThirVerificationphoneNumber:(NSString*)phoneNumber completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail{
    
    NSMutableDictionary *mutableParams = @{}.mutableCopy;
    [mutableParams setObject:phoneNumber forKey:@"phone"];
    [mutableParams setObject:@"1" forKey:@"status"];
    [ZYNetWorking postWithUrl:@"three_sms" params:[JXJudgeStrObjc blockEncryption:mutableParams] Cache:NO refreshCache:NO success:^(id response) {
        if ([response[@"status"] integerValue] == 200) {
            completed(response);
        }else {
            statisticsFail(response);
        }
    } fail:^(NSError *error) {
        fail(error);
    }];
}
// 绑定手机号
+ (void)asyncThirBindingphoneNumber:(NSString*)phoneNumber phonecode:(NSString *)phonecode thitrLoginType:(NSInteger)thitrLoginType openid:(NSString *)openid completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail {
    [[self shareInstance] asyncThirBindingphoneNumber:phoneNumber phonecode:phonecode thitrLoginType:thitrLoginType openid:openid completed:completed statisticsFail:statisticsFail fail:fail];
}
- (void)asyncThirBindingphoneNumber:(NSString*)phoneNumber phonecode:(NSString *)phonecode thitrLoginType:(NSInteger)thitrLoginType openid:(NSString *)openid completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail{
    
    NSMutableDictionary *mutableParams = @{}.mutableCopy;
    [mutableParams setObject:phoneNumber forKey:@"phone"];
    [mutableParams setObject:phonecode forKey:@"phonecode"];
    [mutableParams setObject:openid forKey:@"openid"];
    [mutableParams setObject:[NSString stringWithFormat:@"%ld",thitrLoginType] forKey:@"cat"];
    [ZYNetWorking postWithUrl:@"userphone" params:[JXJudgeStrObjc blockEncryption:mutableParams] Cache:NO refreshCache:NO success:^(id response) {
        completed(response);
    } fail:^(NSError *error) {
        fail(error);
    }];
}

// 设置账户密码
+ (void)asyncSetUpPassWord:(NSString*)passWord username:(NSString *)username uid:(NSString *)uid  completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail {
    [[self shareInstance] asyncSetUpPassWord:passWord username:username uid:uid completed:completed statisticsFail:statisticsFail fail:fail];
}
- (void)asyncSetUpPassWord:(NSString*)passWord username:(NSString *)username uid:(NSString *)uid  completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail{
    
    NSMutableDictionary *mutableParams = @{}.mutableCopy;
    [mutableParams setObject:username forKey:@"username"];
    [mutableParams setObject:passWord forKey:@"password"];
    
    [mutableParams setObject:uid forKey:@"uid"];
    [ZYNetWorking postWithUrl:@"threereg" params:[JXJudgeStrObjc blockEncryption:mutableParams] Cache:NO refreshCache:NO success:^(id response) {
        if ([response[@"status"] integerValue] == 200) {
            completed(response);
        }else {
            statisticsFail(response);
        }
    } fail:^(NSError *error) {
        fail(error);
    }];
}

#pragma mark ----- 忘记密码
+ (void)asyncForgetPassWord:(NSString*)passWord phone:(NSString *)phone phonecode:(NSString *)phonecode completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail {
    [[self shareInstance] asyncForgetPassWord:passWord phone:phone phonecode:phonecode completed:completed statisticsFail:statisticsFail fail:fail];
}
- (void)asyncForgetPassWord:(NSString*)passWord phone:(NSString *)phone phonecode:(NSString *)phonecode completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail{
    
    NSMutableDictionary *mutableParams = @{}.mutableCopy;
    [mutableParams setObject:phone forKey:@"phone"];
    [mutableParams setObject:passWord forKey:@"password"];
    [mutableParams setObject:phonecode forKey:@"phonecode"];
    [ZYNetWorking postWithUrl:@"foget_passwd" params:[JXJudgeStrObjc blockEncryption:mutableParams] Cache:NO refreshCache:NO success:^(id response) {
        if ([response[@"status"] integerValue] == 200) {
            completed(response);
        }else {
            statisticsFail(response);
        }
    } fail:^(NSError *error) {
        fail(error);
    }];
}
#pragma mark --- 获取购物车产品规格
+ (void)asyncShoppingCartspecificationsgood_id:(NSNumber*)good_id completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail {
    [[self shareInstance] asyncShoppingCartspecificationsgood_id:good_id completed:completed statisticsFail:statisticsFail fail:fail];
}
- (void)asyncShoppingCartspecificationsgood_id:(NSNumber*)good_id completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail{
    
    NSDictionary *sidic = [JXUserDefaultsObjc loginUserSid];
    NSString *sid = sidic[@"info"];
    
    NSMutableDictionary *mutableParams = @{}.mutableCopy;
    [mutableParams setObject:good_id forKey:@"id"];
    if (!kStringIsEmpty(sid)) {
        [mutableParams setObject:sid forKey:@"sid"];
    }
    [ZYNetWorking postWithUrl:@"cart_good_spec" params:[JXJudgeStrObjc blockEncryption:mutableParams] Cache:NO refreshCache:NO success:^(id response) {
        if ([response[@"status"] integerValue] == 200) {
            completed(response);
        }else {
            statisticsFail(response);
        }
    } fail:^(NSError *error) {
        fail(error);
    }];
}

#pragma mark -- 修改购物车产品规格
+ (void)asyncChangShoppingCartspecificationsgood_id:(NSNumber*)good_id spec_id:(NSNumber*)spec_id completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail {
    [[self shareInstance] asyncChangShoppingCartspecificationsgood_id:good_id spec_id:spec_id completed:completed statisticsFail:statisticsFail fail:fail];
}
- (void)asyncChangShoppingCartspecificationsgood_id:(NSNumber*)good_id spec_id:(NSNumber*)spec_id completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail{
    
    NSDictionary *sidic = [JXUserDefaultsObjc loginUserSid];
    NSString *sid = sidic[@"info"];
    
    NSMutableDictionary *mutableParams = @{}.mutableCopy;
    [mutableParams setObject:good_id forKey:@"id"];
    if (!kStringIsEmpty(sid)) {
        [mutableParams setObject:sid forKey:@"sid"];
    }
    [mutableParams setObject:spec_id forKey:@"spec_id"];
    [ZYNetWorking postWithUrl:@"cart_good_spec_edit" params:[JXJudgeStrObjc blockEncryption:mutableParams] Cache:NO refreshCache:NO success:^(id response) {
        if ([response[@"status"] integerValue] == 200) {
            completed(response);
        }else {
            statisticsFail(response);
        }
    } fail:^(NSError *error) {
        fail(error);
    }];
}

#pragma matk -- 删除购物车产品
+ (void)asyncdeleteShoppingCartspecificationsgood_id:(NSArray*)good_id completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail {
    [[self shareInstance] asyncdeleteShoppingCartspecificationsgood_id:good_id completed:completed statisticsFail:statisticsFail fail:fail];
}
- (void)asyncdeleteShoppingCartspecificationsgood_id:(NSArray*)good_id completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail{
    
    NSDictionary *sidic = [JXUserDefaultsObjc loginUserSid];
    NSString *sid = sidic[@"info"];
    
    NSMutableDictionary *mutableParams = @{}.mutableCopy;
    [mutableParams setObject:good_id forKey:@"id"];
    if (!kStringIsEmpty(sid)) {
        [mutableParams setObject:sid forKey:@"sid"];
    }
    [ZYNetWorking postWithUrl:@"del_cart" params:[JXJudgeStrObjc blockEncryption:mutableParams] Cache:NO refreshCache:NO success:^(id response) {
        if ([response[@"status"] integerValue] == 200) {
            completed(response);
        }else {
            statisticsFail(response);
        }
    } fail:^(NSError *error) {
        fail(error);
    }];
}

#pragma mark -- 商品关注
+ (void)asyncCollectionShoppingCartspecificationsgood_id:(NSArray*)good_id completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail {
    [[self shareInstance] asyncCollectionShoppingCartspecificationsgood_id:good_id completed:completed statisticsFail:statisticsFail fail:fail];
}
- (void)asyncCollectionShoppingCartspecificationsgood_id:(NSArray*)good_id completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail{
    
    NSDictionary *sidic = [JXUserDefaultsObjc loginUserSid];
    NSString *sid = sidic[@"info"];
    
    NSMutableDictionary *mutableParams = @{}.mutableCopy;
    [mutableParams setObject:good_id forKey:@"good_id"];
    if (!kStringIsEmpty(sid)) {
        [mutableParams setObject:sid forKey:@"sid"];
    }
    [ZYNetWorking postWithUrl:@"add_keep_good" params:[JXJudgeStrObjc blockEncryption:mutableParams] Cache:NO refreshCache:NO success:^(id response) {
        if ([response[@"status"] integerValue] == 200) {
            completed(response);
        }else {
            statisticsFail(response);
        }
    } fail:^(NSError *error) {
        fail(error);
    }];
}

#pragma mark -- 删除收藏的商品
+ (void)asyncdeleteCollectionShoppingCartspecificationsgood_id:(NSArray*)good_id completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail {
    [[self shareInstance] asyncdeleteCollectionShoppingCartspecificationsgood_id:good_id completed:completed statisticsFail:statisticsFail fail:fail];
}
- (void)asyncdeleteCollectionShoppingCartspecificationsgood_id:(NSArray*)good_id completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail{
    
    NSDictionary *sidic = [JXUserDefaultsObjc loginUserSid];
    NSString *sid = sidic[@"info"];
    
    NSMutableDictionary *mutableParams = @{}.mutableCopy;
    [mutableParams setObject:good_id forKey:@"id"];
    if (!kStringIsEmpty(sid)) {
        [mutableParams setObject:sid forKey:@"sid"];
    }
    [ZYNetWorking postWithUrl:@"user_del_pdckeep" params:[JXJudgeStrObjc blockEncryption:mutableParams] Cache:NO refreshCache:NO success:^(id response) {
        if ([response[@"status"] integerValue] == 200) {
            completed(response);
        }else {
            statisticsFail(response);
        }
    } fail:^(NSError *error) {
        fail(error);
    }];
}

#pragma mark -- 收藏商品列表
+ (void)asyncdeleteCollectionListShoppingCartspecificationsPag:(NSString*)pag completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail {
    [[self shareInstance] asyncdeleteCollectionListShoppingCartspecificationsPag:pag completed:completed statisticsFail:statisticsFail fail:fail];
}
- (void)asyncdeleteCollectionListShoppingCartspecificationsPag:(NSString*)pag completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail{
    
    NSDictionary *sidic = [JXUserDefaultsObjc loginUserSid];
    NSString *sid = sidic[@"info"];
    
    NSMutableDictionary *mutableParams = @{}.mutableCopy;
    [mutableParams setObject:pag forKey:@"p"];
    if (!kStringIsEmpty(sid)) {
        [mutableParams setObject:sid forKey:@"sid"];
    }
    [ZYNetWorking postWithUrl:@"pdckeep" params:[JXJudgeStrObjc blockEncryption:mutableParams] Cache:NO refreshCache:NO success:^(id response) {
        if ([response[@"status"] integerValue] == 200) {
            completed(response);
        }else {
            statisticsFail(response);
        }
    } fail:^(NSError *error) {
        fail(error);
    }];
}

#pragma mark --- 付款
+ (void)asyncPaymentaddress_id:(NSString*)address_id cart_id:(NSArray *)cart_id content:(NSString *)content pay_id:(NSString *)pay_id is_bill:(NSInteger)is_bill rise:(NSString *)rise tax:(NSString *)tax completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail {
    [[self shareInstance] asyncPaymentaddress_id:address_id cart_id:cart_id content:content pay_id:pay_id is_bill:is_bill rise:rise tax:tax completed:completed statisticsFail:statisticsFail fail:fail];
}
- (void)asyncPaymentaddress_id:(NSString*)address_id cart_id:(NSArray *)cart_id content:(NSString *)content pay_id:(NSString *)pay_id is_bill:(NSInteger)is_bill rise:(NSString *)rise tax:(NSString *)tax completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail{
    
    NSDictionary *sidic = [JXUserDefaultsObjc loginUserSid];
    NSString *sid = sidic[@"info"];
    NSMutableDictionary *mutableParams = @{}.mutableCopy;
    if (!kStringIsEmpty(sid)) {
        [mutableParams setObject:sid forKey:@"sid"];
    }
    // 地址id
    [mutableParams setObject:address_id forKey:@"address_id"];
    // 购物车产品id
    [mutableParams setObject:cart_id forKey:@"cart_id"];
    // 1 支付宝 2微信
    [mutableParams setObject:pay_id forKey:@"pay_id"];
    // 买家留言
    if (!kStringIsEmpty(content)) {
        [mutableParams setObject:content forKey:@"content"];
    }
    // 是否开票 0不开  1是开
    [mutableParams setObject:[NSString stringWithFormat:@"%ld",(long)is_bill] forKey:@"is_bill"];
    if (is_bill == 1) {
        // 发票抬头
        if (rise.length>0) {
            [mutableParams setObject:rise forKey:@"rise"];
        }
        if (tax.length>0) {
            // 发票税号
            [mutableParams setObject:tax forKey:@"tax"];
        }
        
    }
    [ZYNetWorking postWithUrl:@"pay" params:[JXJudgeStrObjc blockEncryption:mutableParams] Cache:NO refreshCache:NO success:^(id response) {
        if ([response[@"status"] integerValue] == 200) {
            completed(response);
        }else {
            statisticsFail(response);
        }
    } fail:^(NSError *error) {
        fail(error);
    }];
}

#pragma mark-- 用户地址
// 地址列表 sid
+ (void)asyncAddressOftheUserCompleted:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail {
    [[self shareInstance] asyncAddressOftheUserCompleted:completed statisticsFail:statisticsFail fail:fail];
}
- (void)asyncAddressOftheUserCompleted:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail{
    
    NSDictionary *sidic = [JXUserDefaultsObjc loginUserSid];
    NSString *sid = sidic[@"info"];
    
    
    NSMutableDictionary *mutableParams = @{}.mutableCopy;
    if (!kStringIsEmpty(sid)) {
        [mutableParams setObject:sid forKey:@"sid"];
    }
    [ZYNetWorking postWithUrl:@"user_address" params:[JXJudgeStrObjc blockEncryption:mutableParams] Cache:NO refreshCache:NO success:^(id response) {
        if ([response[@"status"] integerValue] == 200) {
            completed(response);
        }else {
            statisticsFail(response);
        }
    } fail:^(NSError *error) {
        fail(error);
    }];
}
// 上传地址
+ (void)asyncAddtheAddressIs_default:(NSString *)is_default name:(NSString *)name phone:(NSString *)phone address:(NSString *)address s_province:(NSString *)s_province s_city:(NSString *)s_city s_county:(NSString *)s_county completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail {
    [[self shareInstance] asyncAddtheAddressIs_default:is_default name:name phone:phone address:address s_province:s_province s_city:s_city s_county:s_county completed:completed statisticsFail:statisticsFail fail:fail];
}
- (void)asyncAddtheAddressIs_default:(NSString *)is_default name:(NSString *)name phone:(NSString *)phone address:(NSString *)address s_province:(NSString *)s_province s_city:(NSString *)s_city s_county:(NSString *)s_county completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail{
    
    NSDictionary *sidic = [JXUserDefaultsObjc loginUserSid];
    NSString *sid = sidic[@"info"];
    
    NSMutableDictionary *mutableParams = @{}.mutableCopy;
    // sid
    if (!kStringIsEmpty(sid)) {
        [mutableParams setObject:sid forKey:@"sid"];
    }
    
    // 是否为默认地址
    [mutableParams setObject:is_default forKey:@"is_default"];
    // 联系人
    [mutableParams setObject:name forKey:@"name"];
    // 手机号
    [mutableParams setObject:phone forKey:@"phone"];
    // 具体地址
    [mutableParams setObject:address forKey:@"address"];
    // 省
    [mutableParams setObject:s_province forKey:@"s_province"];
    if (!kStringIsEmpty(s_city)) {
        // 市
        [mutableParams setObject:s_city forKey:@"s_city"];
    }
    if (!kStringIsEmpty(s_county)) {
        // 区
        [mutableParams setObject:s_county forKey:@"s_county"];
    }
    [ZYNetWorking postWithUrl:@"user_add_address" params:[JXJudgeStrObjc blockEncryption:mutableParams] Cache:NO refreshCache:NO success:^(id response) {
        if ([response[@"status"] integerValue] == 200) {
            completed(response);
        }else {
            statisticsFail(response);
        }
    } fail:^(NSError *error) {
        fail(error);
    }];
}
// 删除地址
+ (void)asyncDeletetheAddressadress_id:(NSString *)adress_id completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail {
    [[self shareInstance] asyncDeletetheAddressadress_id:adress_id completed:completed statisticsFail:statisticsFail fail:fail];
}
- (void)asyncDeletetheAddressadress_id:(NSString *)adress_id completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail{
    
    NSDictionary *sidic = [JXUserDefaultsObjc loginUserSid];
    NSString *sid = sidic[@"info"];
    NSMutableDictionary *mutableParams = @{}.mutableCopy;
    // sid
    if (!kStringIsEmpty(sid)) {
        [mutableParams setObject:sid forKey:@"sid"];
    }
    // 是否为默认地址
    [mutableParams setObject:adress_id forKey:@"id"];
    [ZYNetWorking postWithUrl:@"user_del_address" params:[JXJudgeStrObjc blockEncryption:mutableParams] Cache:NO refreshCache:NO success:^(id response) {
        if ([response[@"status"] integerValue] == 200) {
            completed(response);
        }else {
            statisticsFail(response);
        }
    } fail:^(NSError *error) {
        fail(error);
    }];
}
// 编辑地址
+ (void)asyncEditorAddressIs_default:(NSString *)is_default address_id:(NSString *)address_id name:(NSString *)name phone:(NSString *)phone address:(NSString *)address s_province:(NSString *)s_province s_city:(NSString *)s_city s_county:(NSString *)s_county completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail {
    [[self shareInstance] asyncEditorAddressIs_default:is_default address_id:address_id name:name phone:phone address:address s_province:s_province s_city:s_city s_county:s_county completed:completed statisticsFail:statisticsFail fail:fail];
}
- (void)asyncEditorAddressIs_default:(NSString *)is_default address_id:(NSString *)address_id name:(NSString *)name phone:(NSString *)phone address:(NSString *)address s_province:(NSString *)s_province s_city:(NSString *)s_city s_county:(NSString *)s_county completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail {
    
    NSDictionary *sidic = [JXUserDefaultsObjc loginUserSid];
    NSString *sid = sidic[@"info"];
    NSMutableDictionary *mutableParams = @{}.mutableCopy;
    // sid
    if (!kStringIsEmpty(sid)) {
        [mutableParams setObject:sid forKey:@"sid"];
    }
    // 是否为默认地址
    [mutableParams setObject:is_default forKey:@"is_default"];
    // 联系人
    [mutableParams setObject:name forKey:@"name"];
    // 手机号
    [mutableParams setObject:phone forKey:@"phone"];
    // 具体地址
    [mutableParams setObject:address forKey:@"address"];
    // 省
    [mutableParams setObject:s_province forKey:@"s_province"];
    if (s_city.length != 0 || s_city != nil) {
        // 市
        [mutableParams setObject:s_city forKey:@"s_city"];
    }
    if (s_county.length != 0 || s_county != nil) {
        // 区
        [mutableParams setObject:s_county forKey:@"s_county"];
    }
    [mutableParams setObject:address_id forKey:@"id"];
    [ZYNetWorking postWithUrl:@"edit_user_address" params:[JXJudgeStrObjc blockEncryption:mutableParams] Cache:NO refreshCache:NO success:^(id response) {
        if ([response[@"status"] integerValue] == 200) {
            completed(response);
        }else {
            statisticsFail(response);
        }
    } fail:^(NSError *error) {
        fail(error);
    }];
}
#pragma mark --- 用户订单
+ (void)asyncuser_orderStatus:(NSString *)status ordersn:(NSString *)ordersn completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail {
    [[self shareInstance] asyncuser_orderStatus:status ordersn:ordersn completed:completed statisticsFail:statisticsFail fail:fail];
}
- (void)asyncuser_orderStatus:(NSString *)status ordersn:(NSString *)ordersn completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail{
    
    NSDictionary *sidic = [JXUserDefaultsObjc loginUserSid];
    NSString *sid = sidic[@"info"];
    NSMutableDictionary *mutableParams = @{}.mutableCopy;
    // sid
    if (!kStringIsEmpty(sid)) {
        [mutableParams setObject:sid forKey:@"sid"];
    }
    // 状态码
    if (!kStringIsEmpty(status)) {
        [mutableParams setObject:status forKey:@"status"];
    }
    if (!kStringIsEmpty(ordersn)) {
        [mutableParams setObject:ordersn forKey:@"ordersn"];
    }
    
    [ZYNetWorking postWithUrl:@"user_order" params:[JXJudgeStrObjc blockEncryption:mutableParams] Cache:NO refreshCache:NO success:^(id response) {
        if ([response[@"status"] integerValue] == 200) {
            completed(response);
        }else {
            statisticsFail(response);
        }
    } fail:^(NSError *error) {
        fail(error);
    }];
}
#pragma mark -- 购物车数量增减
+ (void)goodsCartIncreaseOrDecrease:(NSString *)goodsnumber goodid:(NSString *)goodid completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail {
    [[self shareInstance] goodsCartIncreaseOrDecrease:goodsnumber goodid:goodid completed:completed statisticsFail:statisticsFail fail:fail];
}
- (void)goodsCartIncreaseOrDecrease:(NSString *)goodsnumber goodid:(NSString *)goodid completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail{
    
    NSDictionary *sidic = [JXUserDefaultsObjc loginUserSid];
    NSString *sid = sidic[@"info"];
    
    NSMutableDictionary *mutableParams = @{}.mutableCopy;
    [mutableParams setObject:goodid forKey:@"id"];
    [mutableParams setObject:goodsnumber forKey:@"number"];
    
    // sid
    if (!kStringIsEmpty(sid)) {
        [mutableParams setObject:sid forKey:@"sid"];
    }
    [ZYNetWorking postWithUrl:@"change_cart_num" params:[JXJudgeStrObjc blockEncryption:mutableParams] Cache:NO refreshCache:NO success:^(id response) {
        if ([response[@"status"] integerValue] == 200) {
            completed(response);
        }else {
            statisticsFail(response);
        }
    } fail:^(NSError *error) {
        fail(error);
    }];
}
#pragma mark -- 店铺展示关注列表
+ (void)goodsListFoeShop:(NSString *)pag completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail {
    [[self shareInstance] goodsListFoeShop:pag completed:completed statisticsFail:statisticsFail fail:fail];
}
- (void)goodsListFoeShop:(NSString *)pag completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail{
    
    NSDictionary *sidic = [JXUserDefaultsObjc loginUserSid];
    NSString *sid = sidic[@"info"];
    NSMutableDictionary *mutableParams = @{}.mutableCopy;
    [mutableParams setObject:pag forKey:@"p"];
    // sid
    if (!kStringIsEmpty(sid)) {
        [mutableParams setObject:sid forKey:@"sid"];
    }
    [ZYNetWorking postWithUrl:@"user_keep_shop" params:[JXJudgeStrObjc blockEncryption:mutableParams] Cache:NO refreshCache:NO success:^(id response) {
        if ([response[@"status"] integerValue] == 200) {
            completed(response);
        }else {
            statisticsFail(response);
        }
    } fail:^(NSError *error) {
        fail(error);
    }];
}
#pragma mark -- 商品浏览记录
+ (void)asyncGoodsListForbrowse:(NSString *)pag completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail {
    [[self shareInstance] asyncGoodsListForbrowse:pag completed:completed statisticsFail:statisticsFail fail:fail];
}
- (void)asyncGoodsListForbrowse:(NSString *)pag completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail{
    
    NSDictionary *sidic = [JXUserDefaultsObjc loginUserSid];
    NSString *sid = sidic[@"info"];
    NSMutableDictionary *mutableParams = @{}.mutableCopy;
    [mutableParams setObject:pag forKey:@"p"];
    // sid
    if (!kStringIsEmpty(sid)) {
        [mutableParams setObject:sid forKey:@"sid"];
    }
    [ZYNetWorking postWithUrl:@"user_look_good" params:[JXJudgeStrObjc blockEncryption:mutableParams] Cache:NO refreshCache:NO success:^(id response) {
        if ([response[@"status"] integerValue] == 200) {
            completed(response);
        }else {
            statisticsFail(response);
        }
    } fail:^(NSError *error) {
        fail(error);
    }];
}
#pragma mark -- 删除商品浏览记录
+ (void)asyncdeleteGoodsListForbrowse:(NSString *)goodid completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail {
    [[self shareInstance] asyncdeleteGoodsListForbrowse:goodid completed:completed statisticsFail:statisticsFail fail:fail];
}
- (void)asyncdeleteGoodsListForbrowse:(NSString *)goodid completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail{
    
    NSDictionary *sidic = [JXUserDefaultsObjc loginUserSid];
    NSString *sid = sidic[@"info"];
    NSMutableDictionary *mutableParams = @{}.mutableCopy;
    [mutableParams setObject:goodid forKey:@"id"];
    // sid
    if (!kStringIsEmpty(sid)) {
        [mutableParams setObject:sid forKey:@"sid"];
    }
    [ZYNetWorking postWithUrl:@"user_del_history" params:[JXJudgeStrObjc blockEncryption:mutableParams] Cache:NO refreshCache:NO success:^(id response) {
        if ([response[@"status"] integerValue] == 200) {
            completed(response);
        }else {
            statisticsFail(response);
        }
    } fail:^(NSError *error) {
        fail(error);
    }];
}


#pragma mark -- 积分
+ (void)asyncUserIntegral:(NSString *)pag completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail {
    [[self shareInstance] asyncUserIntegral:pag completed:completed statisticsFail:statisticsFail fail:fail];
}
- (void)asyncUserIntegral:(NSString *)pag completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail{
    
    NSDictionary *sidic = [JXUserDefaultsObjc loginUserSid];
    NSString *sid = sidic[@"info"];
    NSMutableDictionary *mutableParams = @{}.mutableCopy;
    [mutableParams setObject:pag forKey:@"p"];
    // sid
    if (!kStringIsEmpty(sid)) {
        [mutableParams setObject:sid forKey:@"sid"];
    }
    [ZYNetWorking postWithUrl:@"user_score" params:[JXJudgeStrObjc blockEncryption:mutableParams] Cache:NO refreshCache:NO success:^(id response) {
        if ([response[@"status"] integerValue] == 200) {
            completed(response);
        }else {
            statisticsFail(response);
        }
    } fail:^(NSError *error) {
        fail(error);
    }];
}
#pragma mark -- 问答 提问
+ (void)asyncQuestionAndAnswer:(NSString *)pag completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail {
    [[self shareInstance] asyncQuestionAndAnswer:pag completed:completed statisticsFail:statisticsFail fail:fail];
}
- (void)asyncQuestionAndAnswer:(NSString *)pag completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail{
    
    NSDictionary *sidic = [JXUserDefaultsObjc loginUserSid];
    NSString *sid = sidic[@"info"];
    NSMutableDictionary *mutableParams = @{}.mutableCopy;
    [mutableParams setObject:pag forKey:@"p"];
    // sid
    if (!kStringIsEmpty(sid)) {
        [mutableParams setObject:sid forKey:@"sid"];
    }
    [ZYNetWorking postWithUrl:@"user_question" params:[JXJudgeStrObjc blockEncryption:mutableParams] Cache:NO refreshCache:NO success:^(id response) {
        if ([response[@"status"] integerValue] == 200) {
            completed(response);
        }else {
            statisticsFail(response);
        }
    } fail:^(NSError *error) {
        fail(error);
    }];
}
// 问答
+ (void)asyncAskQuestions:(NSString *)content completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail {
    [[self shareInstance] asyncAskQuestions:content completed:completed statisticsFail:statisticsFail fail:fail];
}
- (void)asyncAskQuestions:(NSString *)content completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail{
    
    NSDictionary *sidic = [JXUserDefaultsObjc loginUserSid];
    NSString *sid = sidic[@"info"];
    NSMutableDictionary *mutableParams = @{}.mutableCopy;
    [mutableParams setObject:content forKey:@"content"];
    // sid
    if (!kStringIsEmpty(sid)) {
        [mutableParams setObject:sid forKey:@"sid"];
    }
    [ZYNetWorking postWithUrl:@"user_add_question" params:[JXJudgeStrObjc blockEncryption:mutableParams] Cache:NO refreshCache:NO success:^(id response) {
        if ([response[@"status"] integerValue] == 200) {
            completed(response);
        }else {
            statisticsFail(response);
        }
    } fail:^(NSError *error) {
        fail(error);
    }];
}

#pragma mark --- 关注商家
+ (void)asyncFocusOnBusiness:(NSString *)shop_id completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail {
    [[self shareInstance] asyncFocusOnBusiness:shop_id completed:completed statisticsFail:statisticsFail fail:fail];
}
- (void)asyncFocusOnBusiness:(NSString *)shop_id completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail{
    
    NSDictionary *sidic = [JXUserDefaultsObjc loginUserSid];
    NSString *sid = sidic[@"info"];
    NSMutableDictionary *mutableParams = @{}.mutableCopy;
    [mutableParams setObject:shop_id forKey:@"seller_id"];
    // sid
    if (!kStringIsEmpty(sid)) {
        [mutableParams setObject:sid forKey:@"sid"];
    }
    [ZYNetWorking postWithUrl:@"add_shopkeep" params:[JXJudgeStrObjc blockEncryption:mutableParams] Cache:NO refreshCache:NO success:^(id response) {
        if ([response[@"status"] integerValue] == 200) {
            completed(response);
        }else {
            statisticsFail(response);
        }
    } fail:^(NSError *error) {
        fail(error);
    }];
}

// 取消关注商家
+ (void)asyncCancelFocusOnBusiness:(NSString *)shop_id completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail {
    [[self shareInstance] asyncCancelFocusOnBusiness:shop_id completed:completed statisticsFail:statisticsFail fail:fail];
}
- (void)asyncCancelFocusOnBusiness:(NSString *)shop_id completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail{
    
    NSDictionary *sidic = [JXUserDefaultsObjc loginUserSid];
    NSString *sid = sidic[@"info"];
    NSMutableDictionary *mutableParams = @{}.mutableCopy;
    [mutableParams setObject:shop_id forKey:@"seller_id"];
    // sid
    if (!kStringIsEmpty(sid)) {
        [mutableParams setObject:sid forKey:@"sid"];
    }
    [ZYNetWorking postWithUrl:@"user_del_shopkeep" params:[JXJudgeStrObjc blockEncryption:mutableParams] Cache:NO refreshCache:NO success:^(id response) {
        if ([response[@"status"] integerValue] == 200) {
            completed(response);
        }else {
            statisticsFail(response);
        }
    } fail:^(NSError *error) {
        fail(error);
    }];
}

#pragma mark --- 取消订单
+ (void)asyncCanceltheOrder:(NSString *)ordersn completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail {
    [[self shareInstance] asyncCanceltheOrder:ordersn completed:completed statisticsFail:statisticsFail fail:fail];
}
- (void)asyncCanceltheOrder:(NSString *)ordersn completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail{
    
    NSDictionary *sidic = [JXUserDefaultsObjc loginUserSid];
    NSString *sid = sidic[@"info"];
    NSMutableDictionary *mutableParams = @{}.mutableCopy;
    [mutableParams setObject:ordersn forKey:@"ordersn"];
    // sid
    if (!kStringIsEmpty(sid)) {
        [mutableParams setObject:sid forKey:@"sid"];
    }
    [ZYNetWorking postWithUrl:@"cancel_order" params:[JXJudgeStrObjc blockEncryption:mutableParams] Cache:NO refreshCache:NO success:^(id response) {
        if ([response[@"status"] integerValue] == 200) {
            completed(response);
        }else {
            statisticsFail(response);
        }
    } fail:^(NSError *error) {
        fail(error);
    }];
}
#pragma mark --- 提醒发货
+ (void)asyncRemindthedeliveryOrder:(NSString *)ordersn completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail {
    [[self shareInstance] asyncRemindthedeliveryOrder:ordersn completed:completed statisticsFail:statisticsFail fail:fail];
}
- (void)asyncRemindthedeliveryOrder:(NSString *)ordersn completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail{
    
    NSDictionary *sidic = [JXUserDefaultsObjc loginUserSid];
    NSString *sid = sidic[@"info"];
    NSMutableDictionary *mutableParams = @{}.mutableCopy;
    [mutableParams setObject:ordersn forKey:@"ordersn"];
    // sid
    if (!kStringIsEmpty(sid)) {
        [mutableParams setObject:sid forKey:@"sid"];
    }
    [ZYNetWorking postWithUrl:@"remind_delivery" params:[JXJudgeStrObjc blockEncryption:mutableParams] Cache:NO refreshCache:NO success:^(id response) {
        if ([response[@"status"] integerValue] == 200) {
            completed(response);
        }else {
            statisticsFail(response);
        }
    } fail:^(NSError *error) {
        fail(error);
    }];
}
#pragma mark --- 确认收货
+ (void)asyncConfirmtheGoodsOrder:(NSString *)ordersn completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail {
    [[self shareInstance] asyncConfirmtheGoodsOrder:ordersn completed:completed statisticsFail:statisticsFail fail:fail];
}
- (void)asyncConfirmtheGoodsOrder:(NSString *)ordersn completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail{
    
    NSDictionary *sidic = [JXUserDefaultsObjc loginUserSid];
    NSString *sid = sidic[@"info"];
    NSMutableDictionary *mutableParams = @{}.mutableCopy;
    [mutableParams setObject:ordersn forKey:@"ordersn"];
    // sid
    if (!kStringIsEmpty(sid)) {
        [mutableParams setObject:sid forKey:@"sid"];
    }
    [ZYNetWorking postWithUrl:@"submit_order" params:[JXJudgeStrObjc blockEncryption:mutableParams] Cache:NO refreshCache:NO success:^(id response) {
        if ([response[@"status"] integerValue] == 200) {
            completed(response);
        }else {
            statisticsFail(response);
        }
    } fail:^(NSError *error) {
        fail(error);
    }];
}
#pragma mark --- 删除订单
+ (void)asyncDeleteOrder:(NSString *)ordersn completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail{
    [[self shareInstance] asyncDeleteOrder:ordersn completed:completed statisticsFail:statisticsFail fail:fail];
}
- (void)asyncDeleteOrder:(NSString *)ordersn completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail{
    
    NSDictionary *sidic = [JXUserDefaultsObjc loginUserSid];
    NSString *sid = sidic[@"info"];
    NSMutableDictionary *mutableParams = @{}.mutableCopy;
    [mutableParams setObject:ordersn forKey:@"ordersn"];
    // sid
    if (!kStringIsEmpty(sid)) {
        [mutableParams setObject:sid forKey:@"sid"];
    }
    [ZYNetWorking postWithUrl:@"del_order" params:[JXJudgeStrObjc blockEncryption:mutableParams] Cache:NO refreshCache:NO success:^(id response) {
        if ([response[@"status"] integerValue] == 200) {
            completed(response);
        }else {
            statisticsFail(response);
        }
    } fail:^(NSError *error) {
        fail(error);
    }];
}
#pragma mark --- 取消退款
+ (void)asynccancelTheRefundOrder:(NSString *)ordersn completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail{
    [[self shareInstance] asynccancelTheRefundOrder:ordersn completed:completed statisticsFail:statisticsFail fail:fail];
}
- (void)asynccancelTheRefundOrder:(NSString *)ordersn completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail{
    
    NSDictionary *sidic = [JXUserDefaultsObjc loginUserSid];
    NSString *sid = sidic[@"info"];
    NSMutableDictionary *mutableParams = @{}.mutableCopy;
    [mutableParams setObject:ordersn forKey:@"ordersn"];
    // sid
    if (!kStringIsEmpty(sid)) {
        [mutableParams setObject:sid forKey:@"sid"];
    }
    [ZYNetWorking postWithUrl:@"cancel_good" params:[JXJudgeStrObjc blockEncryption:mutableParams] Cache:NO refreshCache:NO success:^(id response) {
        if ([response[@"status"] integerValue] == 200) {
            completed(response);
        }else {
            statisticsFail(response);
        }
    } fail:^(NSError *error) {
        fail(error);
    }];
}



#pragma mark -- 推荐
+ (void)asyncRecommendedcompleted:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail {
    [[self shareInstance] asyncRecommendedcompleted:completed statisticsFail:statisticsFail fail:fail];
}
- (void)asyncRecommendedcompleted:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail {

    [ZYNetWorking getWithUrl:@"tj_good" params:nil Cache:YES refreshCache:NO success:^(id response) {
        if ([response[@"status"] integerValue] == 200) {
            completed(response);
        }else {
            statisticsFail(response);
        }
    } fail:^(NSError *error) {
        fail(error);
    }];
}

#pragma mark --- 邮箱验证码获取 绑定 修改
+ (void)asyncVerificationCodeforemail:(NSString *)email completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail {
    [[self shareInstance] asyncVerificationCodeforemail:email completed:completed statisticsFail:statisticsFail fail:fail];
}
- (void)asyncVerificationCodeforemail:(NSString *)email completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail{
    
    NSDictionary *sidic = [JXUserDefaultsObjc loginUserSid];
    NSString *sid = sidic[@"info"];
    NSMutableDictionary *mutableParams = @{}.mutableCopy;
    [mutableParams setObject:email forKey:@"email"];
    // sid
    if (!kStringIsEmpty(sid)) {
        [mutableParams setObject:sid forKey:@"sid"];
    }
    [ZYNetWorking postWithUrl:@"send_email" params:[JXJudgeStrObjc blockEncryption:mutableParams] Cache:NO refreshCache:NO success:^(id response) {
        if ([response[@"status"] integerValue] == 200) {
            completed(response);
        }else {
            statisticsFail(response);
        }
    } fail:^(NSError *error) {
        fail(error);
    }];
}
+ (void)asyncSetUpemail:(NSString *)email email_code:(NSString *)email_code completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail {
    [[self shareInstance] asyncSetUpemail:email email_code:email_code completed:completed statisticsFail:statisticsFail fail:fail];
}
- (void)asyncSetUpemail:(NSString *)email email_code:(NSString *)email_code completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail{
    
    NSDictionary *sidic = [JXUserDefaultsObjc loginUserSid];
    NSString *sid = sidic[@"info"];
    NSMutableDictionary *mutableParams = @{}.mutableCopy;
    [mutableParams setObject:email forKey:@"email"];
    [mutableParams setObject:email_code forKey:@"emailcode"];
    // sid
    if (!kStringIsEmpty(sid)) {
        [mutableParams setObject:sid forKey:@"sid"];
    }
    [ZYNetWorking postWithUrl:@"set_email" params:[JXJudgeStrObjc blockEncryption:mutableParams] Cache:NO refreshCache:NO success:^(id response) {
        if ([response[@"status"] integerValue] == 200) {
            completed(response);
        }else {
            statisticsFail(response);
        }
    } fail:^(NSError *error) {
        fail(error);
    }];
}

+ (void)asyncModifyemail:(NSString *)email email_code:(NSString *)email_code completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail {
    [[self shareInstance] asyncModifyemail:email email_code:email_code completed:completed statisticsFail:statisticsFail fail:fail];
}
- (void)asyncModifyemail:(NSString *)email email_code:(NSString *)email_code completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail{
    
    NSDictionary *sidic = [JXUserDefaultsObjc loginUserSid];
    NSString *sid = sidic[@"info"];
    NSMutableDictionary *mutableParams = @{}.mutableCopy;
    [mutableParams setObject:email forKey:@"email"];
    [mutableParams setObject:email_code forKey:@"emailcode"];
    // sid
    if (!kStringIsEmpty(sid)) {
        [mutableParams setObject:sid forKey:@"sid"];
    }
    [ZYNetWorking postWithUrl:@"edit_email" params:[JXJudgeStrObjc blockEncryption:mutableParams] Cache:NO refreshCache:NO success:^(id response) {
        if ([response[@"status"] integerValue] == 200) {
            completed(response);
        }else {
            statisticsFail(response);
        }
    } fail:^(NSError *error) {
        fail(error);
    }];
}


#pragma mark --- 修改用户信息 1性别 2QQ 3手机号
+ (void)asyncsave_info:(NSString *)type value:(NSString *)value completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail {
    [[self shareInstance] asyncsave_info:type value:value completed:completed statisticsFail:statisticsFail fail:fail];
}
- (void)asyncsave_info:(NSString *)type value:(NSString *)value completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail{
    
    NSDictionary *sidic = [JXUserDefaultsObjc loginUserSid];
    NSString *sid = sidic[@"info"];
    NSMutableDictionary *mutableParams = @{}.mutableCopy;
    [mutableParams setObject:type forKey:@"type"];
    [mutableParams setObject:value forKey:@"value"];
    // sid
    if (!kStringIsEmpty(sid)) {
        [mutableParams setObject:sid forKey:@"sid"];
    }
    [ZYNetWorking postWithUrl:@"save_info" params:[JXJudgeStrObjc blockEncryption:mutableParams] Cache:NO refreshCache:NO success:^(id response) {
        if ([response[@"status"] integerValue] == 200) {
            completed(response);
        }else {
            statisticsFail(response);
        }
    } fail:^(NSError *error) {
        fail(error);
    }];
}

#pragma mark --- 实名认证 获取用户身份证 名字
+ (void)asyncCertification:(NSString *)realname noid:(NSString *)noid completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail {
    [[self shareInstance] asyncCertification:realname noid:noid completed:completed statisticsFail:statisticsFail fail:fail];
}
- (void)asyncCertification:(NSString *)realname noid:(NSString *)noid completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail{
    
    NSDictionary *sidic = [JXUserDefaultsObjc loginUserSid];
    NSString *sid = sidic[@"info"];
    NSMutableDictionary *mutableParams = @{}.mutableCopy;
    [mutableParams setObject:realname forKey:@"realname"];
    [mutableParams setObject:noid forKey:@"noid"];
    // sid
    if (!kStringIsEmpty(sid)) {
        [mutableParams setObject:sid forKey:@"sid"];
    }
    [ZYNetWorking postWithUrl:@"user_is_realname" params:[JXJudgeStrObjc blockEncryption:mutableParams] Cache:NO refreshCache:NO success:^(id response) {
        if ([response[@"status"] integerValue] == 200) {
            completed(response);
        }else {
            statisticsFail(response);
        }
    } fail:^(NSError *error) {
        fail(error);
    }];
}
+ (void)asyncObtainCertificationCompleted:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail {
    [[self shareInstance] asyncObtainCertificationCompleted:completed statisticsFail:statisticsFail fail:fail];
}
- (void)asyncObtainCertificationCompleted:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail{
    
    NSDictionary *sidic = [JXUserDefaultsObjc loginUserSid];
    NSString *sid = sidic[@"info"];
    NSMutableDictionary *mutableParams = @{}.mutableCopy;
    // sid
    if (!kStringIsEmpty(sid)) {
        [mutableParams setObject:sid forKey:@"sid"];
    }
    [ZYNetWorking postWithUrl:@"user_realname" params:[JXJudgeStrObjc blockEncryption:mutableParams] Cache:NO refreshCache:NO success:^(id response) {
        if ([response[@"status"] integerValue] == 200) {
            completed(response);
        }else {
            statisticsFail(response);
        }
    } fail:^(NSError *error) {
        fail(error);
    }];
}


#pragma mark --- 修改密码
+ (void)asyncChangethePassword:(NSString *)password npassword:(NSString *)npassword completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail {
    [[self shareInstance] asyncChangethePassword:password npassword:npassword Completed:completed statisticsFail:statisticsFail fail:fail];
}
- (void)asyncChangethePassword:(NSString *)password npassword:(NSString *)npassword Completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail{
    
    NSDictionary *sidic = [JXUserDefaultsObjc loginUserSid];
    NSString *sid = sidic[@"info"];
    NSMutableDictionary *mutableParams = @{}.mutableCopy;
    [mutableParams setObject:password forKey:@"password"];
    [mutableParams setObject:npassword forKey:@"npassword"];
    // sid
    if (!kStringIsEmpty(sid)) {
        [mutableParams setObject:sid forKey:@"sid"];
    }
    
    [ZYNetWorking postWithUrl:@"do_edit_password" params:[JXJudgeStrObjc blockEncryption:mutableParams] Cache:NO refreshCache:NO success:^(id response) {
        if ([response[@"status"] integerValue] == 200) {
            completed(response);
        }else {
            statisticsFail(response);
        }
    } fail:^(NSError *error) {
        fail(error);
    }];
}

#pragma mark -- 店铺数据
+ (void)asyncStoreseller_id:(NSString *)seller_id completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail {
    [[self shareInstance] asyncStoreseller_id:seller_id completed:completed statisticsFail:statisticsFail fail:fail];
}
- (void)asyncStoreseller_id:(NSString *)seller_id completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail{
    NSDictionary *sidic = [JXUserDefaultsObjc loginUserSid];
    NSString *sid = sidic[@"info"];
    NSMutableDictionary *mutableParams = @{}.mutableCopy;
    // sid
    if (!kStringIsEmpty(sid)) {
        [mutableParams setObject:sid forKey:@"sid"];
    }
    [mutableParams setObject:seller_id forKey:@"seller_id"];
    [ZYNetWorking postWithUrl:@"shop_type_good" params:[JXJudgeStrObjc blockEncryption:mutableParams] Cache:NO refreshCache:YES success:^(id response) {
        if ([response[@"status"] integerValue] == 200) {
            completed(response);
        }else {
            statisticsFail(response);
        }
    } fail:^(NSError *error) {
        fail(error);
    }];
}

#pragma mark -- 首页商品更多产品信息
+ (void)asyncMoreGoodsid:(NSString *)goodsid buy_num:(NSString *)buy_num good_price:(NSString *)good_price page:(NSString *)page completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail {

    [[self shareInstance] asyncMoreGoodsid:goodsid buy_num:buy_num good_price:good_price page:page completed:completed statisticsFail:statisticsFail fail:fail];
}
- (void)asyncMoreGoodsid:(NSString *)goodsid buy_num:(NSString *)buy_num good_price:(NSString *)good_price page:(NSString *)page completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail {

    NSMutableDictionary *mutableParams = @{}.mutableCopy;
    [mutableParams setObject:page forKey:@"p"];
    [mutableParams setObject:goodsid forKey:@"type_id"];
    if (!kStringIsEmpty(buy_num)) {
        [mutableParams setObject:buy_num forKey:@"buy_num"];
    }
    if (!kStringIsEmpty(good_price)) {
        [mutableParams setObject:good_price forKey:@"good_price"];
    }
    
    [ZYNetWorking postWithUrl:@"good_classify" params:mutableParams Cache:NO refreshCache:NO success:^(id response) {
        if ([response[@"status"] integerValue] == 200) {
            completed(response);
        }else {
            statisticsFail(response);
        }
    } fail:^(NSError *error) {
        fail(error);
    }];
}

#pragma mark -- 热销
+ (void)asynchotCakesbuy_num:(NSString *)buy_num good_price:(NSString *)good_price page:(NSString *)page completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail {

    [[self shareInstance] asynchotCakesbuy_num:buy_num good_price:good_price page:page completed:completed statisticsFail:statisticsFail fail:fail];
}
- (void)asynchotCakesbuy_num:(NSString *)buy_num good_price:(NSString *)good_price page:(NSString *)page completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail {

    NSMutableDictionary *mutableParams = @{}.mutableCopy;
    [mutableParams setObject:page forKey:@"p"];
    if (!kStringIsEmpty(buy_num)) {
        [mutableParams setObject:buy_num forKey:@"buy_num"];
    }
    if (!kStringIsEmpty(good_price)) {
        [mutableParams setObject:good_price forKey:@"good_price"];
    }
    [ZYNetWorking postWithUrl:@"hot_list" params:mutableParams Cache:NO refreshCache:NO success:^(id response) {
        if ([response[@"status"] integerValue] == 200) {
            completed(response);
        }else {
            statisticsFail(response);
        }
    } fail:^(NSError *error) {
        fail(error);
    }];
}


#pragma mark --- 首页新品
+ (void)asyncNewGoodbuy_num:(NSString *)buy_num good_price:(NSString *)good_price page:(NSString *)page completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail {

    [[self shareInstance] asyncNewGoodbuy_num:buy_num good_price:good_price page:page completed:completed statisticsFail:statisticsFail fail:fail];
}
- (void)asyncNewGoodbuy_num:(NSString *)buy_num good_price:(NSString *)good_price page:(NSString *)page completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail {
    
    NSMutableDictionary *mutableParams = @{}.mutableCopy;
    [mutableParams setObject:page forKey:@"p"];
    if (!kStringIsEmpty(buy_num)) {
        [mutableParams setObject:buy_num forKey:@"buy_num"];
    }
    if (!kStringIsEmpty(good_price)) {
        [mutableParams setObject:good_price forKey:@"good_price"];
    }
    [ZYNetWorking postWithUrl:@"new_arrival" params:mutableParams Cache:NO refreshCache:NO success:^(id response) {
        if ([response[@"status"] integerValue] == 200) {
            completed(response);
        }else {
            statisticsFail(response);
        }
    } fail:^(NSError *error) {
        fail(error);
    }];
}

#pragma mark --- 详情页商品数量查询
+ (void)asynccommentsgood:(NSString *)good_id completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail {
    
    [[self shareInstance] asynccommentsgood:good_id completed:completed statisticsFail:statisticsFail fail:fail];
}
- (void)asynccommentsgood:(NSString *)good_id completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail{
    NSDictionary *sidic = [JXUserDefaultsObjc loginUserSid];
    NSString *sid = sidic[@"info"];
    NSMutableDictionary *mutableParams = @{}.mutableCopy;
    // sid
    if (!kStringIsEmpty(sid)) {
        [mutableParams setObject:sid forKey:@"sid"];
    }
    [ZYNetWorking postWithUrl:@"info_goodcart" params:[JXJudgeStrObjc blockEncryption:mutableParams] Cache:NO refreshCache:NO success:^(id response) {
        if ([response[@"status"] integerValue] == 200) {
            completed(response);
        }else {
            statisticsFail(response);
        }
    } fail:^(NSError *error) {
        fail(error);
    }];
}


#pragma mark --- 上传相册
+ (void)asyncphoto:(NSString *)basephoto completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail {
    [[self shareInstance] asyncphoto:basephoto completed:completed statisticsFail:statisticsFail fail:fail];
}
- (void)asyncphoto:(NSString *)basephoto completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail{
    NSDictionary *sidic = [JXUserDefaultsObjc loginUserSid];
    NSString *sid = sidic[@"info"];
    NSMutableDictionary *mutableParams = @{}.mutableCopy;
    // sid
    if (!kStringIsEmpty(sid)) {
        [mutableParams setObject:sid forKey:@"sid"];
    }
    
    // 公秘 私秘
    NSString *public_key_path = [[NSBundle mainBundle] pathForResource:@"public_key.der" ofType:nil];
    NSString *paramString = [mutableParams JSONString];
    // 拼接的字符串
    NSMutableString *together = @"".mutableCopy;
    // 获取字节数
    NSInteger length = [paramString lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
    // 字典转字符串
    NSString *encryptionStr;
    // 上传的加密字符串
    NSString *encryptionAll;
    // 是否分段加密
    NSString *encryptionNumber;
    if (length>=117)
    { // 分段加密
        encryptionNumber = @"2";
        // 取到加密的值
        encryptionStr = [mutableParams JSONString];
        NSString *prents = [[encryptionStr dataUsingEncoding:NSUTF8StringEncoding] base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        for (int i = 0; i<ceilf(prents.length / 117)+1; i++)
        {
            NSString *subStr = [prents substringWithRange:NSMakeRange(i * 117, MIN(117, prents.length - i * 117))];
            if (subStr.length>0&&subStr!=nil)
            {
                NSString *encryptStr = [RSAEncryptor encryptString:subStr publicKeyWithContentsOfFile:public_key_path];
                //拼接字符串
                [together appendString:[NSString stringWithFormat:@"%@",encryptStr]];
            }
        }
        encryptionAll = [NSString stringWithString:together];
    }
    else
    { // 直接加密
        encryptionNumber = @"1";
        // 取到加密的值
        encryptionStr = [mutableParams JSONString];
        encryptionAll = [RSAEncryptor encryptString:encryptionStr publicKeyWithContentsOfFile:public_key_path];
    }
    NSMutableDictionary *dicPart = @{}.mutableCopy;
    [dicPart setValue:encryptionNumber forKey:@"is_section"];
    [dicPart setValue:encryptionAll forKey:@"sign"];
    [dicPart setObject:basephoto forKey:@"photo"];
    [ZYNetWorking postWithUrl:@"img_base64" params:dicPart Cache:NO refreshCache:NO success:^(id response) {
        if ([response[@"status"] integerValue] == 200) {
            completed(response);
        }else {
            statisticsFail(response);
        }
    } fail:^(NSError *error) {
        fail(error);
    }];
}

- (NSString *)configUUid{
    //    char data[32];
    //    for (int x=0;x<32;data[x++] = (char)('A' + (arc4random_uniform(26))));
    //    return [[NSString alloc] initWithBytes:data length:32 encoding:NSUTF8StringEncoding];
    CFUUIDRef uuid_ref = CFUUIDCreate(NULL);
    CFStringRef uuid_string_ref= CFUUIDCreateString(NULL, uuid_ref);
    NSString *uuid = [NSString stringWithString:(__bridge NSString *)uuid_string_ref];
    CFRelease(uuid_ref);
    CFRelease(uuid_string_ref);
    return [uuid lowercaseString];
}


#pragma mark --- 物流信息
+ (void)asynclogisticsExpress_number:(NSString *)express_number completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail {
    [[self shareInstance] asynclogisticsExpress_number:express_number completed:completed statisticsFail:statisticsFail fail:fail];
}
- (void)asynclogisticsExpress_number:(NSString *)express_number completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail{

    NSDictionary *sidic = [JXUserDefaultsObjc loginUserSid];
    NSString *sid = sidic[@"info"];
    NSMutableDictionary *mutableParams = @{}.mutableCopy;
    // sid
    if (!kStringIsEmpty(sid)) {
        [mutableParams setObject:sid forKey:@"sid"];
    }
    [mutableParams setObject:express_number forKey:@"ordersn"];
    [ZYNetWorking postWithUrl:@"logistics" params:[JXJudgeStrObjc blockEncryption:mutableParams] Cache:NO refreshCache:NO success:^(id response) {
        if ([response[@"status"] integerValue] == 200) {
            completed(response);
        }else {
            statisticsFail(response);
        }
    } fail:^(NSError *error) {
        fail(error);
    }];
    
}
#pragma mark --- 去支付信息
+ (void)asyncPayOrdersn:(NSString *)order completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail {
    [[self shareInstance] asyncPayOrdersn:order completed:completed statisticsFail:statisticsFail fail:fail];
}
- (void)asyncPayOrdersn:(NSString *)order completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail {

    NSDictionary *sidic = [JXUserDefaultsObjc loginUserSid];
    NSString *sid = sidic[@"info"];
    NSMutableDictionary *mutableParams = @{}.mutableCopy;
    // sid
    if (!kStringIsEmpty(sid)) {
        [mutableParams setObject:sid forKey:@"sid"];
    }else {
        return;
    }
    [mutableParams setObject:order forKey:@"ordersn"];
    [ZYNetWorking postWithUrl:@"user_pay" params:[JXJudgeStrObjc blockEncryption:mutableParams] Cache:NO refreshCache:NO success:^(id response) {
        if ([response[@"status"] integerValue] == 200) {
            completed(response);
        }else {
            statisticsFail(response);
        }
    } fail:^(NSError *error) {
        fail(error);
    }];
}


#pragma mark --- 极惠商品
+ (void)asyncAhuipage:(NSString *)page completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail {
    [[self shareInstance] asyncAhuipage:page completed:completed statisticsFail:statisticsFail fail:fail];
}
- (void)asyncAhuipage:(NSString *)page completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail {
    
    NSMutableDictionary *mutableParams = @{}.mutableCopy;
    [mutableParams setObject:page forKey:@"p"];
    [ZYNetWorking postWithUrl:@"most_favored" params:mutableParams Cache:NO refreshCache:NO success:^(id response) {
        if ([response[@"status"] integerValue] == 200) {
            completed(response);
        }else {
            statisticsFail(response);
        }
    } fail:^(NSError *error) {
        fail(error);
    }];
}


+ (void)asyncEvaluationOrdersn:(NSString *)ordersn arr:(NSString *)arr con:(NSString *)con completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail {
    [[self shareInstance] asyncEvaluationOrdersn:ordersn arr:arr con:con completed:completed statisticsFail:statisticsFail fail:fail];
}
- (void)asyncEvaluationOrdersn:(NSString *)ordersn arr:(NSString *)arr con:(NSString *)con completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail {

    NSDictionary *sidic = [JXUserDefaultsObjc loginUserSid];
    NSString *sid = sidic[@"info"];
    NSMutableDictionary *mutableParams = @{}.mutableCopy;
    // sid
    if (!kStringIsEmpty(sid)) {
        [mutableParams setObject:sid forKey:@"sid"];
    }else {
        return;
    }
    [mutableParams setObject:ordersn forKey:@"ordersn"];
    [mutableParams setObject:arr forKey:@"arr"];
    
    
    
    // 公秘 私秘
    NSString *public_key_path = [[NSBundle mainBundle] pathForResource:@"public_key.der" ofType:nil];
    NSString *paramString = [mutableParams JSONString];
    // 拼接的字符串
    NSMutableString *together = @"".mutableCopy;
    // 获取字节数
    NSInteger length = [paramString lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
    // 字典转字符串
    NSString *encryptionStr;
    // 上传的加密字符串
    NSString *encryptionAll;
    // 是否分段加密
    NSString *encryptionNumber;
    if (length>=117)
    { // 分段加密
        encryptionNumber = @"2";
        // 取到加密的值
        encryptionStr = [mutableParams JSONString];
        NSString *prents = [[encryptionStr dataUsingEncoding:NSUTF8StringEncoding] base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        for (int i = 0; i<ceilf(prents.length / 117)+1; i++)
        {
            NSString *subStr = [prents substringWithRange:NSMakeRange(i * 117, MIN(117, prents.length - i * 117))];
            if (subStr.length>0&&subStr!=nil)
            {
                NSString *encryptStr = [RSAEncryptor encryptString:subStr publicKeyWithContentsOfFile:public_key_path];
                //拼接字符串
                [together appendString:[NSString stringWithFormat:@"%@",encryptStr]];
            }
        }
        encryptionAll = [NSString stringWithString:together];
    }
    else
    { // 直接加密
        encryptionNumber = @"1";
        // 取到加密的值
        encryptionStr = [mutableParams JSONString];
        encryptionAll = [RSAEncryptor encryptString:encryptionStr publicKeyWithContentsOfFile:public_key_path];
    }
    NSMutableDictionary *dicPart = @{}.mutableCopy;
    [dicPart setValue:encryptionNumber forKey:@"is_section"];
    [dicPart setValue:encryptionAll forKey:@"sign"];
    [dicPart setValue:con forKey:@"con"];
    
    [ZYNetWorking postWithUrl:@"add_assess" params:dicPart Cache:NO refreshCache:NO success:^(id response) {
        if ([response[@"status"] integerValue] == 200) {
            completed(response);
        }else {
            statisticsFail(response);
        }
    } fail:^(NSError *error) {
        fail(error);
    }];
}

#pragma mark --- 退款
+ (void)asyncrefundorderCompleted:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail {
    [[self shareInstance] asyncrefundorderCompleted:completed statisticsFail:statisticsFail fail:fail];
}
- (void)asyncrefundorderCompleted:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail{
    
    NSDictionary *sidic = [JXUserDefaultsObjc loginUserSid];
    NSString *sid = sidic[@"info"];
    NSMutableDictionary *mutableParams = @{}.mutableCopy;
    // sid
    if (!kStringIsEmpty(sid)) {
        [mutableParams setObject:sid forKey:@"sid"];
    }
    [ZYNetWorking postWithUrl:@"return_order" params:[JXJudgeStrObjc blockEncryption:mutableParams] Cache:NO refreshCache:NO success:^(id response) {
        if ([response[@"status"] integerValue] == 200) {
            completed(response);
        }else {
            statisticsFail(response);
        }
    } fail:^(NSError *error) {
        fail(error);
    }];
}


#pragma mark --- 退款
+ (void)asyncreturn_good:(NSString *)ordersn is_good:(NSString *)is_good is_accpect:(NSString *)is_accpect money:(NSString *)money content1:(NSString *)content1 decs:(NSString *)decs imgs:(NSString *)imgs completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail {
    [[self shareInstance] asyncreturn_good:ordersn is_good:is_good is_accpect:is_accpect money:money content1:content1 decs:decs imgs:imgs completed:completed statisticsFail:statisticsFail fail:fail];
}
- (void)asyncreturn_good:(NSString *)ordersn is_good:(NSString *)is_good is_accpect:(NSString *)is_accpect money:(NSString *)money content1:(NSString *)content1 decs:(NSString *)decs imgs:(NSString *)imgs completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail{
    
    NSDictionary *sidic = [JXUserDefaultsObjc loginUserSid];
    NSString *sid = sidic[@"info"];
    NSMutableDictionary *mutableParams = @{}.mutableCopy;
    // sid
    if (!kStringIsEmpty(sid)) {
        [mutableParams setObject:sid forKey:@"sid"];
    }else {
        return;
    }
    [mutableParams setObject:ordersn forKey:@"ordersn"];
    [mutableParams setObject:is_good forKey:@"is_good"]; // 退货类型 1 我要退货  2 我要退款
    if ([is_good isEqualToString:@"2"]) {
        [mutableParams setObject:is_accpect forKey:@"is_accpect"]; // 收货状态 1 已收到货 0 未收到货
    }
    [mutableParams setObject:money forKey:@"money"];
    
    
    // 公秘 私秘
    NSString *public_key_path = [[NSBundle mainBundle] pathForResource:@"public_key.der" ofType:nil];
    NSString *paramString = [mutableParams JSONString];
    // 拼接的字符串
    NSMutableString *together = @"".mutableCopy;
    // 获取字节数
    NSInteger length = [paramString lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
    // 字典转字符串
    NSString *encryptionStr;
    // 上传的加密字符串
    NSString *encryptionAll;
    // 是否分段加密
    NSString *encryptionNumber;
    if (length>=117)
    { // 分段加密
        encryptionNumber = @"2";
        // 取到加密的值
        encryptionStr = [mutableParams JSONString];
        NSString *prents = [[encryptionStr dataUsingEncoding:NSUTF8StringEncoding] base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        for (int i = 0; i<ceilf(prents.length / 117)+1; i++)
        {
            NSString *subStr = [prents substringWithRange:NSMakeRange(i * 117, MIN(117, prents.length - i * 117))];
            if (subStr.length>0&&subStr!=nil)
            {
                NSString *encryptStr = [RSAEncryptor encryptString:subStr publicKeyWithContentsOfFile:public_key_path];
                //拼接字符串
                [together appendString:[NSString stringWithFormat:@"%@",encryptStr]];
            }
        }
        encryptionAll = [NSString stringWithString:together];
    }
    else
    { // 直接加密
        encryptionNumber = @"1";
        // 取到加密的值
        encryptionStr = [mutableParams JSONString];
        encryptionAll = [RSAEncryptor encryptString:encryptionStr publicKeyWithContentsOfFile:public_key_path];
    }
    NSMutableDictionary *dicPart = @{}.mutableCopy;
    [dicPart setValue:encryptionNumber forKey:@"is_section"];
    [dicPart setValue:encryptionAll forKey:@"sign"];
    [dicPart setObject:content1 forKey:@"content1"]; // 退货原因
    if (!kStringIsEmpty(decs)) {
        [dicPart setObject:decs forKey:@"decs"]; // 退货说明
    }
    if (!kStringIsEmpty(imgs)) {
        [dicPart setObject:imgs forKey:@"imgs"]; // 图片
    }
    
    [ZYNetWorking postWithUrl:@"return_good" params:dicPart Cache:NO refreshCache:NO success:^(id response) {
        if ([response[@"status"] integerValue] == 200) {
            completed(response);
        }else {
            statisticsFail(response);
        }
    } fail:^(NSError *error) {
        fail(error);
    }];
}


#pragma mark --- 联系商家
+ (void)asyncOrdersn:(NSString *)ordersn completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail {
    [[self shareInstance] asyncOrdersn:ordersn completed:completed statisticsFail:statisticsFail fail:fail];
}
- (void)asyncOrdersn:(NSString *)ordersn completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail {

    NSDictionary *sidic = [JXUserDefaultsObjc loginUserSid];
    NSString *sid = sidic[@"info"];
    NSMutableDictionary *mutableParams = @{}.mutableCopy;
    // sid
    if (!kStringIsEmpty(sid)) {
        [mutableParams setObject:sid forKey:@"sid"];
    }
    [mutableParams setObject:ordersn forKey:@"ordersn"];
    [ZYNetWorking postWithUrl:@"contact_seller" params:[JXJudgeStrObjc blockEncryption:mutableParams] Cache:NO refreshCache:NO success:^(id response) {
        if ([response[@"status"] integerValue] == 200) {
            completed(response);
        }else {
            statisticsFail(response);
        }
    } fail:^(NSError *error) {
        fail(error);
    }];
}

#pragma mark -- 填写快递单号
+ (void)asyncCourierNumberordersn:(NSString *)ordersn ex_num:(NSString *)ex_num ex_name:(NSString *)ex_name completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail {
    [[self shareInstance] asyncCourierNumberordersn:ordersn ex_num:ex_num ex_name:ex_name completed:completed statisticsFail:statisticsFail fail:fail];
}
- (void)asyncCourierNumberordersn:(NSString *)ordersn ex_num:(NSString *)ex_num ex_name:(NSString *)ex_name completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail {
    
    NSDictionary *sidic = [JXUserDefaultsObjc loginUserSid];
    NSString *sid = sidic[@"info"];
    NSMutableDictionary *mutableParams = @{}.mutableCopy;
    // sid
    if (!kStringIsEmpty(sid)) {
        [mutableParams setObject:sid forKey:@"sid"];
    }
    [mutableParams setObject:ordersn forKey:@"ordersn"];
    [mutableParams setObject:ex_num forKey:@"ex_num"];
    [mutableParams setObject:ex_name forKey:@"ex_name"];
    [ZYNetWorking postWithUrl:@"send_ex" params:[JXJudgeStrObjc blockEncryption:mutableParams] Cache:NO refreshCache:NO success:^(id response) {
        if ([response[@"status"] integerValue] == 200) {
            completed(response);
        }else {
            statisticsFail(response);
        }
    } fail:^(NSError *error) {
        fail(error);
    }];
}


#pragma mark -- 开票记录user_bill
+ (void)asyncRecordsofmakeoutanInvoice:(NSString *)pager completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail {
    [[self shareInstance] asyncRecordsofmakeoutanInvoice:pager completed:completed statisticsFail:statisticsFail fail:fail];
}
- (void)asyncRecordsofmakeoutanInvoice:(NSString *)pager completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail {
    
    NSDictionary *sidic = [JXUserDefaultsObjc loginUserSid];
    NSString *sid = sidic[@"info"];
    NSMutableDictionary *mutableParams = @{}.mutableCopy;
    // sid
    if (!kStringIsEmpty(sid)) {
        [mutableParams setObject:sid forKey:@"sid"];
    }
    [mutableParams setObject:pager forKey:@"p"];
    [ZYNetWorking postWithUrl:@"user_bill" params:[JXJudgeStrObjc blockEncryption:mutableParams] Cache:NO refreshCache:NO success:^(id response) {
        if ([response[@"status"] integerValue] == 200) {
            completed(response);
        }else {
            statisticsFail(response);
        }
    } fail:^(NSError *error) {
        fail(error);
    }];
}

#pragma mark -- 推送内容
+ (void)asyncPushmessagecompleted:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail {
    [[self shareInstance] asyncPushmessagecompleted:completed statisticsFail:statisticsFail fail:fail];
}
- (void)asyncPushmessagecompleted:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail {
    NSDictionary *sidic = [JXUserDefaultsObjc loginUserSid];
    NSString *sid = sidic[@"info"];
    NSMutableDictionary *mutableParams = @{}.mutableCopy;
    // sid
    if (!kStringIsEmpty(sid)) {
        [mutableParams setObject:sid forKey:@"sid"];
    }
    [ZYNetWorking postWithUrl:@"news_list" params:[JXJudgeStrObjc blockEncryption:mutableParams] Cache:NO refreshCache:NO success:^(id response) {
        if ([response[@"status"] integerValue] == 200) {
            completed(response);
        }else {
            statisticsFail(response);
        }
    } fail:^(NSError *error) {
        fail(error);
    }];
}


#pragma mark -- 跳转APPstore评价
+ (void)asyncJumpAppStoreCompleted:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail {
    [[self shareInstance] asyncJumpAppStoreCompleted:completed statisticsFail:statisticsFail fail:fail];
}
- (void)asyncJumpAppStoreCompleted:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail {

    [ZYNetWorking postWithUrl:@"ios" params:nil Cache:NO refreshCache:NO success:^(id response) {
        if ([response[@"status"] integerValue] == 200) {
            completed(response);
        }else {
            statisticsFail(response);
        }
    } fail:^(NSError *error) {
        fail(error);
    }];
}
#pragma mark -- 快递费
+ (void)asyncForCourierfeeaddress_id:(NSString *)address_id good_ids:(NSArray *)good_ids completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail {
    [[self shareInstance] asyncForCourierfeeaddress_id:address_id good_ids:good_ids completed:completed statisticsFail:statisticsFail fail:fail];
}
- (void)asyncForCourierfeeaddress_id:(NSString *)address_id good_ids:(NSArray *)good_ids completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail {
    NSDictionary *sidic = [JXUserDefaultsObjc loginUserSid];
    NSString *sid = sidic[@"info"];
    NSMutableDictionary *mutableParams = @{}.mutableCopy;
    // sid
    if (!kStringIsEmpty(sid)) {
        [mutableParams setObject:sid forKey:@"sid"];
    }
    [mutableParams setObject:address_id forKey:@"address_id"];
    [mutableParams setObject:good_ids forKey:@"good_ids"];
    [ZYNetWorking postWithUrl:@"select_exmoney" params:[JXJudgeStrObjc blockEncryption:mutableParams] Cache:NO refreshCache:NO success:^(id response) {
        if ([response[@"status"] integerValue] == 200) {
            completed(response);
        }else {
            statisticsFail(response);
        }
    } fail:^(NSError *error) {
        fail(error);
    }];
}

#pragma mark -- 快递名称
+ (void)asyncCouriercompleted:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail {
    
    [[self shareInstance] asyncCouriercompleted:completed statisticsFail:statisticsFail fail:fail];
}
- (void)asyncCouriercompleted:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail {
    
    [ZYNetWorking postWithUrl:@"ex" params:nil Cache:NO refreshCache:NO success:^(id response) {
        if ([response[@"status"] integerValue] == 200) {
            completed(response);
        }else {
            statisticsFail(response);
        }
    } fail:^(NSError *error) {
        fail(error);
    }];
    
}

#pragma mark --- 批发
+ (void)asyncWholesalecompleted:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail {
    
    [[self shareInstance] asyncWholesalecompleted:completed statisticsFail:statisticsFail fail:fail];
}
- (void)asyncWholesalecompleted:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail {
    
    [ZYNetWorking postWithUrl:@"zhw_wholesale" params:nil Cache:NO refreshCache:NO success:^(id response) {
        if ([response[@"status"] integerValue] == 200) {
            completed(response);
        }else {
            statisticsFail(response);
        }
    } fail:^(NSError *error) {
        fail(error);
    }];
}


#pragma mark ---提现金额 滞留金额
+ (void)asyncWithdrawalcompleted:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail {
    
    [[self shareInstance] asyncWithdrawalcompleted:completed statisticsFail:statisticsFail fail:fail];
}
- (void)asyncWithdrawalcompleted:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail {
    
    NSDictionary *sidic = [JXUserDefaultsObjc loginUserSid];
    NSString *sid = sidic[@"info"];
    NSMutableDictionary *mutableParams = @{}.mutableCopy;
    // sid
    if (!kStringIsEmpty(sid)) {
        [mutableParams setObject:sid forKey:@"sid"];
    }
    [ZYNetWorking postWithUrl:@"user_money" params:[JXJudgeStrObjc blockEncryption:mutableParams] Cache:NO refreshCache:NO success:^(id response) {
        if ([response[@"status"] integerValue] == 200) {
            completed(response);
        }else {
            statisticsFail(response);
        }
    } fail:^(NSError *error) {
        fail(error);
    }];
}

+ (void)asyncStrandedgoldcompleted:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail {
    
    [[self shareInstance] asyncStrandedgoldcompleted:completed statisticsFail:statisticsFail fail:fail];
}
- (void)asyncStrandedgoldcompleted:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail {
    
    NSDictionary *sidic = [JXUserDefaultsObjc loginUserSid];
    NSString *sid = sidic[@"info"];
    NSMutableDictionary *mutableParams = @{}.mutableCopy;
    // sid
    if (!kStringIsEmpty(sid)) {
        [mutableParams setObject:sid forKey:@"sid"];
    }
    [ZYNetWorking postWithUrl:@"user_zlj_log" params:[JXJudgeStrObjc blockEncryption:mutableParams] Cache:NO refreshCache:NO success:^(id response) {
        if ([response[@"status"] integerValue] == 200) {
            completed(response);
        }else {
            statisticsFail(response);
        }
    } fail:^(NSError *error) {
        fail(error);
    }];
}



// user_withdraw
+ (void)asyncZfPaycompleted:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail {
    
    [[self shareInstance] asyncZfPaycompleted:completed statisticsFail:statisticsFail fail:fail];
}
- (void)asyncZfPaycompleted:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail {
    
    NSDictionary *sidic = [JXUserDefaultsObjc loginUserSid];
    NSString *sid = sidic[@"info"];
    NSMutableDictionary *mutableParams = @{}.mutableCopy;
    // sid
    if (!kStringIsEmpty(sid)) {
        [mutableParams setObject:sid forKey:@"sid"];
    }
    [ZYNetWorking postWithUrl:@"user_withdraw" params:[JXJudgeStrObjc blockEncryption:mutableParams] Cache:NO refreshCache:NO success:^(id response) {
        if ([response[@"status"] integerValue] == 200) {
            completed(response);
        }else {
            statisticsFail(response);
        }
    } fail:^(NSError *error) {
        fail(error);
    }];
}


#pragma mark --- 提现
+ (void)asyncWithdrawalpay_type:(NSString *)pay_type realname:(NSString *)realname alipay_no:(NSString *)alipay_no bank:(NSString *)bank bank_no:(NSString *)bank_no count_money:(NSString *)count_money completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail {
    [[self shareInstance] asyncWithdrawalpay_type:pay_type realname:realname alipay_no:alipay_no bank:bank bank_no:bank_no count_money:count_money completed:completed statisticsFail:statisticsFail fail:fail];
}
- (void)asyncWithdrawalpay_type:(NSString *)pay_type realname:(NSString *)realname alipay_no:(NSString *)alipay_no bank:(NSString *)bank bank_no:(NSString *)bank_no count_money:(NSString *)count_money completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail {
    
    NSDictionary *sidic = [JXUserDefaultsObjc loginUserSid];
    NSString *sid = sidic[@"info"];
    NSMutableDictionary *mutableParams = @{}.mutableCopy;
    // sid
    if (!kStringIsEmpty(sid)) {
        [mutableParams setObject:sid forKey:@"sid"];
    }
    
    if (!kStringIsEmpty(alipay_no)) {
        [mutableParams setObject:alipay_no forKey:@"alipay_no"];
    }
    if (!kStringIsEmpty(bank)) {
        [mutableParams setObject:bank forKey:@"bank"];
    }
    if (!kStringIsEmpty(bank_no)) {
        [mutableParams setObject:bank_no forKey:@"bank_no"];
    }
    [mutableParams setObject:pay_type forKey:@"pay_type"];
    [mutableParams setObject:realname forKey:@"realname"];
    [mutableParams setObject:count_money forKey:@"count_money"];
    
    [ZYNetWorking postWithUrl:@"user_tx" params:[JXJudgeStrObjc blockEncryption:mutableParams] Cache:NO refreshCache:NO success:^(id response) {
        if ([response[@"status"] integerValue] == 200) {
            completed(response);
        }else {
            statisticsFail(response);
        }
    } fail:^(NSError *error) {
        fail(error);
    }];
}

#pragma mark --- 分享
+ (void)asyncShareUrlcompleted:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail {
    
    [[self shareInstance] asyncShareUrlcompleted:completed statisticsFail:statisticsFail fail:fail];
}
- (void)asyncShareUrlcompleted:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail {
    
    NSDictionary *sidic = [JXUserDefaultsObjc loginUserSid];
    NSString *sid = sidic[@"info"];
    NSMutableDictionary *mutableParams = @{}.mutableCopy;
    // sid
    if (!kStringIsEmpty(sid)) {
        [mutableParams setObject:sid forKey:@"sid"];
    }
    [ZYNetWorking postWithUrl:@"invite" params:[JXJudgeStrObjc blockEncryption:mutableParams] Cache:NO refreshCache:NO success:^(id response) {
        if ([response[@"status"] integerValue] == 200) {
            completed(response);
        }else {
            statisticsFail(response);
        }
    } fail:^(NSError *error) {
        fail(error);
    }];
}

#pragma mark --- 支付方式
+ (void)asyncSharepay:(NSString *)pay_id completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail {
    
    [[self shareInstance] asyncSharepay:pay_id completed:completed statisticsFail:statisticsFail fail:fail];
}
- (void)asyncSharepay:(NSString *)pay_id completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail {
    
    NSDictionary *sidic = [JXUserDefaultsObjc loginUserSid];
    NSString *sid = sidic[@"info"];
    NSMutableDictionary *mutableParams = @{}.mutableCopy;
    // sid
    if (!kStringIsEmpty(sid)) {
        [mutableParams setObject:sid forKey:@"sid"];
    }
    [mutableParams setObject:pay_id forKey:@"pay_id"];
    [ZYNetWorking postWithUrl:@"pay_spread" params:[JXJudgeStrObjc blockEncryption:mutableParams] Cache:NO refreshCache:NO success:^(id response) {
        if ([response[@"status"] integerValue] == 200) {
            completed(response);
        }else {
            statisticsFail(response);
        }
    } fail:^(NSError *error) {
        fail(error);
    }];
}





































































































































































































































































































@end
