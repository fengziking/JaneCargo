//
//  JXAhuiGoodsCollectionViewCell.h
//  JaneCargo
//
//  Created by 鹏 on 2017/8/10.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface JXAhuiGoodsCollectionViewCell : UICollectionViewCell


@property (nonatomic , copy) void(^SnapClickBlock)(JXHomepagModel *model);
@property (nonatomic, strong) JXHomepagModel *mode;

@end
