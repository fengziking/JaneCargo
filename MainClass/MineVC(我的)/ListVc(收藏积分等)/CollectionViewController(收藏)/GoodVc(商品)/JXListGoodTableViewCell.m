//
//  JXListGoodTableViewCell.m
//  JaneCargo
//
//  Created by 鹏 on 2017/8/8.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXListGoodTableViewCell.h"

@interface JXListGoodTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *payNumber;
@property (weak, nonatomic) IBOutlet UILabel *discountLabel;
@property (weak, nonatomic) IBOutlet UIView *line;


@end


@implementation JXListGoodTableViewCell


+ (instancetype)cellWithTable {

    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JXListGoodTableViewCell class]) owner:self options:nil] lastObject];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.layer setBorderWidth:0.5];
    [self.layer setBorderColor:[kUIColorFromRGB(0xcccccc) CGColor]];
    [self.line setBackgroundColor:kUIColorFromRGB(0x999999)];
    [_discountLabel setTextColor:kUIColorFromRGB(0x999999)];
    [_payNumber setTextColor:kUIColorFromRGB(0x999999)];
    
    [JXContTextObjc p_SetfondLabel:self.nameLable fondSize:16.0];
    [JXContTextObjc p_SetfondLabel:self.priceLabel fondSize:20.0];
    [JXContTextObjc p_SetfondLabel:self.payNumber fondSize:13.0];
    [JXContTextObjc p_SetfondLabel:self.discountLabel fondSize:12.0];
}


- (void)setModel:(JXHomepagModel *)model {
    
    _model = model;
    _nameLable.text = model.good_name;
    _priceLabel.text = [NSString stringWithFormat:@"￥%@",model.good_price];
    _discountLabel.text = [NSString stringWithFormat:@"￥%@",model.market_price];
   // _payNumber.text = [NSString stringWithFormat:@"%@人付款",model.good_number];
    
    [JXContTextObjc changeWordSize:_priceLabel size:14.0];
    [JXContTextObjc changeWordSize:_discountLabel size:10.0];
    UIImage *cacheImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:[NSString stringWithFormat:@"%@%@",Image_Url,model.good_img]];
    [self.iconImage setImage:cacheImage];
    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Image_Url,model.good_img]] placeholderImage:[UIImage imageNamed:@"img_图片加载_小"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
    }];
    [self layoutIfNeeded];
    // 获取最后一个View的最低层Y值
    

}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
