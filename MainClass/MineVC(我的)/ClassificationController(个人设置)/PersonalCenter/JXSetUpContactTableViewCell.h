//
//  JXSetUpContactTableViewCell.h
//  JaneCargo
//
//  Created by cxy on 2017/7/5.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JXSetUpContactTableViewCell : UITableViewCell
+ (instancetype)cellWithTable;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *number;
- (void)setNumber:(NSString *)number row:(NSInteger)row;
@end
