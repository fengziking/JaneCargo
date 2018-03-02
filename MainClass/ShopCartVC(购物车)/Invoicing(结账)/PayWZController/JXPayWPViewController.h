//
//  JXPayWPViewController.h
//  JaneCargo
//
//  Created by 鹏 on 2017/8/1.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol Paymentdelegate <NSObject>

- (void)payment:(NSString *)payment;

@end


@interface JXPayWPViewController : UIViewController

@property (nonatomic, assign) id<Paymentdelegate>paymentdelegate;
@property (nonatomic, strong) NSString *pay_str;
@end
