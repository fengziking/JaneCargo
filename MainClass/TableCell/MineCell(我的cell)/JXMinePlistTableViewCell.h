//
//  JXMinePlistTableViewCell.h
//  JaneCargo
//
//  Created by cxy on 2017/7/5.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickPlist)(NSInteger type);

@interface JXMinePlistTableViewCell : UITableViewCell

+ (instancetype)cellWithTable;
@property (nonatomic, copy) ClickPlist clickplist;

@end
