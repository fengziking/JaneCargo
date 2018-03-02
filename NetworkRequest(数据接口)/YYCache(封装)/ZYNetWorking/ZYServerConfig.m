//
//  ZYServerConfig.m
//  ZYNetWorking
//
//  Created by allen on 2017/5/2.
//  Copyright © 2017年 allen. All rights reserved.
//

#import "ZYServerConfig.h"
static NSString *ZYConfigEnv;  //环境参数 00: 测试环境,01: 生产环境
// 服务地址
NSString *const  ZYURL = HTPP_Url;
NSString *const  ZYURL_Test = HTPP_Url;

@implementation ZYServerConfig

+(void)setZYConfigEnv:(NSString *)value
{
    ZYConfigEnv = value;
}

+(NSString *)ZYConfigEnv
{
    return ZYConfigEnv;
}
//获取服务器地址
+ (NSString *)getZYServerAddr{
    if ([ZYConfigEnv isEqualToString:@"00"]) {
        return ZYURL_Test;
    }else{
        return ZYURL;
    }
}
@end
