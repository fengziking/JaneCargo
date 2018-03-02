//
//  Listener.m
//  IMCHUMO
//
//  Created by xy2 on 16/9/19.
//  Copyright © 2016年 xy2. All rights reserved.
//

#import "Listener.h"
#import "AFNetworkReachabilityManager.h"


@interface Listener()

@property (nonatomic ,strong) UIView *baView;
@property (nonatomic, strong) MBProgressHUD *HUD;

@end
@implementation Listener
+ (Listener *)shareInstance{
    static dispatch_once_t onceToken;
    static Listener *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[Listener alloc]init];
    });
    return instance;
}

- (void)showNetWork:(NSString *)hint{
    _HUD = [[MBProgressHUD alloc] initWithView:[[UIApplication sharedApplication] keyWindow]];
    _HUD.labelText=@" ";
    _HUD.labelFont=[UIFont systemFontOfSize:5];
    _HUD.detailsLabelText = hint;
    _HUD.detailsLabelFont=[UIFont systemFontOfSize:10];
    _HUD.mode=MBProgressHUDModeCustomView;
    UIImageView *imageV = [[UIImageView alloc]init];
    imageV.frame = CGRectMake(0, 0, 24, 24);
    [imageV setImage:[UIImage imageNamed:@"w_wlwlj_jth"]];
    _HUD.customView=imageV;
    [[[UIApplication sharedApplication] keyWindow] addSubview:_HUD];
    [_HUD show:YES];
    [_HUD hide:YES afterDelay:1];
}

- (AFNetworkReachabilityManager *)manager{
    return [AFNetworkReachabilityManager sharedManager];
}

// 监听网络
+ (void)listening{
    [[Listener shareInstance] listening];
}
- (void)listening{

    [[[UIApplication sharedApplication] keyWindow] addSubview:self.baView];
    [[[UIApplication sharedApplication] keyWindow] bringSubviewToFront:_baView];
//    __weak typeof (&*self) weakSelf = self;
    AFNetworkReachabilityManager *netManager = [self manager];
    [netManager startMonitoring];  //开始监听
    [netManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status){
        
        if (status == AFNetworkReachabilityStatusNotReachable){
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isFromAFNetworkReachabilityStatusNotReachable_NODELETE"];
            // 无网络
//            [weakSelf showNetWork:@"网络未连接"];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"AFNetworkReachabilityStatusYes" object:@"NO"];
        }else if (status == AFNetworkReachabilityStatusUnknown){
            // 未知网络
//            [_HUD removeFromSuperview];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"AFNetworkReachabilityStatusYes" object:@"YES"];
        }else if (status == AFNetworkReachabilityStatusReachableViaWWAN){
//            [vc showHint:@"当前网络为2/3/4G"];
//            [_HUD removeFromSuperview];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"AFNetworkReachabilityStatusYes" object:@"YES"];
        }else if (status == AFNetworkReachabilityStatusReachableViaWiFi){

//            [vc showHint:@"当前网络为WIFI"];
//            [_HUD removeFromSuperview];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"AFNetworkReachabilityStatusYes" object:@"YES"];

        }
    }];
}

+ (BOOL )isNetAvialible{
    return [[Listener shareInstance] isNetAvialible];
}
- (BOOL )isNetAvialible{
    
    return [[self manager] networkReachabilityStatus] == AFNetworkReachabilityStatusNotReachable ? NO : YES;
}


@end
