//
//  JXWithdrawalZFPTableViewCell.m
//  JaneCargo
//
//  Created by 鹏 on 2018/1/17.
//  Copyright © 2018年 鹏. All rights reserved.
//

#import "JXWithdrawalZFPTableViewCell.h"

@interface JXWithdrawalZFPTableViewCell()

@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIImageView *zfImage;
@property (weak, nonatomic) IBOutlet UIImageView *bankImage;
@property (weak, nonatomic) IBOutlet UIView *lineColor;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *zfLabel;


@end


@implementation JXWithdrawalZFPTableViewCell


+ (instancetype)cellwithTable {
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JXWithdrawalZFPTableViewCell class]) owner:self options:nil] lastObject];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [_backView.layer setMasksToBounds:true];
    [_backView.layer setCornerRadius:5.0];
    [self setBackgroundColor:kUIColorFromRGB(0xf1f1f1)];
    [self setSelectionStyle:(UITableViewCellSelectionStyleNone)];
     [_lineColor setBackgroundColor:kUIColorFromRGB(0xe3e3e3)];
}

- (void)setModel:(JXHomepagModel *)model { // model.realname model.alipay_no
    
    _model = model;
    _nameLabel.text = [NSString stringWithFormat:@"真实姓名：%@",model.realname];
    _zfLabel.text = [NSString stringWithFormat:@"支付宝账号：%@",model.alipay_no];
    
    [JXContTextObjc changelabelColor:_nameLabel range:NSMakeRange(0, 5) color:kUIColorFromRGB(0x999999)];
    [JXContTextObjc changelabelColor:_zfLabel range:NSMakeRange(0, 6) color:kUIColorFromRGB(0x999999)];
}


- (IBAction)zfpay:(UIButton *)sender {
    
    _ChangPay(sender.tag);
}


- (IBAction)ylpay:(UIButton *)sender {
    _ChangPay(sender.tag);
}





- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
