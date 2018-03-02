//
//  JXIntegralTableViewCell.m
//  JaneCargo
//
//  Created by 鹏 on 2017/8/9.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXIntegralTableViewCell.h"


@interface JXIntegralTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *integralLabel;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIView *line;

@end


@implementation JXIntegralTableViewCell



+ (instancetype)cellWithTable {
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JXIntegralTableViewCell class]) owner:self options:nil] lastObject];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.line setBackgroundColor:kUIColorFromRGB(0xe3e3e3)];
    [self.integralLabel setTextColor:kUIColorFromRGB(0xe60012)];
    [self.timeLabel setTextColor:kUIColorFromRGB(0x999999)];
}

- (void)setModel:(JXHomepagModel *)model {

    _model = model;
    self.integralLabel.text = [NSString stringWithFormat:@"¥ %@",model.money];
    self.contentLabel.text = [NSString stringWithFormat:@"订单编号: %@",model.orderid];
    self.timeLabel.text = model.create_time;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
