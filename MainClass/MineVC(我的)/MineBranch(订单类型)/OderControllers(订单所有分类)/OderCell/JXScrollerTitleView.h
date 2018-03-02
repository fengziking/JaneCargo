//
//  JXScrollerTitleView.h
//  JaneCargo
//
//  Created by cxy on 2017/7/7.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import <UIKit/UIKit.h>


#define SCROLLER 40
//#define LABELW 100  // 控制标题所有的宽度 （是所有）
#define WIDTH [[UIScreen mainScreen] bounds].size.width
#define HEIGHT [[UIScreen mainScreen] bounds].size.height

@interface JXScrollerTitleView : UIView


@property (strong, nonatomic) UIScrollView *titleScrollView;
@property (strong, nonatomic) UIScrollView *contentScrollView;
@property (strong, nonatomic) UIView *colorView;
@property (nonatomic, strong) UIView *lineView;

@end
