//
//  HeaderMethod.h
//  JaneCargo
//
//  Created by 鹏 on 2017/9/1.
//  Copyright © 2017年 鹏. All rights reserved.
//

#ifndef HeaderMethod_h
#define HeaderMethod_h

#define APPID_VALUE @"59ee935e"
#define kAlphaNum  @"0123456789"
#define Channel @"jxzhen_01"    // 渠道号
#define YPAPPKEY @"mizhifa2017licai"

//// 正式环境
#define HTPP_Url @"http://app.1jzhw.com/api/Index/"
// 正式环境图片
#define Image_Url @"http://img.1jzhw.com/"
#define iconImage_Url @"http://www.1jzhw.com/"

////// 测试环境
//#define HTPP_Url @"http://csapp.1jzhw.com/api/Index/"
//// 测试环境图片
//#define Image_Url @"http://img.1jzhw.com/"
//// 测试头像的图片
//#define iconImage_Url @"http://www.1jzhw.com/"


#ifdef DEBUG

#define KDLOG(format, ...) printf("%s [第%d行] %s\n", __FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ## __VA_ARGS__] UTF8String]);

#define NSLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);

#else

#define KDLOG(...);
#define NSLog(...);

#endif

//字符串是否为空
#define kStringIsEmpty(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? YES : NO )
//数组是否为空
#define kArrayIsEmpty(array) (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0)
//字典是否为空
#define kDictIsEmpty(dic) (dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys == 0)
//是否是空对象
#define kObjectIsEmpty(_object) (_object == nil \
|| [_object isKindOfClass:[NSNull class]] \
|| ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \
|| ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0))

//判断设备型号
#define UI_IS_IPAD              ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
#define UI_IS_IPHONE            ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
#define UI_IS_IPHONE4           (UI_IS_IPHONE && KScreenHeight < 568.0)
#define UI_IS_IPHONE5SE         (UI_IS_IPHONE && KScreenHeight == 568.0)
#define UI_IS_IPHONE67          (UI_IS_IPHONE && KScreenHeight == 667.0)
#define UI_IS_IPHONE67PLUS      (UI_IS_IPHONE && KScreenHeight == 736.0)

#define UI_IS_IOS8_AND_HIGHER   (kSystermVersion >= 8.0)

//iponeX适配
#define kSystermVersion [[[UIDevice currentDevice] systemVersion] floatValue]
#define KiOS11Before (kSystermVersion < 11)

#define CJ_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

#define  CJ_StatusBarHeight      (CJ_iPhoneX ? 44.f : 20.f)

#define  CJ_NavigationBarHeight  44.f

#define  CJ_TabbarHeight         (CJ_iPhoneX ? (49.f+34.f) : 49.f)

#define  CJ_TabbarSafeBottomMargin         (CJ_iPhoneX ? 34.f : 0.f)

#define  CJ_StatusBarAndNavigationBarHeight  (CJ_iPhoneX ? 88.f : 64.f)

#define CJ_ViewSafeAreInsets(view) ({UIEdgeInsets insets; if(@available(iOS 11.0, *)) {insets = view.safeAreaInsets;} else {insets = UIEdgeInsetsZero;} insets;})


//循环引用
#define WEAKSELf __weak typeof(self) weakSelf = self;
//快速定义 weakSelf   使用 WS(weakSelf)； 直接使用WeakSelf
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;
/**
 Synthsize a weak or strong reference.
 
 Example:
 @weakify(self)
 [self doSomething^{
 @strongify(self)
 if (!self) return;
 ...
 }];
 
 */
#ifndef weakify
#if DEBUG
#if __has_feature(objc_arc)
#define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#else
#if __has_feature(objc_arc)
#define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
#endif
#endif
#endif

#ifndef strongify
#if DEBUG
#if __has_feature(objc_arc)
#define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
#endif
#else
#if __has_feature(objc_arc)
#define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
#endif
#endif
#endif



#endif /* HeaderMethod_h */
