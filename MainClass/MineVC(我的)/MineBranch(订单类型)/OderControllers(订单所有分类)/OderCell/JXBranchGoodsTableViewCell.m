//
//  JXBranchGoodsTableViewCell.m
//  JaneCargo
//
//  Created by cxy on 2017/7/7.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXBranchGoodsTableViewCell.h"
#import "MKGoodsModel.h"
@interface JXBranchGoodsTableViewCell ()

@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *contentLanel;
@property (weak, nonatomic) IBOutlet UILabel *specificationsLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodsNumberLabel;
// 无规格时距上-----》11
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *priceHeight;

@end


@implementation JXBranchGoodsTableViewCell


+ (instancetype)cellWithTable {

    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JXBranchGoodsTableViewCell class]) owner:self options:nil] lastObject];
}




- (void)awakeFromNib {
    [super awakeFromNib];
    [_lineView setBackgroundColor:kUIColorFromRGB(0xcccccc)];
    [self setSelectionStyle:(UITableViewCellSelectionStyleNone)];
}


- (void)setModel:(MKGoodsModel *)model {
    _model = model;
    self.contentLanel.text = [JXJudgeStrObjc judgestr:model.good_name];
    self.goodsNumberLabel.text = [JXJudgeStrObjc judgestr:[NSString stringWithFormat:@"x %.0f",model.number]];
    self.priceLabel.text = [JXJudgeStrObjc judgestr:[NSString stringWithFormat:@"￥%.2f",model.price]];
    if (model.key_name!=nil)
    { // f2f2f2
        _specificationsLabel.textColor = kUIColorFromRGB(0x999999);
        _specificationsLabel.text = [NSString stringWithFormat:@"%@%.1f",model.key_name,model.price];
    }
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
