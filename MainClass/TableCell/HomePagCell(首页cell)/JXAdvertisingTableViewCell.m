//
//  JXAdvertisingTableViewCell.m
//  JaneCargo
//
//  Created by cxy on 2017/6/28.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXAdvertisingTableViewCell.h"
#import "NewPagedFlowView.h"
#import "PGIndexBannerSubiew.h"


@interface JXAdvertisingTableViewCell ()


@property (nonatomic, strong) NSMutableArray *bannerImageArray;


@end


@implementation JXAdvertisingTableViewCell

+ (instancetype)cellwithTable {
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JXAdvertisingTableViewCell class]) owner:self options:nil] lastObject];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
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
}




- (void)setModel:(JXHomepagModel *)model {
    
    _model = model;
    
    CGFloat witd = [JXEncapSulationObjc stringWidth:model.name maxSize:NPWidth fontSize:16.0f];
    [_gradientLabel setFrame:CGRectMake(NPWidth/2-witd/2, 110+14, witd, 14)];
    [_sdleftView setFrame:CGRectMake(40, CGRectGetMinY(_gradientLabel.frame)+6, (NPWidth-30-80-witd)/2, 1)];
    [_sdrightView setFrame:CGRectMake(CGRectGetMaxX(_gradientLabel.frame)+15, CGRectGetMinY(_gradientLabel.frame)+6, (NPWidth-30-80-witd)/2, 1)];
    _gradientLabel.text = model.name;
    
    NSString *colorStr = model.color;
    if (colorStr.length == 12) {
        NSString *colorf = [colorStr substringWithRange:NSMakeRange(0, 6)];
        NSString *colors = [colorStr substringWithRange:NSMakeRange(6, 6)];
        [self gradinetLabel:colorf scolor:colors tcolor:colors];
    }

}


- (void)gradinetLabel:(NSString *)colorf scolor:(NSString *)scolor tcolor:(NSString *)tcolor{

    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = _gradientLabel.frame;  // 设置渐变层的颜色，随机颜色渐变
    gradientLayer.colors = @[(id)[self colorWithHexString:colorf].CGColor, (id)[self colorWithHexString:scolor].CGColor,(id)[self colorWithHexString:tcolor].CGColor];  // 疑问:渐变层能不能加在label上
    // 不能，mask原理：默认会显示mask层底部的内容，如果渐变层放在mask层上，就不会显示了
    gradientLayer.locations = @[@0, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 0);
    // 添加渐变层到控制器的view图层上
    [self.contentView.layer addSublayer:gradientLayer];
    gradientLayer.mask = _gradientLabel.layer;
    _gradientLabel.frame = gradientLayer.bounds;

}

- (UIColor *) colorWithHexString: (NSString *)color
{
    
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];     // String should be 6 or 8 characters
    if ([cString length] < 6)
    {
        return [UIColor clearColor];
    }
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    // Separate into r, g, b substrings
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
