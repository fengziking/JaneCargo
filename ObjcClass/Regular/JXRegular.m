//
//  JXRegular.m
//  JaneCargo
//
//  Created by cxy on 2017/7/6.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXRegular.h"



#define kDateFormat @"yyyy-MM-dd"
@implementation JXRegular


// 身份证
+(BOOL)checkUserID:(NSString *)userID
{
    //长度不为18的都排除掉
    if (userID.length!=18) {
        return NO;
    }
    
    //校验格式
    NSString *regex2 = @"^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    BOOL flag = [identityCardPredicate evaluateWithObject:userID];
    
    if (!flag) {
        return flag;    //格式错误
    }else {
        //格式正确在判断是否合法
        
        //将前17位加权因子保存在数组里
        NSArray * idCardWiArray = @[@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2"];
        
        //这是除以11后，可能产生的11位余数、验证码，也保存成数组
        NSArray * idCardYArray = @[@"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
        
        //用来保存前17位各自乖以加权因子后的总和
        NSInteger idCardWiSum = 0;
        for(int i = 0;i < 17;i++)
        {
            NSInteger subStrIndex = [[userID substringWithRange:NSMakeRange(i, 1)] integerValue];
            NSInteger idCardWiIndex = [[idCardWiArray objectAtIndex:i] integerValue];
            
            idCardWiSum+= subStrIndex * idCardWiIndex;
            
        }
        
        //计算出校验码所在数组的位置
        NSInteger idCardMod=idCardWiSum%11;
        
        //得到最后一位身份证号码
        NSString * idCardLast= [userID substringWithRange:NSMakeRange(17, 1)];
        
        //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
        if(idCardMod==2)
        {
            if([idCardLast isEqualToString:@"X"]||[idCardLast isEqualToString:@"x"])
            {
                return YES;
            }else
            {
                return NO;
            }
        }else{
            //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
            if([idCardLast isEqualToString: [idCardYArray objectAtIndex:idCardMod]])
            {
                return YES;
            }
            else
            {
                return NO;
            }
        }
    }
}

//邮箱
+ (BOOL) validateEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}


//手机号码验证
+ (BOOL)validateMobile:(NSString *)mobile {
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}




//用户名
+ (BOOL)validateUserName:(NSString *)name { //  ^[A-Za-z0-9]{1,15}$ ^[A-Za-z0-9]+$ ^[A-Za-z0-9]{6,20}+$
    NSString *userNameRegex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8,16}$";
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    BOOL B = [userNamePredicate evaluateWithObject:name];
    return B;
}

//密码
+ (BOOL) validatePassword:(NSString *)passWord {
    NSString *passWordRegex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8,16}$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:passWord];
}

//昵称
+ (BOOL) validateNickname:(NSString *)nickname {
    NSString *nicknameRegex = @"^[\u4e00-\u9fa5]{4,8}$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nicknameRegex];
    return [passWordPredicate evaluateWithObject:nickname];
}

//验证码
+ (BOOL) validateVerification:(NSString *)verification {
    NSString *verificationRegex = @"^[0-9]*$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",verificationRegex];
    return [passWordPredicate evaluateWithObject:verification];
}


// 人名正则
+ (BOOL) validateUserpersonName:(NSString *)name {
    NSString *userNameRegex = @"^[\u4e00-\u9fa5]{2,4}$|^[a-zA-Z]{1,30}$";
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    BOOL B = [userNamePredicate evaluateWithObject:name];
    return B;
}
// 检测除数组英文汉语外的特殊符号
+ (BOOL) validateUserpersonhybridName:(NSString *)name {
    NSString *userNameRegex = @"^[a-zA-Z\u4e00-\u9fa5][a-zA-Z0-9\u4e00-\u9fa5]+$";
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    BOOL B = [userNamePredicate evaluateWithObject:name];
    return B;
}


// QQ
+ (BOOL) validateUserpersonhybridQQ:(NSString *)qq {
    NSString *userNameRegex = @"[1-9][0-9]{4,14}";
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    BOOL B = [userNamePredicate evaluateWithObject:qq];
    return B;
}


//十六进制颜色
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha{
    //删除字符串中的空格
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6)
    {
        return [UIColor clearColor];
    }
    // strip 0X if it appears
    //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
    if ([cString hasPrefix:@"0X"])
    {
        cString = [cString substringFromIndex:2];
    }
    //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    if ([cString hasPrefix:@"#"])
    {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6)
    {
        return [UIColor clearColor];
    }
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:alpha];
    
    
}
+ (NSString *)getStringBeforePoint:(NSString *)string
{
    NSArray *array = [string componentsSeparatedByString:@"."];
    return [array firstObject];
}
//把字符串时间 转化成时间戳,返回时间戳
+(NSInteger)changeSamTimeToUNIXTime:(NSString*)samTime{
    
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [df setTimeZone:[NSTimeZone localTimeZone]];
    
    NSDate* samDate = [df dateFromString:samTime];
    
    NSInteger timeUnix = [samDate timeIntervalSince1970];
    
    return timeUnix;
}



//把unix时间戳 转化成字符串，返回字符串
+(NSString*)changeUNIXTimeToSamTime:(NSInteger)unixtime{
    
    NSDate* unixdate = [NSDate dateWithTimeIntervalSince1970:unixtime];
    
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [df setTimeZone:[NSTimeZone localTimeZone]];
    
    NSString* samTime = [df stringFromDate:unixdate];
    
    return samTime;
}





//将时间戳转换为字符串

+ (NSString *)getDateStringWithDate:(NSDate *)date
                         DateFormat:(NSString *)formatString
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:formatString];
    NSString *dateString = [dateFormat stringFromDate:date];
    NSLog(@"date: %@", dateString);
    
    return dateString;
}














//把unix时间戳 转化成字符串，返回字符串 简单适用版
+(NSString*)changeUNIXTimeToSamTimeSample:(NSInteger)unixtime{
    
    NSDate* unixdate = [NSDate dateWithTimeIntervalSince1970:unixtime];
    
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd"];
    [df setTimeZone:[NSTimeZone localTimeZone]];
    
    NSString* samTime = [df stringFromDate:unixdate];
    
    
    return samTime;
}


//获取当前所在星期的星期一，所在的时间点
//返回周一的时间戳
+(NSInteger)MondayOfweekUNIX{
    
    NSDate *datetoday = [NSDate date];
    NSInteger unixtime = [datetoday timeIntervalSince1970];
    
    //获取距离星期一的毫秒数
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] ;
    
    NSDateComponents *cps = [gregorian components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit) fromDate:datetoday];
    
    NSInteger diffWeek = [cps weekday];
    // NSLog(@"距离星期一天数 %d",diffWeek-1);
    NSInteger sepSecs =  (diffWeek-2)*24*3600;
    
    //所在星期一那个时间点毫秒数
    NSInteger mondaySec = unixtime -sepSecs;
    
    NSDate* monDat = [NSDate dateWithTimeIntervalSince1970:mondaySec];
    
    NSDateComponents *newcps = [gregorian components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit) fromDate:monDat];
    
    NSInteger mday = [newcps day];
    NSInteger mmonth = [newcps month];
    NSInteger myear = [newcps year];
    
    //获取周一00分00秒的时间戳
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [df setTimeZone:[NSTimeZone localTimeZone]];
    
    NSDate* date = [df dateFromString:[NSString stringWithFormat:@"%d-%d-%d 00:00:00",myear,mmonth,mday]];
    
    
    //把这个时间换成时间戳
    NSInteger monUN = [date timeIntervalSince1970];
    // NSLog(@"monUN %d",monUN);
    return monUN;
}




//获取当前时间的字符串
+(NSString*)stringOfCurrentDateTool{
    NSDate* nowdate = [NSDate date];
    NSDateFormatter* daf = [[NSDateFormatter alloc] init];
    [daf setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [daf setTimeZone:[NSTimeZone localTimeZone]];
    NSString* str = [daf stringFromDate:nowdate];
    
    
    return str;
}


//获取当前时间的字符串
+(NSString*)stringOfCurrentDate{
    NSDate* nowdate = [NSDate date];
    NSDateFormatter* daf = [[NSDateFormatter alloc] init];
    [daf setDateFormat:kDateFormat];
    [daf setTimeZone:[NSTimeZone localTimeZone]];
    NSString* str = [daf stringFromDate:nowdate];
    
    return str;
}
//获取十天前时间字符串
+(NSString *)stringOfTenDaysBeforeDate:(NSDate*)date
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = nil;
    comps = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:date];
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    [adcomps setYear:0];
    [adcomps setMonth:0];
    [adcomps setDay:-10];
    
    
    NSDate *tenDaysBeforedate = [calendar dateByAddingComponents:adcomps toDate:date options:0];
    NSDateFormatter* daf = [[NSDateFormatter alloc] init];
    [daf setDateFormat:kDateFormat];
    [daf setTimeZone:[NSTimeZone localTimeZone]];
    NSString* str = [daf stringFromDate:tenDaysBeforedate];
    return str;
}



//获取当前时间的时间戳
+(NSInteger)CurrentUNIXTool{
    
    NSDate* nowdate = [NSDate date];
    return [nowdate timeIntervalSince1970];
}

//获取字符串时间的下面num个时间字符串，传入字符串，返回后面num天的日期字符串
-(NSString*)getNextTimeString:(NSString*)beforetime AndNextNum:(NSInteger)num{
    
    return nil;
}


//获取从当前时间开始的下一个整点时间戳
+(NSInteger)getUNixTimeOFInteger{
    
    NSDate *datetoday = [NSDate date];
    NSInteger unixtime = [datetoday timeIntervalSince1970];//当前时间戳
    
    NSString* strN = [self stringOfCurrentDateTool];
    NSString* minu = [strN substringWithRange:NSMakeRange(14, 2)];
    //NSLog(@"%@",minu);
    
    NSInteger resInt = unixtime + (60 - [minu intValue])* 60;
    
    return resInt;
}


//获取当前时间的下一个整点时间的时间字符串

+(NSString*)getNextTimeSepterNowOneHour{
    
    NSDate *datetoday = [NSDate date];
    NSInteger unixtime = [datetoday timeIntervalSince1970];//当前时间戳
    
    NSString* strN = [self stringOfCurrentDateTool];
    NSString* minu = [strN substringWithRange:NSMakeRange(14, 2)];
    NSString* sec = [strN substringWithRange:NSMakeRange(17, 2)];
    
    
    NSInteger nextUn = unixtime - [minu intValue]*60 - [sec intValue] + 3600;
    
    NSString* resstr = [self changeUNIXTimeToSamTime:nextUn];
    return resstr;
}

//获取当前时间的时间戳
+(NSString*)getNowUnix{
    
    NSDate* nowDa = [NSDate date];
    NSTimeInterval timeInt = [nowDa timeIntervalSince1970];
    NSString* resStr = [NSString stringWithFormat:@"%0.lf",timeInt];
    return resStr;
}

// 获取距离date一个月的 上一个月的今天
+(NSString*)getLastMonthDay:(NSDate*)date
{
    
    NSCalendar * cal = [NSCalendar currentCalendar];
    NSDateComponents * comps = [cal components:(NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay) fromDate:date];
    if ([comps month]-1 ==0) {
        [comps  setMonth:12];
        [comps setYear:([comps year]-1)];
    }else{
        [comps setMonth:([comps month]-1)];
    }
    NSDate * lastDate = [cal dateFromComponents:comps];
    NSDateFormatter * df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyyMMdd"];
    NSString *lastStr = [df stringFromDate:lastDate];
    return lastStr;
    
}
+ (NSInteger)getMonthDays:(NSInteger)year andMonth:(NSInteger)month

{
    NSInteger days = 0;// 每个月的天数
    if (month == 1 || month == 3 || month == 5 || month == 7 || month == 8 || month == 10 || month == 12)
    {
        days = 31;
    }
    else if (month == 4 || month == 6 || month == 9 || month == 11)
    {
        days = 30;
    }
    else
    { // 2月份，闰年29天、平年28天
        if ((year % 4 == 0 && year % 100 != 0) || year % 400 == 0)
        {
            days = 29;
        }
        else
        {
            days = 28;
        }
    }
    return days;
}

// 获取距离当前一个月的 下一个月的今天
+(NSString*)getNextMonthDay:(NSDate*)date
{
    NSCalendar * cal = [NSCalendar currentCalendar];
    NSDateComponents * comps = [cal components:(NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay) fromDate:date];
    //[comps setMonth:([comps month]+1)];
    //    }
    
    
    //  1.1，3，5，7，8，10，12 31天的时候根据月份加上对应的月份
    
    //取最小的
    NSInteger days = [self getMonthDays:[comps year] andMonth:[comps month]];
    NSInteger nextDays = [self getMonthDays:[comps year] andMonth:[comps month]==12?1:([comps month]+1)];
    
    if ([comps day] > 28 && days > nextDays) {
        
        
        [comps setDay:([comps day] + nextDays)];
    } else {
        [comps setDay:([comps day] + days)];
    }
    
    
    NSDate * nextDate = [cal dateFromComponents:comps];
    NSDateFormatter * df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyyMMdd"];
    NSString *nextStr = [df stringFromDate:nextDate];
    return nextStr;
}
// 获取字符串date
+ (NSDate *)getDateWithString:(NSString *)dateString
{
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyyMMdd"];
    NSDate *date =[dateFormat dateFromString:dateString];
    
    return date;
}

+ (NSDate *)getDateWithString1:(NSString *)dateString
{
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date =[dateFormat dateFromString:dateString];
    
    return date;
}




// 获取当前时间字符串
+ (NSString*)getCurrentDate
{
    NSDate * currentDate = [NSDate date];
    NSDateFormatter * df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyyMMdd"];
    NSString * currentDateStr = [df stringFromDate:currentDate];
    return currentDateStr;
}


// 获取date所在月的开始日期
+ (NSString*)getCurrentMonthBeginDate:(NSDate *)date
{
    NSCalendar * cal = [NSCalendar currentCalendar];
    NSDateComponents * comps = [cal components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:date];// 年 月 日
    //从1号开始
    [comps setDay:1];
    NSDate * beginDate = [cal dateFromComponents:comps];
    NSDateFormatter * df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyyMMdd"];
    NSString * beginDateStr = [df stringFromDate:beginDate];
    return beginDateStr;
}
// 获取date 所在月的上一个月的开始日期
+ (NSString*)getLastMonthBeginDate:(NSDate *)date
{
    NSCalendar * cal = [NSCalendar currentCalendar];
    NSDateComponents * comps = [cal components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date];// 年 月 日
    [comps setDay:1];
    if ([comps month] - 1 == 0) {
        //如果是第一个月，
        [comps setMonth:12];
        [comps setYear:([comps year] - 1)];
        
    }else{
        [comps setMonth:([comps month] - 1)];// 设置上一个月份
    }
    
    NSDate * beginDate = [cal dateFromComponents:comps];
    NSDateFormatter * df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyyMMdd"];
    NSString * beginDateStr = [df stringFromDate:beginDate];
    return beginDateStr;
}

// 获取date 所在月的上一个月的结束日期
+ (NSString*)getLastMonthEndDate:(NSDate *)date
{
    NSCalendar * cal = [NSCalendar currentCalendar];
    NSDateComponents * comps = [cal components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:date];// 年 月 日
    if ([comps month]-1 == 0) {
        [comps setMonth:12];
        [comps setYear:([comps year] - 1)];
        
    }else{
        [comps setMonth:([comps month]-1)];// 设置上一个月份
    }
    NSInteger month = [comps month];
    NSInteger year = [comps year];
    
    NSInteger days = 0;// 每个月的天数
    if (month == 1 || month == 3 || month == 5 || month == 7 || month == 8 || month == 10 || month == 12)
    {
        days = 31;
    }
    else if (month == 4 || month == 6 || month == 9 || month == 11)
    {
        days = 30;
    }
    else
    { // 2月份，闰年29天、平年28天
        if ((year % 4 == 0 && year % 100 != 0) || year % 400 == 0)
        {
            days = 29;
        }
        else
        {
            days = 28;
        }
    }
    [comps setDay:days];
    
    NSDate * endDate = [cal dateFromComponents:comps];
    NSDateFormatter * df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyyMMdd"];
    NSString * endDateStr = [df stringFromDate:endDate];
    return endDateStr;
    
}


//获取当前系统版本
+(float)getSystemVersion{
    
    return [[[UIDevice currentDevice] systemVersion] floatValue];
}

// 获取app版本
+ (NSString *)getAppVersion {
    NSDictionary *dicInfo = [[NSBundle mainBundle] infoDictionary];
    NSString *strAppVersion = [dicInfo objectForKey:@"CFBundleShortVersionString"];
    //    NSLog(@"App应用版本：%@", strAppVersion);
    return strAppVersion;
}

// 获取document 路径
+ (NSString *)getImageSavePath
{
    
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
}
// 去空格
- (NSString *)getStringWithoutWhiteSpace:(NSString *)string
{
    NSCharacterSet* set = [NSCharacterSet whitespaceCharacterSet];
    return [string stringByTrimmingCharactersInSet:set];
}
// 手机号码 格式验证
+ (BOOL)isPhoneNumberFormat:(NSString *)phoneNumberString
{
    //    NSString *regexp_tel = @"^((13[0-9])|(17[0-9])|(147)|(15[^4,\\D])|(18[0,5-9]))\\d{8}$";
    NSString *regexp_tel = @"[1-9][0-9]{10}";
    NSPredicate *predicate_tel = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexp_tel];
    
    if ([predicate_tel evaluateWithObject:phoneNumberString]) {
        return YES;
    } else {
        return NO;
    }
}
// 整数 格式验证
+ (BOOL)isNumberFormat:(NSString *)numberString
{
    NSString *regexp_number = @"^([1-9][0-9]*)$";
    NSPredicate *predicate_number = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexp_number];
    
    if ([predicate_number evaluateWithObject:numberString]) {
        return YES;
    } else {
        return NO;
    }
}
// 获取字符串size
- (CGSize)getSizeWithString:(NSString *)string font:(UIFont *)font viewSize:(CGSize)viewSize
{
    NSDictionary *attribute = @{NSFontAttributeName:font};
    
    CGSize size = [string boundingRectWithSize:viewSize
                                       options:\
                   NSStringDrawingTruncatesLastVisibleLine |
                   NSStringDrawingUsesLineFragmentOrigin |
                   NSStringDrawingUsesFontLeading
                                    attributes:attribute
                                       context:nil].size;
    
    return size;
}



+ (NSString *)filterHTML:(NSString *)html
{
    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * text = nil;
    while([scanner isAtEnd] == NO)
    {
        //找到标签的起始位置
        [scanner scanUpToString:@"<" intoString:nil];
        //找到标签的结束位置
        [scanner scanUpToString:@">" intoString:&text];
        //替换字符
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
    }
    //    NSString * regEx = @"<([^>]*)>";
    //    html = [html stringByReplacingOccurrencesOfString:regEx withString:@""];
    return html;
}
// 体质秤 骨骼含量计算（单位 kg）性别（男 ＝ 0；女 ＝ 1）公式   A + (bmi - 22) / 10
+ (NSNumber *)getBoneKgWithSex:(NSString *)sex bmi:(NSString *)bmi weight:(NSNumber *) weightKg isBigScale:(BOOL)isBigScale
{
    CGFloat fbmi = [bmi floatValue];
    CGFloat fweight = [weightKg floatValue];
    CGFloat seg = 0;
    
    if ([sex isEqualToString:@"0"]) { // 男
        if (fweight < 60) {
            seg = 2.5;
        }
        if (fweight >= 60 && fweight <= 75) {
            seg = 2.9;
        }
        if (fweight > 75) {
            seg = 3.2;
        }
    } else { // 女
        if (fweight < 45) {
            seg = 1.8;
        }
        if (fweight >= 45 && fweight <= 60) {
            seg = 2.2;
        }
        if (fweight > 60) {
            seg = 2.5;
        }
    }
    
    return [NSNumber numberWithFloat:(seg + (fbmi - 22) / 10)];
}




//%u54C8%u54C8%u54C8 如何通过gb2312转码 转成中文

+(NSString *)GB2312ToUTF8:(NSData *) data{
    
    NSStringEncoding enc =CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSString *retStr = [[NSString alloc] initWithData:data encoding:enc];
    
    return retStr;
}

//改变图片的大小
+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}


@end
