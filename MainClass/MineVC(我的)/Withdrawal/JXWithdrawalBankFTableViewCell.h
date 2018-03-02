//
//  JXWithdrawalBankFTableViewCell.h
//  JaneCargo
//
//  Created by 鹏 on 2018/1/17.
//  Copyright © 2018年 鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JXWithdrawalBankFTableViewCell : UITableViewCell
+ (instancetype)cellwithTable ;
@property (nonatomic, copy) void(^ChangPay)(NSInteger tag);

@property (nonatomic, copy) void(^ChangPayName)(NSString *name);
@property (nonatomic, copy) void(^ChangPayNumber)(NSString *number);
@property (nonatomic, copy) void(^ChangPayBank)(NSString *bank);
@end
