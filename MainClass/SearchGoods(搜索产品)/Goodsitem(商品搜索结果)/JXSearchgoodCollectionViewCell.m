//
//  JXSearchgoodCollectionViewCell.m
//  JaneCargo
//
//  Created by 鹏 on 2017/7/13.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXSearchgoodCollectionViewCell.h"


@interface JXSearchgoodCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *goodsImage;
@property (weak, nonatomic) IBOutlet UILabel *goodsName;
@property (weak, nonatomic) IBOutlet UILabel *discountLabel;
@property (weak, nonatomic) IBOutlet UIView *disline;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *payNumberLabel;

@property (weak, nonatomic) IBOutlet UIView *line;


@end


@implementation JXSearchgoodCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setBackgroundColor:[UIColor whiteColor]];
    [_line setBackgroundColor:kUIColorFromRGB(0xcccccc)];
    [_disline setBackgroundColor:kUIColorFromRGB(0x999999)];
    [_discountLabel setTextColor:kUIColorFromRGB(0x999999)];
    [_payNumberLabel setTextColor:kUIColorFromRGB(0x999999)];
    
    if (iPhone5 || iPhone4) {
        [_priceLabel setFont:[UIFont systemFontOfSize:16]];
        
    }
    
}

- (void)setModel:(JXHomepagModel *)model {
    
    _model = model;
    _goodsName.text = model.good_name;
    if ([[NSString stringWithFormat:@"%@",model.good_price] isEqualToString:@"(null)"]) {
        _priceLabel.text = @"￥0.00";
    }else {
        _priceLabel.text = [NSString stringWithFormat:@"￥%@",model.good_price];
    }
    if ([[NSString stringWithFormat:@"%@",model.market_price] isEqualToString:@"(null)"]) {
        _discountLabel.text = @"￥0.00";
    }else {
        _discountLabel.text = [NSString stringWithFormat:@"￥%@",model.market_price];
    }
  
    
    if ([[NSString stringWithFormat:@"%@",model.buy_num] integerValue]>10000) {
        NSString *paynumbers = [NSString stringWithFormat:@"%@",model.buy_num];
        NSString *temp = [paynumbers substringWithRange:NSMakeRange(0, 1)];
        NSString *temp0 = [paynumbers substringWithRange:NSMakeRange(1, 1)];

        _payNumberLabel.text =[NSString stringWithFormat:@"%@.%@万人付费",temp,temp0];
    }else {
        _payNumberLabel.text = [NSString stringWithFormat:@"%@人付费",model.buy_num];
     }
    
    [JXContTextObjc changeWordSize:_priceLabel size:14.0];
    [JXContTextObjc changeWordSize:_discountLabel size:10.0];
    UIImage *cacheImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:[NSString stringWithFormat:@"%@%@",Image_Url,model.good_img]];
    [self.goodsImage setImage:cacheImage];
    [_goodsImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Image_Url,model.good_img]] placeholderImage:[UIImage imageNamed:@"img_图片加载_小"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
    }];
    [self layoutIfNeeded];
    // 获取最后一个View的最低层Y值
    
}
@end
