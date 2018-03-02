//
//  JXJudgeStrObjc.m
//  JaneCargo
//
//  Created by 鹏 on 2017/8/3.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXJudgeStrObjc.h"

@implementation JXJudgeStrObjc

+ (NSString *)judgestr:(NSString *)string {
    
    NSString *judgestr;
    if (kStringIsEmpty(string)) {
        judgestr = @"";
    }else {
        judgestr = string;
    }
    return judgestr;
}

+ (NSString *)judgeType:(MKOrderListModel *)type recycle:(NSInteger)recycle { // 已关闭 已删除

    
    if ([type.status isEqualToString:@"1"]&&[type.is_return isEqualToString:@"0"])
    { // 待发货
        return @"待发货";
    }
    else if ([type.status isEqualToString:@"2"]&&[type.is_return isEqualToString:@"0"])
    { // 待收货
        return @"待收货";
    }
    else if ([type.status isEqualToString:@"3"]&&[type.is_return isEqualToString:@"0"])
    { // 订单完成
        return @"订单完成";
    }
    else if ([type.status isEqualToString:@"4"]&&[type.is_return isEqualToString:@"1"])
    { // 退货中
        return @"退货中";
    }
    else if ([type.status isEqualToString:@"8"]&&[type.is_return isEqualToString:@"0"])
    { // 待付款
        return @"待付款";
    }
    else if ([type.status isEqualToString:@"9"]&&[type.is_return isEqualToString:@"0"])
    { // 已关闭/已删除
        return @"已关闭";
    }else if ([type.status isEqualToString:@"5"]&&[type.is_return isEqualToString:@"0"])
    { // 已评价
        return @"已评价";
    }
    else if ([type.status isEqualToString:@"1"]&&[type.is_return isEqualToString:@"1"])
    { // 申请退款
        return @"申请退款";
    }
    else if ([type.status isEqualToString:@"2"]&&[type.is_return isEqualToString:@"1"])
    { // 申请退款
        return @"申请退款";
    }
    else if ([type.status isEqualToString:@"1"]&&[type.is_return isEqualToString:@"0"]&&[type.is_return_good isEqualToString:@"1"])
    { // 申请被拒
        return @"待发货(退款被拒)";
    }
    else if ([type.status isEqualToString:@"2"]&&[type.is_return isEqualToString:@"0"]&&[type.is_return_good isEqualToString:@"1"])
    { // 申请被拒
        return @"待发货(退款被拒)";
    }
    else if ([type.status isEqualToString:@"10"]&&[type.is_return isEqualToString:@"1"])
    { // 退款完成
        return @"退款完成";
        
    }
    else if ([type.status isEqualToString:@"12"]&&[type.is_return isEqualToString:@"1"])
    { // 退款进行中
        return @"同意退款";
        
    }
    else if ([type.status isEqualToString:@"12"]&&[type.is_return isEqualToString:@"1"])
    { // 同意退款
        return @"同意退款";
        
    }else {
        
        return @"数据出错";
    }
    
    
    
    
}

+ (void)distinguishTheCategory:(MKOrderListModel*)model delivery:(void(^)())delivery goods:(void(^)())goods orderfinished:(void(^)())orderfinished returngoods:(void(^)())returngoods payment:(void(^)())payment recycling:(void(^)())recycling evaluation:(void(^)())evaluation refund:(void(^)())refund rejected:(void(^)())rejected complete:(void(^)())complete refundon:(void(^)())refundon agreerefund:(void(^)())agreerefund{
    
    if ([model.status isEqualToString:@"1"]&&[model.is_return isEqualToString:@"0"])
    { // 待发货
        delivery();
    }
    else if ([model.status isEqualToString:@"2"]&&[model.is_return isEqualToString:@"0"])
    { // 待收货
        goods();
    }
    else if ([model.status isEqualToString:@"3"]&&[model.is_return isEqualToString:@"0"])
    { // 订单完成
        orderfinished();
    }
    else if ([model.status isEqualToString:@"4"]&&[model.is_return isEqualToString:@"1"])
    { // 退货中
        returngoods();
    }
    else if ([model.status isEqualToString:@"8"]&&[model.is_return isEqualToString:@"0"])
    { // 待付款
        payment();
    }
    else if ([model.status isEqualToString:@"9"]&&[model.is_return isEqualToString:@"0"])
    { // 已关闭/已删除
        recycling();
    }else if ([model.status isEqualToString:@"5"]&&[model.is_return isEqualToString:@"0"])
    { // 已评价
        evaluation();
    }
    else if ([model.status isEqualToString:@"1"]&&[model.is_return isEqualToString:@"1"])
    { // 申请退款
        refund();
    }
    else if ([model.status isEqualToString:@"2"]&&[model.is_return isEqualToString:@"1"])
    { // 申请退款
        refund();
    }
    else if ([model.status isEqualToString:@"1"]&&[model.is_return isEqualToString:@"0"]&&[model.is_return_good isEqualToString:@"1"])
    { // 申请被拒
        rejected();
    }
    else if ([model.status isEqualToString:@"2"]&&[model.is_return isEqualToString:@"0"]&&[model.is_return_good isEqualToString:@"1"])
    { // 申请被拒
        rejected();
    }
    else if ([model.status isEqualToString:@"10"]&&[model.is_return isEqualToString:@"1"])
    { // 退款完成
        
        complete();
    }
    else if ([model.status isEqualToString:@"12"]&&[model.is_return isEqualToString:@"1"])
    { // 退款进行中
        
        refundon();
    }
    else if ([model.status isEqualToString:@"12"]&&[model.is_return isEqualToString:@"1"])
    { // 同意退款
        agreerefund();
        
    }
}

#pragma mark -- 删除购物车id 更改当前状态
+ (void)delegateGoods_idCart:(NSString *)goods_id {

    NSArray *goodid = [JXUserDefaultsObjc defaultgoods_id];
    NSMutableArray *good_idArray = [NSMutableArray arrayWithArray:goodid];
    for (NSString *good in goodid) {
        if ([good isEqualToString:goods_id]) { // 删除
            [good_idArray removeObject:good];
        }
    }
    // 重新记录
    [JXUserDefaultsObjc storageJoinGood_id:[NSArray arrayWithArray:good_idArray]];
}
#pragma mark -- 添加购物车id 更改当前状态
+ (void)addgoods_idCart:(NSString *)good_id {

    NSArray *goodid = [JXUserDefaultsObjc defaultgoods_id];
    NSMutableArray *goods_idArray = @[].mutableCopy;
    if (!kArrayIsEmpty(goodid)) { // 存在
        goods_idArray = [NSMutableArray arrayWithArray:goodid];
    }
    if (![goods_idArray containsObject:[NSString stringWithFormat:@"%@",good_id]]) {
        [goods_idArray addObject:[NSString stringWithFormat:@"%@",good_id]];
    }
    // 记录购物车id
    [JXUserDefaultsObjc storageJoinGood_id:[NSArray arrayWithArray:goods_idArray]];
    
}
#pragma mark -- 添加本地搜索
+ (void)addSearchrecords:(NSString *)searchName {


    NSArray *goodid = [JXUserDefaultsObjc defaultsearch];
    NSMutableArray *goods_idArray = @[].mutableCopy;
    if (!kArrayIsEmpty(goodid)) { // 存在
        goods_idArray = [NSMutableArray arrayWithArray:goodid];
    }
    if (![goods_idArray containsObject:searchName]) {
        [goods_idArray addObject:searchName];
    }
    // 记录搜索
    [JXUserDefaultsObjc storageSearchUserInfo:[NSArray arrayWithArray:goods_idArray]];
}





#pragma mark -- 时间戳转换
+ (NSString *)s_returnTimeStamp:(NSString *)stamp {
    NSString * timeStampString = [NSString stringWithFormat:@"%@",stamp];
    NSTimeInterval _interval=[timeStampString doubleValue] / 1000.0;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:@"yyyy-MM-dd HH:mm:ss"]; // yyyy-MM-dd HH:mm:ss.SSS
    return [objDateformat stringFromDate: date];
}

#pragma mark -- 分段加密
+ (NSMutableDictionary *)blockEncryption:(NSMutableDictionary *)encryArray {

    // 公秘 私秘
    NSString *public_key_path = [[NSBundle mainBundle] pathForResource:@"public_key.der" ofType:nil];
    NSString *paramString = [encryArray JSONString];
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
        encryptionStr = [encryArray JSONString];
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
        encryptionStr = [encryArray JSONString];
        encryptionAll = [RSAEncryptor encryptString:encryptionStr publicKeyWithContentsOfFile:public_key_path];
    }
    NSMutableDictionary *dicPart = @{}.mutableCopy;
    [dicPart setValue:encryptionNumber forKey:@"is_section"];
    [dicPart setValue:encryptionAll forKey:@"sign"];
    return dicPart;
}


#pragma mark -- 登录状态
+ (void)is_login:(void(^)(NSInteger message))notlogged {
    
    BOOL loginbool = [JXUserDefaultsObjc onlineStatus];
    if (loginbool)
    {
        notlogged(200);
    }
    else
    {
        notlogged(400);
    }
}















@end
