//
//  JXOrderTableViewCellA.m
//  JaneCargo
//
//  Created by cxy on 2017/6/27.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXOrderTableViewCellA.h"
#import "JXHomepagModel.h"

@interface JXOrderTableViewCellA ()
// 促销
@property (weak, nonatomic) IBOutlet UILabel *promotionLabel;

@property (weak, nonatomic) IBOutlet UILabel *contentLabelf;
@property (weak, nonatomic) IBOutlet UILabel *contentLabelS;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
// 折扣
@property (weak, nonatomic) IBOutlet UILabel *discountLabel;
@property (weak, nonatomic) IBOutlet UIView *discountLine;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *priceHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *discountHeight;
@property (weak, nonatomic) IBOutlet UIView *colorView;

@end


@implementation JXOrderTableViewCellA


+ (instancetype)cellWithTable {

    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JXOrderTableViewCellA class]) owner:self options:nil] lastObject];
}




- (void)setModel:(JXHomepagModel *)model {

    _model = model;
    
    NSString *prostr;
    if ([model.type integerValue] == 0)
    { // 普通
        prostr = @"";
    }
    else if ([model.type integerValue] == 1)
    {// 热卖
    
        prostr = [NSString stringWithFormat:@" %@  ",@"热卖"];
    }
    else if ([model.type integerValue] == 2)
    {// 新品
        prostr = [NSString stringWithFormat:@" %@  ",@"新品"];
    }
    else if ([model.type integerValue] == 3)
    {// 清仓
        prostr = [NSString stringWithFormat:@" %@  ",@"清仓"];
    }
   // [self.promotionLabel setText:prostr];
    NSString *contents = model.good_name;
    // 获取单个字的宽度
    CGFloat wordwide = [JXEncapSulationObjc stringWidth:@"长" maxSize:NPWidth fontSize:16.0f];
    // 获取首段宽度
    CGFloat width = NPWidth-15-15-12-self.priceLabel.frame.size.width;
    // 获取第一段所占文字个数
    NSInteger number = width/wordwide;
    if (contents.length>number) {
        // 显示两行的字
        [self.contentLabelf setText:[contents substringWithRange:NSMakeRange(0, number)]];
        [self.contentLabelS setText:[contents substringWithRange:NSMakeRange(number, contents.length-number)]];
    }else {
        self.priceHeight.constant = 8;
        self.discountHeight.constant = 12;
        [self.contentLabelf setText:contents];
    }
    if (model.good_price!=nil) {
        [_priceLabel setText:[NSString stringWithFormat:@"￥%@",model.good_price]];
    }
    if (model.market_price!=nil) {
        [_discountLabel setText:[NSString stringWithFormat:@"￥%@",model.market_price]];
    }
    
    
    [self layoutIfNeeded];
    model.cellHeight = CGRectGetMaxY(_priceLabel.frame)+10;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    [self.promotionLabel.layer setMasksToBounds:true];
    [self.promotionLabel.layer setCornerRadius:3];
    [self.promotionLabel setBackgroundColor:[UIColor redColor]];
    [self.colorView setBackgroundColor:kUIColorFromRGB(0xf0f0f0)];
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
