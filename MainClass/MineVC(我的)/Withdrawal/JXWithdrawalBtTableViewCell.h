//
//  JXWithdrawalBtTableViewCell.h
//  JaneCargo
//
//  Created by 鹏 on 2018/1/25.
//  Copyright © 2018年 鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JXWithdrawalBtTableViewCell : UITableViewCell
+ (instancetype)cellwithTable;
@property (nonatomic, copy) void(^SubmitPay)();

@end
