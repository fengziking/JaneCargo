//
//  JXSetUpViewController.h
//  JaneCargo
//
//  Created by 鹏 on 2017/7/24.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LogOutDelegate <NSObject>

- (void)logOut;

@end

@interface JXSetUpViewController : UIViewController

@property (nonatomic, assign) id<LogOutDelegate>logoutdelegate;

@end
