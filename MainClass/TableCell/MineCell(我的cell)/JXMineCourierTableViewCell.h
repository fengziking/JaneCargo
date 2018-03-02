//
//  JXMineCourierTableViewCell.h
//  JaneCargo
//
//  Created by cxy on 2017/7/5.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JXHomepagModel;

typedef void(^CourierBlock)(NSInteger type);


@interface JXMineCourierTableViewCell : UITableViewCell

+ (instancetype)cellWithTable;

@property (nonatomic, strong) JXHomepagModel *model;
@property (nonatomic, copy) CourierBlock courier;
@property (nonatomic, strong) NSString *delivery;
@property (nonatomic, strong) NSString *goodslabel;
@property (nonatomic, strong) NSString *payment;
@property (nonatomic, strong) NSString *comment;
@end
