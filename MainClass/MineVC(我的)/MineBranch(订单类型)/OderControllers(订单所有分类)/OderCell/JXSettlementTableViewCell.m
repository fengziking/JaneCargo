//
//  JXSettlementTableViewCell.m
//  JaneCargo
//
//  Created by 鹏 on 2017/7/9.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXSettlementTableViewCell.h"


@interface JXSettlementTableViewCell ()

@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodsNumber;


@end

@interface JXSettlementTableViewCell ()



@end


@implementation JXSettlementTableViewCell

+ (instancetype)cellWithTable {
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JXSettlementTableViewCell class]) owner:self options:nil] lastObject];
}



- (void)awakeFromNib {
    [super awakeFromNib];
    [_lineView setBackgroundColor:kUIColorFromRGB(0xcccccc)];
}

- (void)setModel:(MKOrderListModel *)model {
    _model = model;
    NSString *courierFees;
    if (model.ex_money!=nil) {
        courierFees = model.ex_money;
    }else {
        courierFees = @"¥0.00";
        
    }
    CGFloat pricenumbers = [NSString stringWithFormat:@"%@",model.total].floatValue;
    self.priceLabel.text = [JXJudgeStrObjc judgestr:[NSString stringWithFormat:@"￥%0.2f(含运费¥%@)",pricenumbers,courierFees]];
    self.goodsNumber.text = [NSString stringWithFormat:@"总%@件商品: 合计实付款",model.num];
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
