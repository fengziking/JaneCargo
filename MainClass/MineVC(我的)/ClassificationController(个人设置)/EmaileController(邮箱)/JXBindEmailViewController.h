//
//  JXBindEmailViewController.h
//  JaneCargo
//
//  Created by cxy on 2017/7/6.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BindEmailDelegate <NSObject>

- (void)bindingSuccessEmail;

@end

@interface JXBindEmailViewController : UIViewController
@property (nonatomic, strong) NSString *navigationTitle;
@property (nonatomic, assign)id<BindEmailDelegate>bindemaildelegate;

@end
