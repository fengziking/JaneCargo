//
//  JXTabbarController.m
//  JaneCargo
//
//  Created by 鹏 on 17/6/23.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXTabbarController.h"
#import "DCNavigationController.h"



#define KClassKey @"rootVCClassString"
#define KTitleKey @"title"
#define KImageKey @"imageName"
#define KSelectImgKey @"selectImageName"


@interface JXTabbarController ()<UITabBarControllerDelegate>

@end

@implementation JXTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self addChildVc];
    
}

- (void)addChildVc { // JXHomePageViewController（tableView） JXHomePageVC（九宫方式布局）  首页

    NSArray *childItemArray = @[
                                @{KClassKey : @"JXHomePageViewController",
                                  KTitleKey : @"首页",
                                  KImageKey : @"icon_homePage",
                                  KSelectImgKey : @"icon_homePage_selected"},
                                
                                @{KClassKey : @"JXClassiFicationController",
                                  KTitleKey : @"分类",
                                  KImageKey : @"icon_classification",
                                  KSelectImgKey : @"icon_classification_selected"},
                               // @{KClassKey : @"JXBulkViewController",
                                //  KTitleKey : @"团购",
                                 // KImageKey : @"icon_icon_groupPurchasebar",
                                //  KSelectImgKey : @"icon_groupPurchase_selected"},
                                @{KClassKey : @"JXShopCartViewController",
                                  KTitleKey : @"购物车",
                                  KImageKey : @"icon_shopping",
                                  KSelectImgKey : @"icon_shopping_selected"},
                                
                                @{KClassKey : @"JXMineUserViewController",
                                  KTitleKey : @"我的",
                                  KImageKey : @"icon_mine",
                                  KSelectImgKey : @"icon_mine_selected"}];
    
    [childItemArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UIViewController *vc = [NSClassFromString(obj[KClassKey]) new];
        DCNavigationController *navigation = [[DCNavigationController alloc] initWithRootViewController:vc];
//        navigation.navigationBar.translucent = NO;
        UITabBarItem *item = navigation.tabBarItem;
        item.title = obj[KTitleKey];
        item.image = [UIImage imageNamed:obj[KImageKey]];
        item.selectedImage = [[UIImage imageNamed:obj[KSelectImgKey]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [item setTitleTextAttributes:@{NSForegroundColorAttributeName : kUIColorFromRGB(0xff974b)} forState:UIControlStateSelected];
        [UITabBar appearance].translucent = NO;
        [[UITabBar appearance] setBarTintColor:kUIColorFromRGB(0xffffff)];
        [self addChildViewController:navigation];
        
    }];
}


#pragma mark - <UITabBarControllerDelegate>
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    //点击tabBarItem动画
    [self tabBarButtonClick:[self getTabBarButton]];
}

- (UIControl *)getTabBarButton{
    
    NSMutableArray *tabBarButtons = [[NSMutableArray alloc]initWithCapacity:0];
    for (UIView *tabBarButton in self.tabBar.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]){
            [tabBarButtons addObject:tabBarButton];
        }
    }
    UIControl *tabBarButton = [tabBarButtons objectAtIndex:self.selectedIndex];
    return tabBarButton;
}
#pragma mark - 点击动画
- (void)tabBarButtonClick:(UIControl *)tabBarButton
{
    for (UIView *imageView in tabBarButton.subviews) {
        if ([imageView isKindOfClass:NSClassFromString(@"UITabBarSwappableImageView")]) {
            //需要实现的帧动画,这里根据自己需求改动
            CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
            animation.keyPath = @"transform.scale";
            animation.values = @[@1.0,@1.2,@0.7,@1.0];
            animation.duration = 0.3;
            animation.calculationMode = kCAAnimationCubic;
            //添加动画
            [imageView.layer addAnimation:animation forKey:nil];
        }
    }
}


#pragma mark - 禁止屏幕旋转
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return (toInterfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL)shouldAutorotate {
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;//只支持这一个方向(正常的方向)
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
