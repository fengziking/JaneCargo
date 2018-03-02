//
//  JXShufflingCollectionViewCell.m
//  JaneCargo
//
//  Created by 鹏 on 2017/8/15.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXShufflingCollectionViewCell.h"

@interface JXShufflingCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIView *line;
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *discountLabel;
@property (weak, nonatomic) IBOutlet UIView *discountLine;



@end


@implementation JXShufflingCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
    [self.line setBackgroundColor:kUIColorFromRGB(0xCCCCCC)];
    [self.discountLabel setTextColor:kUIColorFromRGB(0x999999)];
    [self.discountLine setBackgroundColor:kUIColorFromRGB(0x999999)];
}

- (void)setModel:(JXHomepagModel *)model {

    _model = model;
    UIImage *cacheImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:[NSString stringWithFormat:@"%@%@",Image_Url,model.good_img]];
    [self.iconImage setImage:cacheImage];
    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Image_Url,model.good_img]] placeholderImage:[UIImage imageNamed:@"img_图片加载_小"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
    self.titleLabel.text = model.good_name;
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@",model.good_price];
    self.discountLabel.text = [NSString stringWithFormat:@"￥%@",model.market_price];
    [JXEncapSulationObjc changeWordSize:self.priceLabel size:12.0f];
    [JXEncapSulationObjc changeWordSize:self.discountLabel size:7.0f];
}


@end
