//
//  JXBranchPayTableViewCell.h
//  JaneCargo
//
//  Created by 鹏 on 2017/7/10.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MKOrderListModel;


typedef void(^Clickblock)(MKOrderListModel *model,NSInteger type);


@interface JXBranchPayTableViewCell : UITableViewCell

+ (instancetype)cellWithTable;
@property (nonatomic, strong) MKOrderListModel *model;

@property (nonatomic, copy) Clickblock click;

@end
