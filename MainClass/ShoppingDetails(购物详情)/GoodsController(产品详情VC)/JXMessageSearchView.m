//
//  JXMessageSearchView.m
//  JaneCargo
//
//  Created by 鹏 on 2017/8/25.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXMessageSearchView.h"

@interface JXMessageSearchView ()

@property (nonatomic, strong) UIImageView *backImage;
@property (nonatomic, strong) UIImageView *messageImage;
@property (nonatomic, strong) UILabel *messageLabel;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIImageView *searchImage;
@property (nonatomic, strong) UILabel *searchLabel;
@property (nonatomic, strong) UIButton *searchbt;
@property (nonatomic, strong) UIButton *messagebt;
@end


@implementation JXMessageSearchView

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        
        [self y_messagesearch];
        [self setBackgroundColor:[UIColor clearColor]];
        
    }
    return self;

}

- (void)y_messagesearch {
    
    
    
    self.backImage = ({
        
        UIImageView *image = [[UIImageView alloc] init];
        [image setImage:[UIImage imageNamed:@"bg_消息背景"]];
        image;
        
    });
    [self addSubview:self.backImage];
    
    self.messageImage = ({
        
        UIImageView *image = [[UIImageView alloc] init];
        [image setImage:[UIImage imageNamed:@"icon_message"]];
        image;
    
    });
    [self addSubview:self.messageImage];
    self.messageLabel = ({
        
        UILabel *label = [[UILabel alloc] init];
        [label setFont:[UIFont systemFontOfSize:14]];
        [label setTextColor:[UIColor whiteColor]];
        [label setText:@"消息"];
        label;
        
    });
    [self addSubview:self.messageLabel];
    self.lineView = ({
        
        UIView *view = [[UIView alloc] init];
        [view setBackgroundColor:kUIColorFromRGB(0x696969)];
        view;
        
    });
    [self addSubview:self.lineView];
    self.searchImage = ({
        
        UIImageView *image = [[UIImageView alloc] init];
        [image setImage:[UIImage imageNamed:@"icon_订单搜索_白色"]];
        image;
        
    });
    [self addSubview:self.searchImage];
    self.searchLabel = ({
        
        UILabel *label = [[UILabel alloc] init];
        [label setFont:[UIFont systemFontOfSize:14]];
        [label setTextColor:[UIColor whiteColor]];
        [label setText:@"搜索"];
        label;
        
    });
    [self addSubview:self.searchLabel];
    
    
    self.messagebt = ({
        
        UIButton *button = [[UIButton alloc] init];
        [button addTarget:self action:@selector(messageAction:) forControlEvents:(UIControlEventTouchUpInside)];
        button;
        
    });
    [self addSubview:self.messagebt];
    self.searchbt = ({
        
        UIButton *button = [[UIButton alloc] init];
        [button addTarget:self action:@selector(searchAction:) forControlEvents:(UIControlEventTouchUpInside)];
        button;
        
    });
    [self addSubview:self.searchbt];
    
}

- (void)messageAction:(UIButton *)sender {

    _ClickSearchOrMessage(1);
}
- (void)searchAction:(UIButton *)sender {
    
    _ClickSearchOrMessage(2);
}


- (void)layoutSubviews {

    [super layoutSubviews];
    
    [self.backImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.width.equalTo(self.mas_width);
        make.height.equalTo(self.mas_height);
    }];
    
    [self.messageImage mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.mas_top).offset(8.5+7);
        make.left.equalTo(self.mas_left).offset(24);
        make.width.equalTo(@18);
        make.height.equalTo(@18);
        
    }];
    
    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.mas_top).offset(10+7);
        make.left.equalTo(self.messageImage.mas_right).offset(16);
        make.height.equalTo(@14);
        
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.mas_top).offset(35+7);
        make.left.equalTo(self.mas_left).offset(7);
        make.right.equalTo(self.mas_right).offset(-7);
        make.height.equalTo(@0.5);
        
    }];
    
    
    [self.searchImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.mas_top).offset(35+8.5+7);
        make.left.equalTo(self.mas_left).offset(24);
        make.width.equalTo(@18);
        make.height.equalTo(@18);
        
    }];
    
    [self.searchLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.mas_top).offset(35+10+7);
        make.left.equalTo(self.searchImage.mas_right).offset(16);
        make.height.equalTo(@14);
        
    }];
    
    [self.messagebt mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.width.equalTo(self.mas_width);
        make.height.equalTo(@35);
        
    }];
    [self.searchbt mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.mas_top).offset(35+7);
        make.left.equalTo(self.mas_left);
        make.width.equalTo(self.mas_width);
        make.height.equalTo(@35);
        
    }];
    
}



@end
