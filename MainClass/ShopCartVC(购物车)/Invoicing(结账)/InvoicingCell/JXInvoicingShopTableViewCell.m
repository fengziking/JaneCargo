//
//  JXInvoicingShopTableViewCell.m
//  JaneCargo
//
//  Created by 鹏 on 2017/7/28.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXInvoicingShopTableViewCell.h"
#import "MKGoodsModel.h"
@interface JXInvoicingShopTableViewCell ()


@property (weak, nonatomic) IBOutlet UIImageView *goodImage;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabe;
@property (weak, nonatomic) IBOutlet UILabel *goodNumberLabel;
@property (weak, nonatomic) IBOutlet UIView *line;


@end

@implementation JXInvoicingShopTableViewCell


+ (instancetype)cellWithTable {
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JXInvoicingShopTableViewCell class]) owner:self options:nil] lastObject];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.line setBackgroundColor:kUIColorFromRGB(0xcccccc)];
    
}

- (void)setGoodsModel:(MKGoodsModel *)goodsModel {
    
    _goodsModel = goodsModel;
    self.contentLabel.text = [NSString stringWithFormat:@"%@",goodsModel.good_name]; // 设置商品名称
    self.priceLabe.text = [NSString stringWithFormat:@"¥%.2f",goodsModel.price];// 设置商品价格
    self.goodNumberLabel.text = [NSString stringWithFormat:@"x%.0f",goodsModel.number];
    UIImage *cacheImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:[NSString stringWithFormat:@"%@%@",Image_Url,goodsModel.good_img]];
    [self.goodImage setImage:cacheImage];
    [self.goodImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Image_Url,goodsModel.good_img]] placeholderImage:[UIImage imageNamed:@"img_图片加载_小"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];

    //    [self layoutIfNeeded];
    //    _goodsModel.cellHeight = CGRectGetMaxY(self.goodsImage.frame)+20;

}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
