//
//  JXCategoryCollectionViewCell.h
//  JaneCargo
//
//  Created by 鹏 on 2017/8/15.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JXCategoryCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) JXHomepagModel *model;

@property (nonatomic, copy) void(^Imageblock)(NSInteger type,JXHomepagModel *modes);
@end
