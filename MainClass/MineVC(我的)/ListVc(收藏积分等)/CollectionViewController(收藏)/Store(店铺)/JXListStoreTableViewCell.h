//
//  JXListStoreTableViewCell.h
//  JaneCargo
//
//  Created by 鹏 on 2017/8/8.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JXListStoreTableViewCell : UITableViewCell

+ (instancetype)cellWithTable;
@property (nonatomic, strong) JXStoreMore *model;

@property (nonatomic, copy) void(^Moreblock)(JXStoreMore *model);
@property (nonatomic, copy) void(^Deletegoodshop)(JXStoreMore *model);
@property (nonatomic, copy) void(^SelectImage)(NSInteger type,JXStoreMore *model);

@end
