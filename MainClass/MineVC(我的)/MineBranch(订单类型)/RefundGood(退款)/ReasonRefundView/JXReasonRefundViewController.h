//
//  JXReasonRefundViewController.h
//  JaneCargo
//
//  Created by 鹏 on 2017/8/5.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import <UIKit/UIKit.h>



typedef NS_ENUM(NSUInteger, WBStatusCardType) {
    WBNotreceiving = 0,  ///< 未收货
    WBHaveGoods,         ///< 已收货
    WBReturnGood,        ///< 退货
    
};



@protocol ReasonRefundTextContentDelegate <NSObject>

- (void)reasonRefund_content:(NSString *)content;

@end


@interface JXReasonRefundViewController : UIViewController


@property (nonatomic, strong) NSString *select_title;
@property (nonatomic, assign) id<ReasonRefundTextContentDelegate>reasond_delegate;
@property (nonatomic, assign) WBStatusCardType retweetType;


@end
