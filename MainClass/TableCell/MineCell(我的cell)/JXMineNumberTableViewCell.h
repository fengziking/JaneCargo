//
//  JXMineNumberTableViewCell.h
//  JaneCargo
//
//  Created by cxy on 2017/7/5.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JXMineNumberTableViewCell : UITableViewCell

+ (instancetype)cellWithTable;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *cache;
@end
