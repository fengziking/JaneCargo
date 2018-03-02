//
//  JXActivityMessageTableViewCell.h
//  JaneCargo
//
//  Created by 鹏 on 2017/8/21.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JXActivityMessageTableViewCell : UITableViewCell
+ (instancetype)cellwithTable;
@property (nonatomic, strong) JXHomepagModel *model;
@property (nonatomic, copy) void(^WebJumpblock)(JXHomepagModel *model);
@end
