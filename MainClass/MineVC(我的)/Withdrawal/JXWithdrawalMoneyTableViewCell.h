//
//  JXWithdrawalMoneyTableViewCell.h
//  JaneCargo
//
//  Created by 鹏 on 2018/1/19.
//  Copyright © 2018年 鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JXWithdrawalMoneyTableViewCell : UITableViewCell
+ (instancetype)cellwithTable ;
@property (nonatomic, strong) NSString *moneytext;

@property (nonatomic, copy) void(^WithdrawalMoney)(NSString *money);
@property (weak, nonatomic) IBOutlet UITextField *moneytextField;
@end
