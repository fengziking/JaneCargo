//
//  MyCollectionViewCell.m
//  代码布局
//
//  Created by iOS on 16/7/20.
//  Copyright © 2016年 iOS. All rights reserved.
//

#import "MyCollectionViewCell.h"

@implementation MyCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.imageview = [[UIImageView alloc]initWithFrame:self.bounds];
        [self addSubview:self.imageview];
        

    }
    return self;
}
@end
