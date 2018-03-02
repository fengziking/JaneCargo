//
//  JXEmailViewController.h
//  JaneCargo
//
//  Created by cxy on 2017/7/6.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ModifyEmailDelegate <NSObject>

- (void)modifySuccessEmail;

@end
@interface JXEmailViewController : UIViewController
@property (nonatomic, strong) NSString *navigationTitle;
@property (nonatomic, assign)id<ModifyEmailDelegate>modifymaildelegate;
@property (nonatomic, strong) NSString *email_str;
@end
