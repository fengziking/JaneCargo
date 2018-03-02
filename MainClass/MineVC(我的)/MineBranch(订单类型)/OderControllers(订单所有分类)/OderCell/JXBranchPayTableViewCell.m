//
//  JXBranchPayTableViewCell.m
//  JaneCargo
//
//  Created by 鹏 on 2017/7/10.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXBranchPayTableViewCell.h"


@interface JXBranchPayTableViewCell ()

@property (weak, nonatomic) IBOutlet UIButton *payButton;

@property (weak, nonatomic) IBOutlet UIButton *cancelOrderButton;

@property (weak, nonatomic) IBOutlet UIView *lineView;

@end

@implementation JXBranchPayTableViewCell



+ (instancetype)cellWithTable {
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JXBranchPayTableViewCell class]) owner:self options:nil] lastObject];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    [_lineView setBackgroundColor:kUIColorFromRGB(0xcccccc)];
    
    [self.payButton.layer setMasksToBounds:true];
    [self.payButton.layer setCornerRadius:self.payButton.frame.size.height/2];
    [self.payButton.layer setBorderColor:[kUIColorFromRGB(0xef5b4c) CGColor]];
    [self.payButton.layer setBorderWidth:0.5f];
    [self.payButton setTitleColor:kUIColorFromRGB(0xef5b4c) forState:(UIControlStateNormal)];
    
    [self.cancelOrderButton.layer setMasksToBounds:true];
    [self.cancelOrderButton.layer setCornerRadius:self.payButton.frame.size.height/2];
    [self.cancelOrderButton.layer setBorderColor:[kUIColorFromRGB(0xef5b4c) CGColor]];
    [self.cancelOrderButton.layer setBorderWidth:0.5f];
    [self.cancelOrderButton setTitleColor:kUIColorFromRGB(0xef5b4c) forState:(UIControlStateNormal)];
    
}


- (IBAction)canceAction:(UIButton *)sender {
    _click(_model,0);
}


- (IBAction)paybtAction:(UIButton *)sender {
    _click(_model,1);
}


- (void)setModel:(MKOrderListModel *)model {

    _model = model;
    
    [JXJudgeStrObjc distinguishTheCategory:_model delivery:^{ // 待发货
        
        if ([_model.is_return isEqualToString:@"1"]) {
            
            [self.cancelOrderButton setTitle:@"联系商家" forState:(UIControlStateNormal)];
            [self.payButton setTitle:@"取消退款" forState:(UIControlStateNormal)];
        }else {
            
            [self.payButton setTitle:@"提醒发货" forState:(UIControlStateNormal)];
            [self.cancelOrderButton setHidden:YES];
        }
    } goods:^{  // 待收货
        
        if ([_model.is_return isEqualToString:@"1"]) {
            [self.cancelOrderButton setHidden:YES];
            [self.payButton setTitle:@"联系商家" forState:(UIControlStateNormal)];
        }else {
            
            [self.cancelOrderButton setTitle:@"查看物流" forState:(UIControlStateNormal)];
            [self.payButton setTitle:@"确定收货" forState:(UIControlStateNormal)];
        }
        
    } orderfinished:^{ // 订单完成
        [self.cancelOrderButton setTitle:@"删除订单" forState:(UIControlStateNormal)];
        [self.payButton setTitle:@"去评价" forState:(UIControlStateNormal)];
        
    } returngoods:^{ // 退货中
        [self.cancelOrderButton setTitle:@"联系商家" forState:(UIControlStateNormal)];
        [self.payButton setTitle:@"取消退款" forState:(UIControlStateNormal)];
        
    } payment:^{  // 待付款
        [self.cancelOrderButton setTitle:@"取消订单" forState:(UIControlStateNormal)];
        [self.payButton setTitle:@"去支付" forState:(UIControlStateNormal)];
        
    } recycling:^{ // 已关闭/已删除
//        [self.payButton setTitle:@"再次购买" forState:(UIControlStateNormal)];
        [self.payButton setHidden:YES];
        [self.cancelOrderButton setHidden:YES];
        
    }evaluation:^{ // 已评价
        [self.payButton setTitle:@"删除订单" forState:(UIControlStateNormal)];
        [self.cancelOrderButton setHidden:YES];
//        [self.payButton setTitle:@"再次购买" forState:(UIControlStateNormal)];
        
    } refund:^{    // 申请退款
        [self.cancelOrderButton setTitle:@"联系商家" forState:(UIControlStateNormal)];
        [self.payButton setTitle:@"取消退款" forState:(UIControlStateNormal)];
    } rejected:^{ // 7申请被拒
        
    } complete:^{ // 退款完成
        [self.payButton setTitle:@"删除订单" forState:(UIControlStateNormal)];
        [self.cancelOrderButton setHidden:YES];
//        [self.payButton setTitle:@"再次购买" forState:(UIControlStateNormal)];
    } refundon:^{ // 退款进行中
//        [self.payButton setTitle:@"联系商家" forState:(UIControlStateNormal)];
//        [self.cancelOrderButton setHidden:YES];
        [self.cancelOrderButton setTitle:@"联系商家" forState:(UIControlStateNormal)];
        [self.payButton setTitle:@"填写快递单号" forState:(UIControlStateNormal)];
        
    } agreerefund:^{ // 同意退款
        [self.cancelOrderButton setTitle:@"联系商家" forState:(UIControlStateNormal)];
        [self.payButton setTitle:@"填写快递单号" forState:(UIControlStateNormal)];
    }];

    
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
