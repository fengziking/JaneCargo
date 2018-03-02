//
//  JXOrderGoodsPriceTableViewCell.m
//  JaneCargo
//
//  Created by 鹏 on 2017/7/10.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXOrderGoodsPriceTableViewCell.h"

@interface JXOrderGoodsPriceTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
// 快递费
@property (weak, nonatomic) IBOutlet UILabel *detailpriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalPriceLabel;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UIView *linesView;
@property (weak, nonatomic) IBOutlet UIButton *refundButton;

@end

@implementation JXOrderGoodsPriceTableViewCell

+ (instancetype)cellWithTable {
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JXOrderGoodsPriceTableViewCell class]) owner:self options:nil] lastObject];
}

- (IBAction)refundAction:(UIButton *)sender {
    
    if ([_refunddelegate respondsToSelector:@selector(refundgoos_money:)]) {
        [_refunddelegate refundgoos_money:_model];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setSelectionStyle:(UITableViewCellSelectionStyleNone)];
    [_lineView setBackgroundColor:kUIColorFromRGB(0xcccccc)];
    [_linesView setBackgroundColor:kUIColorFromRGB(0xcccccc)];
    [_priceLabel setTextColor:kUIColorFromRGB(0x999999)];
    [_detailpriceLabel setTextColor:kUIColorFromRGB(0x999999)];
    [_totalPriceLabel setTextColor:kUIColorFromRGB(0x333333)];
    
    [self.refundButton.layer setMasksToBounds:true];
    [self.refundButton.layer setCornerRadius:self.refundButton.frame.size.height/2];
    [self.refundButton.layer setBorderColor:[kUIColorFromRGB(0x999999) CGColor]];
    [self.refundButton.layer setBorderWidth:0.5f];
    [self.refundButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    
}


- (void)setHiddenbt:(BOOL)hiddenbt {
    
    [self.linesView setHidden:hiddenbt];
    [self.refundButton setHidden:hiddenbt];
}

- (void)setModel:(MKOrderListModel *)model {
    _model = model;
    
    self.totalPriceLabel.text = [NSString stringWithFormat:@"实付:￥%@",model.total];
    NSString *courierFees;
    if (model.ex_money!=nil) {
        courierFees = model.ex_money;
    }else {
        courierFees = @"¥0.00";
    }
    
    CGFloat prices = [model.total floatValue] - [courierFees floatValue];
    self.detailpriceLabel.text = [NSString stringWithFormat:@"+快递费:￥%@",courierFees];
    self.priceLabel.text = [NSString stringWithFormat:@"商品合计总价：￥%.2f",prices];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
