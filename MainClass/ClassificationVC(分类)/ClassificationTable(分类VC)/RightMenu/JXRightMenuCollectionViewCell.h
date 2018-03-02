//
//  JXRightMenuCollectionViewCell.h
//  JaneCargo
//
//  Created by cxy on 2017/6/29.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JXHomepagModel;
@interface JXRightMenuCollectionViewCell : UICollectionViewCell

- (void)hidenViewWithLine:(NSIndexPath*)index;

@property (nonatomic, strong) JXHomepagModel *model;

@end
