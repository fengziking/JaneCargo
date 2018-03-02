//
//  JXBranchGoodsTableViewCell.h
//  JaneCargo
//
//  Created by cxy on 2017/7/7.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MKGoodsModel;
@interface JXBranchGoodsTableViewCell : UITableViewCell

+ (instancetype)cellWithTable;

@property (nonatomic, strong) MKGoodsModel *model;

@end
