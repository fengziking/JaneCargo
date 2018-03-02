//
//  JXShophomeCollectionViewCell.m
//  JaneCargo
//
//  Created by 鹏 on 2017/8/8.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXShophomeCollectionViewCell.h"

@interface JXShophomeCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImage;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *discountLabel;
@property (weak, nonatomic) IBOutlet UIView *discountline;

@end

@implementation JXShophomeCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.discountline setBackgroundColor:kUIColorFromRGB(0x999999)];
    [self.priceLabel setTextColor:kUIColorFromRGB(0xff5335)];
    [self.discountLabel setTextColor:kUIColorFromRGB(0x999999)];
}


- (void)setModel:(JXHomepagModel *)model {

    _model = model;
    
    UIImage *cacheImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:[NSString stringWithFormat:@"%@%@",Image_Url,model.good_img]];
    [self.iconImage setImage:cacheImage];
    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Image_Url,model.good_img]] placeholderImage:[UIImage imageNamed:@"img_图片加载_小"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {

    }];
    self.nameLabel.text = model.good_name;
    self.priceLabel.text = [NSString stringWithFormat:@"¥%@",model.good_price];
    self.discountLabel.text = [NSString stringWithFormat:@"¥%@",model.market_price];
    

}

@end
