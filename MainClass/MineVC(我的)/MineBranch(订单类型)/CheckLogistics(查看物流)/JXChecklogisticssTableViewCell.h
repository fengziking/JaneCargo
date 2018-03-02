//
//  JXChecklogisticssTableViewCell.h
//  JaneCargo
//
//  Created by 鹏 on 2017/8/11.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JXHomepagModel;
@interface JXChecklogisticssTableViewCell : UITableViewCell

+ (instancetype)cellWithTable;
@property (nonatomic, assign) BOOL hiddenLine;
@property (nonatomic, strong) JXHomepagModel *model;
- (void)changeTextColorAndImage;

@end
