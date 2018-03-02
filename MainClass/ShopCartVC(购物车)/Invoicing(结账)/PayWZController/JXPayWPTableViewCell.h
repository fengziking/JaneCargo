//
//  JXPayWPTableViewCell.h
//  JaneCargo
//
//  Created by 鹏 on 2017/8/1.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JXHomepagModel;
@protocol PaydotDelegate <NSObject>

- (void)payDotTag:(NSInteger)tag;

@end
@interface JXPayWPTableViewCell : UITableViewCell

+ (instancetype)cellWithTable;
@property (nonatomic, strong) JXHomepagModel *model;

@property (nonatomic, assign)id<PaydotDelegate>paydotdelegate;
- (void)setSelectImageStr:(NSString *)selectImageStr;
@end
