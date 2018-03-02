//
//  JXInvoicingInvoiceTableViewCell.m
//  JaneCargo
//
//  Created by 鹏 on 2017/7/31.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXInvoicingInvoiceTableViewCell.h"

@interface JXInvoicingInvoiceTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *invoicingLabel;

@property (weak, nonatomic) IBOutlet UISwitch *switchb;
@property (weak, nonatomic) IBOutlet UIView *line;

@end

@implementation JXInvoicingInvoiceTableViewCell

+ (instancetype)cellWithTable {
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JXInvoicingInvoiceTableViewCell class]) owner:self options:nil] lastObject];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    [self.line setBackgroundColor:kUIColorFromRGB(0xcccccc)];
}

- (IBAction)invoicingAction:(UISwitch *)sender {
    
    BOOL isButtonOn = [_switchb isOn];
    _switchblock(isButtonOn);
    
}

- (void)setTitle:(NSString *)title {
    _invoicingLabel.text = title;
}
- (void)setSwitchOn:(BOOL)switchOn {
    
    self.switchb.on = switchOn;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
