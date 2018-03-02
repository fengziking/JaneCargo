//
//  JXPodOrPreVc.h
//  JaneCargo
//
//  Created by 鹏 on 2017/7/20.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import <Foundation/Foundation.h>
@class JXHomepagModel;
@interface JXPodOrPreVc : NSObject

+(instancetype) shareInstance;


#pragma mark -- present跳转
+ (void)presentVc:(NSString *)vcName vcController:(UIViewController *)vcController ;
#pragma mark -- present跳转 隐藏tabbar
+ (void)barpresentVc:(NSString *)vcName vcController:(UIViewController *)vcController hidesBar:(BOOL)hidesBar ;

#pragma mark -- pod跳转
+ (void)podVc:(NSString *)vcName vcController:(UIViewController *)vcController ;
#pragma mark -- pod跳转 隐藏tabbar
+ (void)barpodVc:(NSString *)vcName vcController:(UIViewController *)vcController hidesBar:(BOOL)hidesBar;
#pragma mark ----- 购物详情
+ (void)buyGoodsModel:(JXHomepagModel *)model navigation:(UINavigationController *)navigation;
+ (void)hiddenTabbarbuyGoodsModel:(JXHomepagModel *)model navigation:(UINavigationController *)navigation;
+ (void)recommendednumberArray:(NSInteger)numberArray lines:(NSInteger)lines datearray:(NSArray *)datearray viewController:(UIViewController *)viewController tablecell:(UITableViewCell *)tablecell;
@end
