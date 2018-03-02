//
//  JXManagementTableViewCell.h
//  JaneCargo
//
//  Created by 鹏 on 2018/1/17.
//  Copyright © 2018年 鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JXManagementTableViewCell : UITableViewCell

+ (instancetype)cellwithTable;
@property (nonatomic, strong) JXHomepagModel *model;
@end
