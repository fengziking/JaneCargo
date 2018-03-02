//
//  JXRegisteredViewController.h
//  JaneCargo
//
//  Created by 鹏 on 2017/7/20.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JXRegisteredViewController;
@protocol RegisteredDelegate <NSObject>

- (void)loginRegisteredSuccessful:(JXRegisteredViewController *)successful;

@end



@interface JXRegisteredViewController : UIViewController


@property (nonatomic, assign)id<RegisteredDelegate>registeredelegate;

@end
