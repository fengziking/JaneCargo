//
//  JXAhuiTitleCollectionViewCell.h
//  JaneCargo
//
//  Created by 鹏 on 2017/8/10.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SortingGoodsdelegate <NSObject>

- (void)sortinggood:(NSInteger)btTag boolclick:(BOOL)boolclick;

@end

@interface JXAhuiTitleCollectionViewCell : UICollectionViewCell


@property (nonatomic, assign) id <SortingGoodsdelegate> sortingdelegate;

@end
