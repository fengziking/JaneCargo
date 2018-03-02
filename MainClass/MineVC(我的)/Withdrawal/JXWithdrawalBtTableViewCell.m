//
//  JXWithdrawalBtTableViewCell.m
//  JaneCargo
//
//  Created by 鹏 on 2018/1/25.
//  Copyright © 2018年 鹏. All rights reserved.
//

#import "JXWithdrawalBtTableViewCell.h"

@interface JXWithdrawalBtTableViewCell()

@property (weak, nonatomic) IBOutlet UIButton *withdrawabt;


@end

@implementation JXWithdrawalBtTableViewCell

+ (instancetype)cellwithTable {
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JXWithdrawalBtTableViewCell class]) owner:self options:nil] lastObject];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setSelectionStyle:(UITableViewCellSelectionStyleNone)];
    [self setBackgroundColor:kUIColorFromRGB(0xf1f1f1)];
    [_withdrawabt.layer setMasksToBounds:true];
    [_withdrawabt.layer setCornerRadius:5.0];
    [_withdrawabt setBackgroundColor:kUIColorFromRGB(0xe82b48)];  // e82b48 0xCCCCCC
}

- (IBAction)tijiaobt:(UIButton *)sender {
    
    _SubmitPay();
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
