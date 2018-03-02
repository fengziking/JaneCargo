//
//  JXMineCourierTableViewCell.m
//  JaneCargo
//
//  Created by cxy on 2017/7/5.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXMineCourierTableViewCell.h"


@interface JXMineCourierTableViewCell ()

@property (weak, nonatomic) IBOutlet UIButton *payButton;
@property (weak, nonatomic) IBOutlet UIButton *deliveryButton;
@property (weak, nonatomic) IBOutlet UIButton *goodsButton;
@property (weak, nonatomic) IBOutlet UIButton *commentsButton;
@property (weak, nonatomic) IBOutlet UIButton *returnGoodsButton;

// 待付款
@property (weak, nonatomic) IBOutlet UILabel *paymentLabel;

// 快递数量
@property (weak, nonatomic) IBOutlet UILabel *deliveryNumber;

// 待收货
@property (weak, nonatomic) IBOutlet UILabel *goodslabels;
// 去评论
@property (weak, nonatomic) IBOutlet UILabel *commentlabel;

@end

@implementation JXMineCourierTableViewCell


+ (instancetype)cellWithTable {
    
    return  [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JXMineCourierTableViewCell class]) owner:self options:nil] lastObject];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [_deliveryNumber.layer setMasksToBounds:YES];
    [_deliveryNumber.layer setCornerRadius:self.deliveryNumber.frame.size.height/2];
    [_paymentLabel.layer setMasksToBounds:YES];
    [_paymentLabel.layer setCornerRadius:self.paymentLabel.frame.size.height/2];
    [_goodslabels.layer setMasksToBounds:YES];
    [_goodslabels.layer setCornerRadius:self.goodslabels.frame.size.height/2];
    [_commentlabel.layer setMasksToBounds:YES];
    [_commentlabel.layer setCornerRadius:self.commentlabel.frame.size.height/2];
    
    
    [_deliveryNumber setTextColor:kUIColorFromRGB(0xffffff)];
    
    [_payButton addTarget:self action:@selector(payAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [_deliveryButton addTarget:self action:@selector(deliveryAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [_goodsButton addTarget:self action:@selector(goodsAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [_commentsButton addTarget:self action:@selector(commentsAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [_returnGoodsButton addTarget:self action:@selector(returnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
}


- (void)setPayment:(NSString *)payment {
    if ([payment integerValue] != 0) {
        self.paymentLabel.text = [NSString stringWithFormat:@"  %@  ",payment];
    }
}

- (void)setDelivery:(NSString *)delivery {
    
    if ([delivery integerValue] != 0) {
        self.deliveryNumber.text = [NSString stringWithFormat:@"  %@  ",delivery];
    }
}

- (void)setGoodslabel:(NSString *)goodslabel {

    if ([goodslabel integerValue] != 0) {
        self.goodslabels.text = [NSString stringWithFormat:@"  %@  ",goodslabel];
    }
}
- (void)setComment:(NSString *)comment {

    if ([comment integerValue] != 0) {
        self.commentlabel.text = [NSString stringWithFormat:@"  %@  ",comment];
    }
}





- (void)payAction:(UIButton *)sender {

    _courier(sender.tag);
}

- (void)deliveryAction:(UIButton *)sender {
    
     _courier(sender.tag);
}
- (void)goodsAction:(UIButton *)sender {
    
     _courier(sender.tag);
}
- (void)commentsAction:(UIButton *)sender {
    
     _courier(sender.tag);
}
- (void)returnAction:(UIButton *)sender {
    
     _courier(sender.tag);
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
