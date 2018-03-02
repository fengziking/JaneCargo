//
//  JXTransparentView.m
//  JaneCargo
//
//  Created by 鹏 on 2017/8/25.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXTransparentView.h"
@interface JXTransparentView  ()

@property (nonatomic, strong) UIView *maskView;

@end
@implementation JXTransparentView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        self.maskView = [[UIView alloc] initWithFrame:self.frame];
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
    
    JXTransparentView *show = [[JXTransparentView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    show.hidenMask = hiden;
    return show;
}
@end
