//
//  XWAddShopCarTitleView.h
//  HPShop
//
//  Created by 李学文 on 2017/3/27.
//  Copyright © 2017年 李学文. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XWAddShopCarTitleView;


@protocol XWAddShopCarTitleViewDelegate <NSObject>


-(void)XWAddShopCarTitleView:(XWAddShopCarTitleView*)View ClickTitleWithTag:(NSInteger)tag andButton:(UIButton *)sender;

@end



@interface XWAddShopCarTitleView : UIView


/*
 * 基于滚动
 */
@property(strong, nonatomic) UIScrollView * contentscrollView;
@property(strong, nonatomic) UIView * titleSegmentView;
@property(strong, nonatomic) UIImageView * line;
@property(strong, nonatomic) UIButton * selectBtn;


@property(weak, nonatomic) id<XWAddShopCarTitleViewDelegate> delegate;
//向上 滚动展示titleSegmentView
-(void)ScrollShowTitleSegmentViewWithDuration:(CGFloat)duration;
//向下 滚动展示titleLable
-(void)ScrollShowTitleLableWithDuration:(CGFloat)duration
;
// 设置选中
-(void)updataSelectTitleWithTag:(NSInteger)tag;

+ (instancetype)wxAddshopcarttitleArray:(NSArray *)titleArray;

@end
