//
//  JXMenu.m
//  JaneCargo
//
//  Created by cxy on 2017/6/26.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXMenu.h"

@implementation JXMenu

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.menuScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,0,100, NPHeight-100)];
        self.menuScrollView.bounces = true;
        [self addSubview:self.menuScrollView];
     }
    return self;
}

@end
