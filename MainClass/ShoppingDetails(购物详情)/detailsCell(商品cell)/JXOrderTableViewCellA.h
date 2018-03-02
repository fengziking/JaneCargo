//
//  JXOrderTableViewCellA.h
//  JaneCargo
//
//  Created by cxy on 2017/6/27.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JXHomepagModel;
@interface JXOrderTableViewCellA : UITableViewCell

+ (instancetype)cellWithTable;
@property (nonatomic, strong) JXHomepagModel *model;

@end
