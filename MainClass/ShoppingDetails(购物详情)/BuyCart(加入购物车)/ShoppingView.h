//
//  ShoppingView.h
//  DemoShopping
//
//  Created by cxy on 2017/6/29.
//  Copyright © 2017年 cxy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BuyCart)(NSInteger type,BOOL is_select);

@protocol AttentionDelegate <NSObject>

- (void)attentiongoods:(BOOL)select;

@end


@interface ShoppingView : UIView

@property (nonatomic, copy) BuyCart buyCart;

@property (nonatomic, strong) NSString *number;
@property (weak, nonatomic) IBOutlet UIImageView *focusImage;
@property (weak, nonatomic) IBOutlet UILabel *focusLabel;
@property (weak, nonatomic) IBOutlet UIButton *focusButton;
@property (nonatomic, assign) id<AttentionDelegate>attentiondelegate;
@property (nonatomic, copy) void(^QQcontactblock)();



@end
