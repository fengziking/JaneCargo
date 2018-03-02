//
//  JXScrollerTitleView.m
//  JaneCargo
//
//  Created by cxy on 2017/7/7.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXScrollerTitleView.h"

@implementation JXScrollerTitleView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,0,WIDTH, SCROLLER)];
        self.contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(self.titleScrollView.frame),WIDTH, HEIGHT-SCROLLER)];
        
        self.contentScrollView.pagingEnabled = true;
        self.titleScrollView.showsHorizontalScrollIndicator = NO;
        self.titleScrollView.bounces = true;
        self.contentScrollView.bounces = true;
        [self addSubview:self.titleScrollView];
        [self addSubview:self.contentScrollView];
        
        self.lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 39, NPWidth, 1)];
        [self.lineView setBackgroundColor:kUIColorFromRGB(0xf2f2f2)];
        [self addSubview:self.lineView];
        
        self.colorView = [[UIView alloc] initWithFrame:CGRectMake(21,SCROLLER-1.5,28, 2)];
        
        [self.colorView setBackgroundColor:kUIColorFromRGB(0xef5b4c)];
        [self addSubview:self.colorView];
    }
    return self;
}
@end
