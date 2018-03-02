//
//  JXShareTableViewCellf.h
//  JaneCargo
//
//  Created by 鹏 on 2018/1/25.
//  Copyright © 2018年 鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JXShareTableViewCellf : UITableViewCell
+ (instancetype)cellwithTable;
@property (nonatomic, strong) JXHomepagModel *model;

@property (nonatomic, copy) void(^ShareUrlblock)();

@end
