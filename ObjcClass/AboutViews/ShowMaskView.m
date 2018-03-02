//
//  ShowMaskView.m
//  自定义选择器
//
//  Created by 鹏 on 16/11/21.
//  Copyright © 2016年 鹏. All rights reserved.
//

#import "ShowMaskView.h"

@interface ShowMaskView  ()

@property (nonatomic, strong) UIView *maskView;

@end

@implementation ShowMaskView


- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        self.maskView = [[UIView alloc] initWithFrame:self.frame];
        self.maskView.backgroundColor = [UIColor blackColor];
        self.maskView.alpha = 0.4f;
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        CGRect maskRect = [[UIScreen mainScreen] bounds];
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathAddRect(path, nil, maskRect);
        [maskLayer setPath:path];
        CGPathRelease(path);
        self.maskView.layer.mask = maskLayer;
        [self.maskView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClick:)]];
        [self addSubview:self.maskView];
    }
    return self;
}

- (void)setColoralpha {

//    self.maskView.backgroundColor = [UIColor blackColor];
    self.maskView.alpha = 0.0f;
}


- (void)labelClick:(UITapGestureRecognizer *)tap {
    
    self.hidenMask();
    [self removeFromSuperview];
    [self.maskView removeFromSuperview];
}

+ (instancetype)showMaskViewWith:(HidenViewBlock)hiden {

    ShowMaskView *show = [[ShowMaskView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    show.hidenMask = hiden;
    return show;
}





@end
