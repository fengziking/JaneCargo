//
//  JXAddRemoveTableViewCell.h
//  JaneCargo
//
//  Created by 鹏 on 2017/9/12.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^NumberIncrease)(NSInteger type);

@interface JXAddRemoveTableViewCell : UITableViewCell
+ (instancetype)cellWithTable;

@property (nonatomic, copy) NumberIncrease increse;

@property (nonatomic, strong) NSString *good_number;

@property (weak, nonatomic) IBOutlet UITextField *goodnumberTf;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *goodnumberWid;
@property (nonatomic, copy) void(^completeblock)();

@end
