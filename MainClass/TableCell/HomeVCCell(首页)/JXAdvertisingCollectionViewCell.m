//
//  JXAdvertisingCollectionViewCell.m
//  JaneCargo
//
//  Created by 鹏 on 2017/8/15.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXAdvertisingCollectionViewCell.h"

@implementation JXAdvertisingCollectionViewCell




- (void)setModel:(JXHomepagModel *)model {
    
    _model = model;
    
    _gradientLabel = [[UILabel alloc] init];
    [_gradientLabel setFont:[UIFont systemFontOfSize:16.0f]];
    [_gradientLabel sizeToFit];
    [self.contentView addSubview:_gradientLabel];  // 创建渐变层
    
    _sdleftView = [[UIView alloc] init];
    _sdrightView = [[UIView alloc] init];
    [_sdleftView setBackgroundColor:kUIColorFromRGB(0xcccccc)];
    [_sdrightView setBackgroundColor:kUIColorFromRGB(0xcccccc)];
    [self.contentView addSubview:_sdleftView];
    [self.contentView addSubview:_sdrightView];
    
    CGFloat witd = [JXEncapSulationObjc stringWidth:model.name maxSize:NPWidth fontSize:16.0f];
    [_gradientLabel setFrame:CGRectMake(NPWidth/2-witd/2, 110+14, witd, 14)];
    [_sdleftView setFrame:CGRectMake(40, CGRectGetMinY(_gradientLabel.frame)+6, (NPWidth-30-80-witd)/2, 1)];
    [_sdrightView setFrame:CGRectMake(CGRectGetMaxX(_gradientLabel.frame)+15, CGRectGetMinY(_gradientLabel.frame)+6, (NPWidth-30-80-witd)/2, 1)];
    _gradientLabel.text = model.name;
    [self gradinetLabel];
}


- (void)gradinetLabel {
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = _gradientLabel.frame;  // 设置渐变层的颜色，随机颜色渐变
    gradientLayer.colors = @[(id)[UIColor redColor].CGColor, (id)[UIColor blueColor].CGColor,(id)[UIColor greenColor].CGColor];  // 疑问:渐变层能不能加在label上
    // 不能，mask原理：默认会显示mask层底部的内容，如果渐变层放在mask层上，就不会显示了
    gradientLayer.locations = @[@0, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 0);
    // 添加渐变层到控制器的view图层上
    [self.contentView.layer addSublayer:gradientLayer];
    gradientLayer.mask = _gradientLabel.layer;
    _gradientLabel.frame = gradientLayer.bounds;

}


- (void)awakeFromNib {
    [super awakeFromNib];
    
    
    
    
}

@end
