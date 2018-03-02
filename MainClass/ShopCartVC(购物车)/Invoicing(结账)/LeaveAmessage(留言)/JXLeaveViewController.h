//
//  JXLeaveViewController.h
//  JaneCargo
//
//  Created by 鹏 on 2017/8/1.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LeaveAmessagedelegate <NSObject>

- (void)leaveAmessagedelegatestr:(NSString *)message;

@end

@interface JXLeaveViewController : UIViewController
@property (nonatomic, assign)id<LeaveAmessagedelegate>messagedelegate;
@property (nonatomic, strong) NSString *message_Str;
@end
