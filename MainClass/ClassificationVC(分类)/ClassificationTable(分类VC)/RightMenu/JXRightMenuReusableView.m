//
//  JXRightMenuReusableView.m
//  JaneCargo
//
//  Created by cxy on 2017/6/26.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXRightMenuReusableView.h"

@interface JXRightMenuReusableView ()

@property (nonatomic, strong) UIView *colorViews;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation JXRightMenuReusableView

- (instancetype)initWithFrame:(CGRect)frame {
    
    
    if (self = [super initWithFrame:frame]) {
        
        _colorViews = [[UIView alloc] initWithFrame:CGRectMake(10, 12, 5, 15)];
        [_colorViews.layer setMasksToBounds:true];
        [_colorViews.layer setCornerRadius:2.5f];
        [_colorViews setBackgroundColor:[UIColor redColor]];
        [self addSubview:_colorViews];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_colorViews.frame)+8, 12, 180, 15)];
        [_titleLabel setTextColor:kUIColorFromRGB(0x333333)];
        [_titleLabel setFont:[UIFont systemFontOfSize:14]];
        [self addSubview:_titleLabel];
        
    }
    return self;
}

- (void)setTitle:(NSString *)title {
    _titleLabel.text = title;
}

@end
