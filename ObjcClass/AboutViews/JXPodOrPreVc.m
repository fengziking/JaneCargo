//
//  JXPodOrPreVc.m
//  JaneCargo
//
//  Created by 鹏 on 2017/7/20.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXPodOrPreVc.h"
#import "JXHomepagModel.h"


@interface JXPodOrPreVc ()

@property (nonatomic, strong) JXHomePageCollectionViewController *collecotiongy;

@end



@implementation JXPodOrPreVc

static JXPodOrPreVc* _podOrpreVc = nil;

+(instancetype) shareInstance
{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _podOrpreVc = [[super allocWithZone:NULL] init] ;
    }) ;
    return _podOrpreVc ;
}


#pragma mark ----- 购物详情  [JXPodOrPreVc buyGoodsModel:model navigation:self.navigationController];
+ (void)buyGoodsModel:(JXHomepagModel *)model navigation:(UINavigationController *)navigation {
    [[self shareInstance] buyGoodsModel:model navigation:navigation];
}
- (void)buyGoodsModel:(JXHomepagModel *)model navigation:(UINavigationController *)navigation{

    NSInteger versionInde = 1; // 改过的
    if (versionInde == 1) {
        JXCompletedetailsViewController *jxorder = [[JXCompletedetailsViewController alloc] init];
        jxorder.goodsid = model.id;
        [navigation pushViewController:jxorder animated:YES];
    }else {
        ViewGoodsdetailsController *jxorder = [[ViewGoodsdetailsController alloc] init];
        jxorder.goodsid = model.id;
        [navigation pushViewController:jxorder animated:YES];
    }
}
// 隐藏tabbar [JXPodOrPreVc hiddenTabbarbuyGoodsModel:model navigation:self.navigationController];
+ (void)hiddenTabbarbuyGoodsModel:(JXHomepagModel *)model navigation:(UINavigationController *)navigation {
    [[self shareInstance] hiddenTabbarbuyGoodsModel:model navigation:navigation];
}
- (void)hiddenTabbarbuyGoodsModel:(JXHomepagModel *)model navigation:(UINavigationController *)navigation{
    
    NSInteger versionInde = 1;
    if (versionInde == 1) {
        
        JXCompletedetailsViewController *jxorder = [[JXCompletedetailsViewController alloc] init];
        jxorder.hidesBottomBarWhenPushed = true;
        jxorder.goodsid = model.id;
        [navigation pushViewController:jxorder animated:YES];
    }else {
        ViewGoodsdetailsController *jxorder = [[ViewGoodsdetailsController alloc] init];
        jxorder.hidesBottomBarWhenPushed = true;
        jxorder.goodsid = model.id;
        [navigation pushViewController:jxorder animated:YES];
    }
}


#pragma mark ---  推荐商品
+ (void)recommendednumberArray:(NSInteger)numberArray lines:(NSInteger)lines datearray:(NSArray *)datearray viewController:(UIViewController *)viewController tablecell:(UITableViewCell *)tablecell {
    [[self shareInstance] recommendednumberArray:numberArray lines:lines datearray:datearray viewController:viewController tablecell:tablecell];
}
- (void)recommendednumberArray:(NSInteger)numberArray lines:(NSInteger)lines datearray:(NSArray *)datearray viewController:(UIViewController *)viewController tablecell:(UITableViewCell *)tablecell{

    [self.collecotiongy willMoveToParentViewController:nil];
    [self.collecotiongy.view removeFromSuperview];
    [self.collecotiongy removeFromParentViewController];
    NSInteger line = [JXEncapSulationObjc s_calculateNumberArrayNum:numberArray singleNumber:lines];
    JXHomePageLayOut *gylay = [[JXHomePageLayOut alloc] init];
    self.collecotiongy = [[JXHomePageCollectionViewController alloc] initWithCollectionViewLayout:gylay];
    [self.collecotiongy.view setFrame:CGRectMake(0, 0, NPWidth, line * BranchOrder_Collection_Height)];
    self.collecotiongy.recommendedArray = [NSArray arrayWithArray:datearray];
    [viewController addChildViewController:self.collecotiongy];
    [tablecell addSubview:self.collecotiongy.view];
    [self.collecotiongy didMoveToParentViewController:viewController];
}


#pragma mark --- present跳转
+ (void)presentVc:(NSString *)vcName vcController:(UIViewController *)vcController {
    
    [[self shareInstance] presentVc:vcName vcController:vcController];
}

- (void)presentVc:(NSString *)vcName vcController:(UIViewController *)vcController{

    UIViewController *vc = [NSClassFromString(vcName) new];
    [vcController presentViewController:[[UINavigationController alloc] initWithRootViewController:vc] animated:YES completion:nil];
}

// present跳转 隐藏tabbar
+ (void)barpresentVc:(NSString *)vcName vcController:(UIViewController *)vcController hidesBar:(BOOL)hidesBar {
    
    [[self shareInstance] barpresentVc:vcName vcController:vcController hidesBar:hidesBar ];
}

- (void)barpresentVc:(NSString *)vcName vcController:(UIViewController *)vcController hidesBar:(BOOL)hidesBar {
    
    UIViewController *vc = [NSClassFromString(vcName) new];
    vc.hidesBottomBarWhenPushed = hidesBar;
    [vcController presentViewController:[[UINavigationController alloc] initWithRootViewController:vc] animated:YES completion:nil];
}



#pragma mark --- pod跳转
+ (void)podVc:(NSString *)vcName vcController:(UIViewController *)vcController  {
    [[self shareInstance] podVc:vcName vcController:vcController ];
}
- (void)podVc:(NSString *)vcName vcController:(UIViewController *)vcController {
    
    UIViewController *vc = [NSClassFromString(vcName) new];
    [vcController.navigationController pushViewController:vc animated:YES];
}
// pod跳转 隐藏tabbar
+ (void)barpodVc:(NSString *)vcName vcController:(UIViewController *)vcController hidesBar:(BOOL)hidesBar  {
    [[self shareInstance] barpodVc:vcName vcController:vcController hidesBar:hidesBar ];
}
- (void)barpodVc:(NSString *)vcName vcController:(UIViewController *)vcController hidesBar:(BOOL)hidesBar{

    UIViewController *vc = [NSClassFromString(vcName) new];
    vc.hidesBottomBarWhenPushed = hidesBar;
    [vcController.navigationController pushViewController:vc animated:YES];
}








@end
