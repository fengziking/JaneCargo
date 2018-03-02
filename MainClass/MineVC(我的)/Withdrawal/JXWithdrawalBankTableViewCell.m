//
//  JXWithdrawalBankTableViewCell.m
//  JaneCargo
//
//  Created by 鹏 on 2018/1/17.
//  Copyright © 2018年 鹏. All rights reserved.
//

#import "JXWithdrawalBankTableViewCell.h"

@interface JXWithdrawalBankTableViewCell()

@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIImageView *zfImage;

@property (weak, nonatomic) IBOutlet UIImageView *bankImage;
@property (weak, nonatomic) IBOutlet UIView *lineColor;

@property (weak, nonatomic) IBOutlet UILabel *banklabel;
@property (weak, nonatomic) IBOutlet UILabel *namelabel;
@property (weak, nonatomic) IBOutlet UILabel *banknumner;

@end

@implementation JXWithdrawalBankTableViewCell


+ (instancetype)cellwithTable {
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JXWithdrawalBankTableViewCell class]) owner:self options:nil] lastObject];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [_backView.layer setMasksToBounds:true];
    [_backView.layer setCornerRadius:5.0];
    [self setBackgroundColor:kUIColorFromRGB(0xf1f1f1)];
    [self setSelectionStyle:(UITableViewCellSelectionStyleNone)];
     [_lineColor setBackgroundColor:kUIColorFromRGB(0xe3e3e3)];
}

- (IBAction)zfpay:(UIButton *)sender {
    _ChangPay(sender.tag);
}

- (IBAction)ylpay:(UIButton *)sender {
    _ChangPay(sender.tag);
}


- (void)setModel:(JXHomepagModel *)model { // model.realname model.bank model.bank_no
    
    _model = model;
    _namelabel.text = [NSString stringWithFormat:@"持卡人姓名：%@",model.realname];
    _banklabel.text = [NSString stringWithFormat:@"提现银行：%@",model.bank];
    _banknumner.text = [NSString stringWithFormat:@"银行卡账号：%@",model.bank_no];
    
    [JXContTextObjc changelabelColor:_namelabel range:NSMakeRange(0, 6) color:kUIColorFromRGB(0x999999)];
    [JXContTextObjc changelabelColor:_banklabel range:NSMakeRange(0, 5) color:kUIColorFromRGB(0x999999)];
    [JXContTextObjc changelabelColor:_banknumner range:NSMakeRange(0, 6) color:kUIColorFromRGB(0x999999)];
    
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
