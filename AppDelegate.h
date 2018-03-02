//
//  AppDelegate.h
//  JaneCargo
//
//  Created by 鹏 on 17/6/23.
//  Copyright © 2017年 鹏. All rights reserved.
//

//#import <UIKit/UIKit.h>
#import <UserNotifications/UserNotifications.h>
@interface AppDelegate : UIResponder <UIApplicationDelegate,UNUserNotificationCenterDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) NSString *nickname; // 用户昵称
@property (strong, nonatomic) NSString *headimgurl; // 用户头像地址
@end

