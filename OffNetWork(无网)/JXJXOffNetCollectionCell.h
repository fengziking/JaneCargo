//
//  JXJXOffNetCollectionCell.h
//  JaneCargo
//
//  Created by 鹏 on 2017/9/6.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JXJXOffNetCollectionCell : UICollectionViewCell
@property (nonatomic, copy) void(^UpdateRequest)();
@end
