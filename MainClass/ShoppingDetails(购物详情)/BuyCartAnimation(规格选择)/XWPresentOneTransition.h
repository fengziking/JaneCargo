//
//  TempViewController.m
//  DemoAnimation
//
//  Created by cxy on 2017/6/27.
//  Copyright © 2017年 cxy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, XWPresentOneTransitionType) {
    XWPresentOneTransitionTypePresent = 0,
    XWPresentOneTransitionTypeDismiss
};

@interface XWPresentOneTransition : NSObject<UIViewControllerAnimatedTransitioning>

+ (instancetype)transitionWithTransitionType:(XWPresentOneTransitionType)type;
- (instancetype)initWithTransitionType:(XWPresentOneTransitionType)type;

@end
