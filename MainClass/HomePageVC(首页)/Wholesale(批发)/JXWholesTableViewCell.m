//
//  JXWholesTableViewCell.m
//  JaneCargo
//
//  Created by 鹏 on 2017/11/20.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXWholesTableViewCell.h"

@interface JXWholesTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIView *backview;


@end


@implementation JXWholesTableViewCell

+ (instancetype)cellwhithTable {
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JXWholesTableViewCell class]) owner:self options:nil] lastObject];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = kUIColorFromRGB(0xf2f2f2);
    [self.backview.layer setMasksToBounds:true];
    [self.backview.layer setCornerRadius:5.0];
    self.contentLabel.text = @"批发商品";
    self.contentLabel.textColor =kUIColorFromRGB(0xbbbbbb);
    self.priceLabel.textColor =kUIColorFromRGB(0xff5335);
    
}

- (void)setModel:(JXHomepagModel *)model {
    _model = model;
    self.titleLabel.text = [NSString stringWithFormat:@"%@",model.good_name];
    self.priceLabel.text = [NSString stringWithFormat:@"¥%@",model.good_price];
    [JXEncapSulationObjc changeWordSize:self.priceLabel size:12.0f];
    UIImage *cacheImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:[NSString stringWithFormat:@"%@%@",Image_Url,model.good_img]];
    [self.iconImage setImage:cacheImage];
    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Image_Url,model.good_img]] placeholderImage:[UIImage imageNamed:@"img_图片加载_小"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
