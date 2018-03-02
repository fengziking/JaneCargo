//
//  DCHoverNavView.m
//  CDDMall
//
//  Created by apple on 2017/6/7.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCHoverNavView.h"

// Controllers

// Models

// Views

// Vendors
#import "Masonry.h"
// Categories

// Others

@interface DCHoverNavView ()

/* 左边Item */
@property (strong , nonatomic)UIButton * leftItemButton;
/* 右边Item */
@property (strong , nonatomic)UIButton * rightItemButton;
@property (strong , nonatomic)UILabel *rightlabel;

@property (nonatomic, strong) UIView *lineColor;


@end

@implementation DCHoverNavView

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpViewWhithColor:[UIColor clearColor]];
    }
    return self;
}

#pragma mark - 初始化View
- (void)setUpViewWhithColor:(UIColor *)color
{
    self.backgroundColor = color;
    
    _leftItemButton = ({
        UIButton * button = [UIButton new];
        [button addTarget:self action:@selector(leftButtonItemClick) forControlEvents:UIControlEventTouchUpInside];
        button;
    });
    
    _rightItemButton = ({
        UIButton * button = [UIButton new];
        [button addTarget:self action:@selector(rightButtonItemClick) forControlEvents:UIControlEventTouchUpInside];
        button;
    });
    
    
    _rightlabel = ({
        
        UILabel *label = [UILabel new];
        [label setFont:[UIFont systemFontOfSize:14.0f]];
        [label setTextColor:[UIColor whiteColor]];
        [label setContentMode:(UIViewContentModeCenter)];
        label;
        
    });
    
    self.iconImageView = ({
        UIImageView * iconImageView = [UIImageView new];
        iconImageView.layer.masksToBounds = YES;
        iconImageView.layer.cornerRadius = 40/2.f;  //宽度一半
        iconImageView;
    });
    self.titleLabel = ({
        UILabel * label = [UILabel new];
        label.font = [UIFont systemFontOfSize:18];
        label.textAlignment = NSTextAlignmentCenter;
        [label setTextColor:[UIColor whiteColor]];
        label;
    });
    

    
    [self addSubview:_rightlabel];
    
    [self addSubview:_rightItemButton];
    [self addSubview:_leftItemButton];
    
    [self addSubview:self.titleLabel];
    [self addSubview:self.iconImageView];
    
    
}

#pragma mark - 布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    [_leftItemButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(30);
        make.left.equalTo(self.mas_left).offset(15);
        make.height.equalTo(@25);
        make.width.equalTo(@25);
    }];
    
    [_rightItemButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_leftItemButton.mas_centerY);
        make.right.equalTo(self.mas_right).offset(-15);
        make.height.equalTo(@25);
        make.width.equalTo(@25);
    }];
    [_rightlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_leftItemButton.mas_centerY);
        make.right.equalTo(self.mas_right).offset(-10);
        make.height.equalTo(@25);
        make.width.equalTo(@65);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.centerY.equalTo(_leftItemButton.mas_centerY)setOffset:0];
        make.left.equalTo(self.mas_left).offset(100);
        make.right.equalTo(self.mas_right).offset(-100);
    }];
    
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.centerY.equalTo(_leftItemButton.mas_centerY)setOffset:25];
        make.centerX.equalTo(self.mas_centerX);
        make.width.equalTo(@(40));
        make.height.equalTo(@(40));
    }];
    
//    [self.lineColor mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.mas_top).offset(63.5);
//        make.width.equalTo(@(NPWidth));
//        make.height.equalTo(@(0.5));
//    }];
    
}

#pragma 自定义右边导航Item点击
- (void)rightButtonItemClick {
    !_rightItemClickBlock ? : _rightItemClickBlock();
}

#pragma 自定义左边导航Item点击
- (void)leftButtonItemClick {
    
    !_leftItemClickBlock ? : _leftItemClickBlock();
}

- (void)leftAndrightImageleft:(NSString *)leftImage right:(NSString *)rightImage {

    [_leftItemButton setImage:[UIImage imageNamed:leftImage] forState:UIControlStateNormal];
    [_rightItemButton setImage:[UIImage imageNamed:rightImage] forState:UIControlStateNormal];
}
- (void)setRightTitle:(NSString *)rightTitle {
    
    _rightlabel.text = rightTitle;
}


@end
