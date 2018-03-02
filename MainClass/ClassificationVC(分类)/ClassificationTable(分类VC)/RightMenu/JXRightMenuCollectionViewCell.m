//
//  JXRightMenuCollectionViewCell.m
//  JaneCargo
//
//  Created by cxy on 2017/6/29.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXRightMenuCollectionViewCell.h"

@interface JXRightMenuCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *discountLabel;

@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UIView *lineone;
@property (weak, nonatomic) IBOutlet UIView *linet;

@end

@implementation JXRightMenuCollectionViewCell

- (void)hidenViewWithLine:(NSIndexPath*)index {
    
    if (index.row == 0 || index.row == 1) {
        [self.linet setHidden:YES];
    }
    
}

- (void)awakeFromNib {
    [super awakeFromNib];

    [JXContTextObjc p_SetfondLabel:self.titleLabel fondSize:14.0];
    [JXContTextObjc p_SetfondLabel:self.priceLabel fondSize:14.0];
    [JXContTextObjc p_SetfondLabel:self.discountLabel fondSize:9.0];
    
    [self.discountLabel setTextColor:kUIColorFromRGB(0x999999)];
    [self.lineView setBackgroundColor:kUIColorFromRGB(0x999999)];
    
    [self.lineone setBackgroundColor:kUIColorFromRGB(0xe3e3e3)];
    [self.linet setBackgroundColor:kUIColorFromRGB(0xe3e3e3)];
}

- (void)setModel:(JXHomepagModel *)model {
    
    _model = model;
    _titleLabel.text = model.good_name;
    _priceLabel.text = [NSString stringWithFormat:@"￥%@",model.good_price];
    _discountLabel.text = [NSString stringWithFormat:@"￥%@",model.market_price];
    UIImage *cacheImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:[NSString stringWithFormat:@"%@%@",Image_Url,model.good_img]];
    [self.iconImage setImage:cacheImage];
    [_iconImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Image_Url,model.good_img]] placeholderImage:[UIImage imageNamed:@"img_图片加载_小"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
    }];
    [JXContTextObjc changeWordSize:self.priceLabel size:12.0f];
    [JXContTextObjc changeWordSize:self.discountLabel size:7.0f];
}





@end
