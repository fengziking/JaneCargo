//
//  loopImageView.h
//  代码布局
//
//  Created by iOS on 16/7/20.
//  Copyright © 2016年 iOS. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol loopImageViewFooterDelegate
- (void)loopImageViewFooterTranster:(CGFloat)angle AndIndexPath:(NSInteger)indexpath AndTotal:(NSInteger)total;
- (void)loopImageContentoffset:(NSInteger)indexItem;


@end
@interface loopImageView : UIView
@property(nonatomic,weak)id<loopImageViewFooterDelegate> delegate;
- (instancetype)initWithFrame:(CGRect)frame AnddataArray:(NSArray*)dataArray;
@end
