//
//  JXInvoicingPayWayTableViewCell.m
//  JaneCargo
//
//  Created by 鹏 on 2017/7/31.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXInvoicingPayWayTableViewCell.h"

@interface JXInvoicingPayWayTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *paywayLabel;
@property (weak, nonatomic) IBOutlet UIView *line;


@end

@implementation JXInvoicingPayWayTableViewCell

+ (instancetype)cellWithTable {
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JXInvoicingPayWayTableViewCell class]) owner:self options:nil] lastObject];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.line setBackgroundColor:kUIColorFromRGB(0xcccccc)];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setTitle:(NSString *)title {
    [self.titleLabel setText:title];
}
- (void)setPayWay_str:(NSString *)payWay_str {
    [self.paywayLabel setText:payWay_str];
}

- (void)setHiddenLine {

    [self.line setHidden:YES];
}


@end
