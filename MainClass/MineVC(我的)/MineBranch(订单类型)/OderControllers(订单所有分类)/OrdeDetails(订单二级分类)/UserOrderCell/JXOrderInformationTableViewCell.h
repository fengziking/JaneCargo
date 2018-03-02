//
//  JXOrderInformationTableViewCell.h
//  JaneCargo
//
//  Created by 鹏 on 2017/7/10.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JXOrderInformationTableViewCell : UITableViewCell

+ (instancetype)cellWithTable;

@property (nonatomic, assign)BOOL hiddenCopy;
@property (nonatomic, strong) MKOrderListModel *model;
@property (nonatomic, copy) void(^CopySuccess)();
@end
