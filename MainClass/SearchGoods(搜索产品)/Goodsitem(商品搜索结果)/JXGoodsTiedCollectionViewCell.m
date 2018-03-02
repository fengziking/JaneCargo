//
//  JXGoodsTiedCollectionViewCell.m
//  JaneCargo
//
//  Created by 鹏 on 2017/7/13.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXGoodsTiedCollectionViewCell.h"

@interface JXGoodsTiedCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *goodsImage;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *discountLabel;
@property (weak, nonatomic) IBOutlet UIView *line;

@property (weak, nonatomic) IBOutlet UIView *fline;
@property (weak, nonatomic) IBOutlet UIView *sline;


@end

@implementation JXGoodsTiedCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setBackgroundColor:[UIColor whiteColor]];
    [self.layer setBorderWidth:0.5];
    [self.layer setBorderColor:[kUIColorFromRGB(0xcccccc) CGColor]];
    
    [_fline setBackgroundColor:kUIColorFromRGB(0xcccccc)];
    [_sline setBackgroundColor:kUIColorFromRGB(0xcccccc)];
    [_line setBackgroundColor:kUIColorFromRGB(0x999999)];
    [_discountLabel setTextColor:kUIColorFromRGB(0x999999)];
}

- (void)setModel:(JXHomepagModel *)model {

    _model = model;
    _contentLabel.text = model.good_name;
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
    [JXEncapSulationObjc changeWordSize:_priceLabel size:12.0f];
    [JXEncapSulationObjc changeWordSize:_discountLabel size:7.0f];
    UIImage *cacheImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:[NSString stringWithFormat:@"%@%@",Image_Url,model.good_img]];
    [self.goodsImage setImage:cacheImage];
    [_goodsImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Image_Url,model.good_img]] placeholderImage:[UIImage imageNamed:@"img_图片加载_小"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
    }];
    [self layoutIfNeeded];
    // 获取最后一个View的最低层Y值
    
}

@end
