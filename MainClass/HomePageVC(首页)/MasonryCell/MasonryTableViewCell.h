//
//  MasonryTableViewCell.h
//  MasonryLayOut
//
//  Created by cxy on 2017/8/24.
//  Copyright © 2017年 cxy. All rights reserved.
//

#import <UIKit/UIKit.h>
// 更多
typedef void(^Morebutton)();
// 三个商品
typedef void(^GoodBlock)(NSInteger type);
@interface MasonryTableViewCell : UITableViewCell

@property (nonatomic, copy) Morebutton morebt;
@property (nonatomic, copy) GoodBlock goodbk;
@property (nonatomic, strong) JXHomepagModel *model;

@end
