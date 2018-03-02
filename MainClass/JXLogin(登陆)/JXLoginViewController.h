//
//  JXLoginViewController.h
//  JaneCargo
//
//  Created by 鹏 on 2017/7/20.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JXLoginViewController;
@protocol LoginDelegate <NSObject>

- (void)loginSuccessful:(JXLoginViewController *)login;

@end


@interface JXLoginViewController : UIViewController


@property (nonatomic, assign) id<LoginDelegate>logindelegate;


@end
