//
//  JXDeliveryinformationTableViewCell.m
//  JaneCargo
//
//  Created by 鹏 on 2017/7/10.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXDeliveryinformationTableViewCell.h"

@interface JXDeliveryinformationTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *deliverVeryLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation JXDeliveryinformationTableViewCell


+ (instancetype)cellWithTable {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JXDeliveryinformationTableViewCell class]) owner:self options:nil] lastObject];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    [self setSelectionStyle:(UITableViewCellSelectionStyleNone)];
    [_timeLabel setTextColor:kUIColorFromRGB(0x999999)];
    
}

- (void)setModel:(MKOrderListModel *)model {

    _model = model;
    if ([model.status isEqualToString:@"1"]||[model.status isEqualToString:@"8"]) {
        _deliverVeryLabel.text = @"暂无快递信息";
    }else {
        _deliverVeryLabel.text = @"有信息";
        _timeLabel.text = @"1991-14-44";
    }
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
