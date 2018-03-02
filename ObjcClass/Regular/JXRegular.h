//
//  JXRegular.h
//  JaneCargo
//
//  Created by cxy on 2017/7/6.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JXRegular : NSObject
// 身份证
//+(BOOL)checkUserID:(NSString *)userID;
////邮箱
//+ (BOOL) validateEmail:(NSString *)email;

////用户名
+ (BOOL)validateUserName:(NSString *)name;
////密码
//+ (BOOL) validatePassword:(NSString *)passWord;
////昵称
+ (BOOL) validateNickname:(NSString *)nickname;
//+ (BOOL) validateUserpersonhybridName:(NSString *)name;
// 人名正则
+ (BOOL) validateUserpersonName:(NSString *)name;
//手机号码验证
+ (BOOL)validateMobile:(NSString *)mobile;
//验证码
+ (BOOL)validateVerification:(NSString *)verification;

//把字符串时间 转化成时间戳,返回时间戳
+(NSInteger)changeSamTimeToUNIXTime:(NSString*)samTime;
// QQ
+ (BOOL) validateUserpersonhybridQQ:(NSString *)qq;
//把unix时间戳 转化成字符串，返回字符串
+(NSString*)changeUNIXTimeToSamTime:(NSInteger)unixtime;


//把unix时间戳 转化成字符串，返回字符串 简单适用版
+(NSString*)changeUNIXTimeToSamTimeSample:(NSInteger)unixtime;


//十六进制颜色
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

//获取当前说在星期的星期一，所在的时间点
//传入当前的时间戳，返回周一的时间戳
+(NSInteger)MondayOfweekUNIX;

//获取当前时间的字符串
+(NSString*)stringOfCurrentDateTool;

//获取当前时间的时间戳
+(NSInteger)CurrentUNIXTool;
// 将时间戳转换为字符串
+ (NSString *)getDateStringWithDate:(NSDate *)date
                         DateFormat:(NSString *)formatString;

//获取字符串时间的下免N个时间字符串，传入字符串，返回后面N天的日期字符串



//获取从当前时间开始的下一个整点时间戳
+(NSInteger)getUNixTimeOFInteger;

//获取当前时间的下一个整点时间的时间字符串
+(NSString*)getNextTimeSepterNowOneHour;

//获取当前时间的时间戳
+(NSString*)getNowUnix;


// 距离date一个月的  上个月的今天
+(NSString*)getLastMonthDay:(NSDate*)date;

// 下个月的今天
+(NSString*)getNextMonthDay:(NSDate*)date;

#pragma -mark  ----用的比较多的获取当前时间
// 获取当前的时间
+ (NSString*)getCurrentDate;

// 获取date所在的月的开始日期
+ (NSString*)getCurrentMonthBeginDate:(NSDate*)date;

// 获取当前月份的上一个月的开始日期
+ (NSString*)getLastMonthBeginDate:(NSDate*)date;

// 获取当前月份的上一个月的结束日期
+ (NSString*)getLastMonthEndDate:(NSDate*)date;
// 获取字符串date
+ (NSDate *)getDateWithString:(NSString *)dateString;

//获取当前系统版本
+(float)getSystemVersion;
+ (NSString *)getAppVersion;

+ (NSString *)getStringBeforePoint:(NSString *)string;
// 去空格
- (NSString *)getStringWithoutWhiteSpace:(NSString *)string;
// 获取字符串size
- (CGSize)getSizeWithString:(NSString *)string font:(UIFont *)font viewSize:(CGSize)viewSize;
// 手机号码 格式验证
+ (BOOL)isPhoneNumberFormat:(NSString *)phoneNumberString;
// 整数 格式验证
+ (BOOL)isNumberFormat:(NSString *)numberString;


//获取当前时间的字符串
+(NSString*)stringOfCurrentDate;
//获取十天前时间字符串
+(NSString *)stringOfTenDaysBeforeDate:(NSDate*)date;
+ (NSDate *)getDateWithString1:(NSString *)dateString;


// 获取document 路径
+ (NSString *)getImageSavePath;

// 去掉字符串中html标签
+ (NSString *)filterHTML:(NSString *)html;
/**
 *  骨骼含量计算
 *
 *  @param sex        男 ＝ 0， 女 ＝ 1
 *  @param bmi        bmi
 *  @param weightKg   体重 kg
 *  @param isBigScale 是否为大秤
 *
 *  @return 骨骼含量字符串
 */
+ (NSNumber *)getBoneKgWithSex:(NSString *)sex bmi:(NSString *)bmi weight:(NSNumber *) weightKg isBigScale:(BOOL)isBigScale;
+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;











@end
