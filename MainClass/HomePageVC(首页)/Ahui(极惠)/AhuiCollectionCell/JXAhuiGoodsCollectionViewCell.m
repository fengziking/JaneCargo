//
//  JXAhuiGoodsCollectionViewCell.m
//  JaneCargo
//
//  Created by 鹏 on 2017/8/10.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXAhuiGoodsCollectionViewCell.h"

@interface JXAhuiGoodsCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIView *is_backView;
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *discountLabel;
@property (weak, nonatomic) IBOutlet UIView *discountLine;
@property (weak, nonatomic) IBOutlet UIButton *snapbt;

@end


@implementation JXAhuiGoodsCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.is_backView.layer setMasksToBounds:true];
    [self.is_backView.layer setCornerRadius:5.0];
    
    [self.snapbt.layer setMasksToBounds:true];
    [self.snapbt.layer setCornerRadius:5.0];
    [self.snapbt setBackgroundColor:kUIColorFromRGB(0xff5335)];
    
    [self.discountLine setBackgroundColor:kUIColorFromRGB(0x999999)];
    [self.discountLabel setTextColor:kUIColorFromRGB(0x999999)];
    [self.priceLabel setTextColor:kUIColorFromRGB(0xff5335)];
    
  //  [JXContTextObjc changeWordSize:self.priceLabel size:12];
    [JXContTextObjc changeWordSize:self.discountLabel size:7];
    
    if (iPhone4) {
    
        [self.priceLabel setFont:[UIFont systemFontOfSize:12]];
    }
    if (iPhone5) {
    
        [self.priceLabel setFont:[UIFont systemFontOfSize:12]];
    }
    
    
}


- (IBAction)snapAction:(UIButton *)sender {
    
    _SnapClickBlock(_mode);
}

- (void)setMode:(JXHomepagModel *)mode {
    _mode = mode;
    [self.nameLabel setText:mode.good_name];
    [self.priceLabel setText:[NSString stringWithFormat:@"￥%@",mode.good_price]];
    [self.discountLabel setText:[NSString stringWithFormat:@"￥%@",mode.market_price]];
    [_iconImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Image_Url,mode.good_img]] placeholderImage:[UIImage imageNamed:@"img_分类"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];

}









@end
