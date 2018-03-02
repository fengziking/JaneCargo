//
//  JXRefundTableViewCell.m
//  JaneCargo
//
//  Created by 鹏 on 2017/8/4.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXRefundTableViewCell.h"

@interface JXRefundTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *refundLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;


@end

@implementation JXRefundTableViewCell


+ (instancetype)cellWithTable {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JXRefundTableViewCell class]) owner:self options:nil] lastObject];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.refundLabel setTextColor:[UIColor whiteColor]];
    [self.timeLabel setTextColor:[UIColor whiteColor]];
}

- (void)setModel:(MKOrderListModel *)model {

    _model = model;
    if ([model.status isEqualToString:@"4"]||[self.model.status isEqualToString:@"1"]||[self.model.status isEqualToString:@"2"])
    { // 已申请退款，d等待商家确认（（退货中）
        self.refundLabel.text = @"已申请退款，等待商家确认";
        self.timeLabel.text = @"请耐心等待...";
    }
    else if ([model.status isEqualToString:@"10"])
    { // 退款成功 货款已到账
        self.refundLabel.text = @"退款成功";
        self.timeLabel.text = [NSString stringWithFormat:@"货款%@已退回您的账户",model.total];
    }
    else if ([model.status isEqualToString:@"11"])
    { // 商家已经同意退款
        self.refundLabel.text = @"商家已同意您的退款申请";
        self.timeLabel.text = @"货款将在1-3个工作日内退回您的账户";
    }
    else if ([model.status isEqualToString:@"12"])
    { // 商家已经同意退货
        self.refundLabel.text = @"商家已同意您的退款申请";
        self.timeLabel.text = @"请将货物寄回（详细地址请看下方）";
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
