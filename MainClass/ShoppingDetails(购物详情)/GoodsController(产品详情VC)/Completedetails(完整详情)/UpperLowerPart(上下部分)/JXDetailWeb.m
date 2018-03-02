//
//  JXDetailWeb.m
//  JaneCargo
//
//  Created by 鹏 on 2017/9/26.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXDetailWeb.h"

@implementation JXDetailWeb

- (instancetype)init {
    self = [super init];
    if (self) {
        
        [self setUpLable];
    }
    return self;
}

- (void)setUpUrl_goodsid:(NSString *)good_id {
    
    [self loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://app.1jzhw.com/api/index/product_detail?id=%@",good_id]]]];
}

- (void)setUpLable {
    
    self.headLabel = [[UILabel alloc]init];
    self.headLabel.textAlignment = NSTextAlignmentCenter;
    self.headLabel.frame = CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), 40);
    self.headLabel.text = @"加载";
    [self.headLabel setFont:[UIFont systemFontOfSize:14.0f]];
    [self addSubview:self.headLabel];
    [self.headLabel bringSubviewToFront:self];
}

@end
