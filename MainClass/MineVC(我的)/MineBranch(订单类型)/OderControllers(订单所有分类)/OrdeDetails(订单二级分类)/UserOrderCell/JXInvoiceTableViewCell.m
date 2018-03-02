//
//  JXInvoiceTableViewCell.m
//  JaneCargo
//
//  Created by 鹏 on 2017/7/10.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXInvoiceTableViewCell.h"

@interface JXInvoiceTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *invoiceLabel;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end

@implementation JXInvoiceTableViewCell


+ (instancetype)cellWithTable {
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JXInvoiceTableViewCell class]) owner:self options:nil] lastObject];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [_contentLabel setTextColor:kUIColorFromRGB(0x999999)];
    [self setSelectionStyle:(UITableViewCellSelectionStyleNone)];
}

- (void)setModel:(MKOrderListModel *)model {
    _model = model;
    self.invoiceLabel.text = [NSString stringWithFormat:@"发票抬头:%@",model.rise];
    self.contentLabel.text = @"发票将会在订单完成三个工作日内寄出";
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
