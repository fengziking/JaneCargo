//
//  JXBuyCartAnimationView.m
//  JaneCargo
//
//  Created by cxy on 2017/6/30.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXBuyCartAnimationView.h"
#import "MKGoodsModel.h"
@implementation JXBuyCartAnimationView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib {
    [super awakeFromNib];
    [_joinbt setBackgroundColor:kUIColorFromRGB(0xe82b48)];
    [_discountlabel setTextColor:kUIColorFromRGB(0x999999)];
    [_discountline setBackgroundColor:kUIColorFromRGB(0x999999)];
    [_lineView setBackgroundColor:kUIColorFromRGB(0xe3e3e3)];
    [self.goodsImage.layer setMasksToBounds:true];
    [self.goodsImage.layer setCornerRadius:5.0];
    [_goodsImage.layer setBorderWidth:1.0];
    [_goodsImage.layer setBorderColor:[kUIColorFromRGB(0xe82b48) CGColor]];
    
    
}

- (void)setModel:(JXHomepagModel *)model {

    _model = model;
    UIImage *cacheImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:[NSString stringWithFormat:@"%@%@",Image_Url,model.good_img]];
    [self.goodsImage setImage:cacheImage];
    [self.goodsImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Image_Url,model.good_img]] placeholderImage:[UIImage imageNamed:@"img_图片加载_小"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
    [_goodName setText:model.good_name];
    [_goodprice setText:[NSString stringWithFormat:@"￥%@",model.good_price]];
    [_discountlabel setText:[NSString stringWithFormat:@"￥%@",model.market_price]];
    
}

- (void)setMkmodel:(MKGoodsModel *)mkmodel {

    _mkmodel = mkmodel;
    UIImage *cacheImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:[NSString stringWithFormat:@"%@%@",Image_Url,mkmodel.good_img]];
    [self.goodsImage setImage:cacheImage];
    [self.goodsImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Image_Url,mkmodel.good_img]] placeholderImage:[UIImage imageNamed:@"img_图片加载_小"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
    [_goodName setText:mkmodel.good_name];
    [_goodprice setText:[NSString stringWithFormat:@"￥%.2f",mkmodel.good_price]];
    [_discountlabel setText:[NSString stringWithFormat:@"￥%.2f",mkmodel.market_price]];
    
}



// 关闭
- (IBAction)closeAction:(UIButton *)sender {
    
    _close();
}


// 加入购物车
- (IBAction)joinAction:(UIButton *)sender {
    
    _joinShop();
}




@end
