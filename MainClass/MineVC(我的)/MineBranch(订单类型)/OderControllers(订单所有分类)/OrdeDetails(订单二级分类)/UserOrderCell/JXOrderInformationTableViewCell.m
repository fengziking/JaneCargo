//
//  JXOrderInformationTableViewCell.m
//  JaneCargo
//
//  Created by 鹏 on 2017/7/10.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXOrderInformationTableViewCell.h"

@interface JXOrderInformationTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *orderLabel;
@property (weak, nonatomic) IBOutlet UIButton *orderCopybutton;

@property (weak, nonatomic) IBOutlet UIView *line;

@end

@implementation JXOrderInformationTableViewCell


+ (instancetype)cellWithTable {
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JXOrderInformationTableViewCell class]) owner:self options:nil] lastObject];
}

- (IBAction)copyAction:(UIButton *)sender {
    
    // copy
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    NSArray *orderRarry = [_orderLabel.text componentsSeparatedByString:@":"];
    pasteboard.string = orderRarry[1];
    _CopySuccess();
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [_line setBackgroundColor:kUIColorFromRGB(0xcccccc)];
    [self setSelectionStyle:(UITableViewCellSelectionStyleNone)];
    
}

- (void)setModel:(MKOrderListModel *)model {

    _model = model;

    switch (model.typeIndex) {
        case 0:// 订单编号
        {
            self.orderLabel.text = [NSString stringWithFormat:@"订单编号:%@",model.ordersn];
        }
            break;
        case 1:// 下单
        {
            self.orderLabel.text = [NSString stringWithFormat:@"下单时间:%@",model.create_time];
        }
            break;
        case 2: // 付款
        {
            self.orderLabel.text = [NSString stringWithFormat:@"付款时间:%@",model.pay_time];
        }
            break;
        case 3: // 发货
        {
            self.orderLabel.text = [NSString stringWithFormat:@"发货时间:%@",model.do_time];
        }
            break;
        case 4: // 收货
        {
            self.orderLabel.text = [NSString stringWithFormat:@"收货时间:%@",model.recipient_time];
        }
            break;
        default:
            break;
    }
    
    
}


- (void)setHiddenCopy:(BOOL)hiddenCopy {
    [self.orderCopybutton setHidden:hiddenCopy];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
