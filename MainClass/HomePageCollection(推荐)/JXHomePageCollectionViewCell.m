//
//  JXHomePageCollectionViewCell.m
//  JaneCargo
//
//  Created by cxy on 2017/6/29.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXHomePageCollectionViewCell.h"
#import "JXHomepagModel.h"

@interface JXHomePageCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImage;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@property (weak, nonatomic) IBOutlet UILabel *discountLabel;
@property (weak, nonatomic) IBOutlet UIView *lineLView;

@property (weak, nonatomic) IBOutlet UIImageView *discountImage;

@property (weak, nonatomic) IBOutlet UIView *linecolor;
@property (weak, nonatomic) IBOutlet UIView *linecolors;

@end


@implementation JXHomePageCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setBackgroundColor:[UIColor whiteColor]];
    [self.layer setBorderWidth:0.5];
    [self.layer setBorderColor:[kUIColorFromRGB(0xCCCCCC) CGColor]];
    [JXContTextObjc p_SetfondLabel:self.priceLabel fondSize:16.0];
    [self.lineLView setBackgroundColor:kUIColorFromRGB(0x999999)];
    [self.priceLabel setTextColor:kUIColorFromRGB(0xff5335)];
    [self.discountLabel setTextColor:kUIColorFromRGB(0x999999)];
}



- (void)setModel:(JXHomepagModel *)model {

    _model = model;
    
    UIImage *cacheImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:[NSString stringWithFormat:@"%@%@",Image_Url,model.good_img]];
    [self.iconImage setImage:cacheImage];
    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Image_Url,model.good_img]] placeholderImage:[UIImage imageNamed:@"img_图片加载_小"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
    [self.titleLabel setText:model.good_name];
    [self.priceLabel setText:[NSString stringWithFormat:@"￥%@",model.good_price]];
    [self.discountLabel setText:[NSString stringWithFormat:@"￥%@",model.market_price]];
    [JXContTextObjc changeWordSize:self.priceLabel size:12.0f];
    [JXContTextObjc changeWordSize:self.discountLabel size:9.0f];
    
    if ([model.img isEqualToString:@"促销"]) {
        _discountImage.image = [UIImage imageNamed:@"icon_promotionalLabel"];
    }
    
}




- (void)hidenViewWithLine:(NSIndexPath*)index {

    if (index.row == 0 || index.row == 1) {
        [self.linecolor setHidden:YES];
    }

}





















@end
