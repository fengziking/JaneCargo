//
//  enlargeImageCollectionView.h
//  代码布局
//
//  Created by iOS on 16/7/25.
//  Copyright © 2016年 iOS. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol synchronizationItemDelagate
- (void)synchronizationItem:(NSInteger)indexpathItem;
@end

@interface enlargeImageCollectionView : UIView
@property(nonatomic,weak)id<synchronizationItemDelagate>delegate;
@property(nonatomic,strong)NSArray * dataArray;
@property(nonatomic,assign)NSInteger indepathItem;
-(instancetype)initWithFrame:(CGRect)frame;
@end
