//
//  JXEmptyShopTableViewCell.h
//  JaneCargo
//
//  Created by cxy on 2017/7/3.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^GoShoppingblock)();

@interface JXEmptyShopTableViewCell : UITableViewCell



+ (instancetype)cellWhiTable;

@property (nonatomic, copy) GoShoppingblock goshop;

@end
