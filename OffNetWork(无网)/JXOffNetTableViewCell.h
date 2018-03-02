//
//  JXOffNetTableViewCell.h
//  JaneCargo
//
//  Created by cxy on 2017/8/29.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JXOffNetTableViewCell : UITableViewCell
+ (instancetype)cellWithTable;
@property (nonatomic, copy) void(^UpdateRequest)();
@end
