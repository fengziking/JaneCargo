//
//  MasonryHomeTableViewCell.h
//  MasonryLayOut
//
//  Created by cxy on 2017/8/24.
//  Copyright © 2017年 cxy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MasonryHomeTableViewCell : UITableViewCell
@property (nonatomic, strong) JXHomepagModel *model;

@property (nonatomic, copy) void(^Imageblock)(NSInteger type,JXHomepagModel *model);
@end
