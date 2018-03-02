//
//  JXReturnRefundTableViewCell.m
//  JaneCargo
//
//  Created by 鹏 on 2017/8/4.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXReturnRefundTableViewCell.h"

@interface JXReturnRefundTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIView *line;

@end

@implementation JXReturnRefundTableViewCell

+ (instancetype)cellWithTable {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JXReturnRefundTableViewCell class]) owner:self options:nil] lastObject];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.line setBackgroundColor:kUIColorFromRGB(0xCCCCCC)];
}

- (void)setModel:(MKOrderListModel *)model {

    NSDictionary *dic = model.return_good;
    switch (model.typeIndex) {
        case 0:
        { // 退款原因
            if (kStringIsEmpty(dic[@"content"])) {
                self.contentLabel.text = @"退款原因：用户很懒未填写";
            }else {
                self.contentLabel.text = [NSString stringWithFormat:@"退款原因：%@",dic[@"content"]];
            }
        }
            break;
        case 1:
        {// 退款j金额
            self.contentLabel.text = [NSString stringWithFormat:@"退款金额：￥%@",dic[@"money"]];
        }
            break;
        case 2:
        {// 退款说明
            if (kStringIsEmpty(dic[@"decs"])) {
                self.contentLabel.text = @"退款说明：用户很懒未填写";
            }else {
                self.contentLabel.text = [NSString stringWithFormat:@"退款说明：%@",dic[@"decs"]];
            }
            [self.line setHidden:YES];
            model.cellHeight = CGRectGetMaxY(_contentLabel.frame)+15;
        }
            break;
        default:
            break;
    }
    [self layoutIfNeeded];

}

- (void)setModelTime:(MKOrderListModel *)modelTime {

    NSDictionary *dic = modelTime.return_good;
    KDLOG(@"%@",modelTime.receiver);
    switch (modelTime.typeIndex) {
        case 0:
        { // 申请退款时间
            
            if (![[NSString stringWithFormat:@"%@",dic[@"create_time"]] isEqualToString:@"<null>"]) {
                self.contentLabel.text = [NSString stringWithFormat:@"申请退款时间：%@",dic[@"create_time"]];
            }
        }
            break;
        case 1:
        {// 商家同意时间
            if (![[NSString stringWithFormat:@"%@",dic[@"agree_time"]] isEqualToString:@"<null>"]) {
                self.contentLabel.text = [NSString stringWithFormat:@"商家同意时间：%@",dic[@"deal_time"]];
            }
        }
            break;
        case 2:
        {// 商品回寄地址：
            
            [self.line setHidden:YES];
            // 姓名
            NSString *name = [JXJudgeStrObjc judgestr:dic[@"receiver"]];
            // 手机
             NSString *phone = [JXJudgeStrObjc judgestr:dic[@"phone"]];
            // 省市区  s_province s_city s_county r_address
            NSString *address = [NSString stringWithFormat:@"%@%@%@%@",[JXJudgeStrObjc judgestr:dic[@"s_province"]],[JXJudgeStrObjc judgestr:dic[@"s_city"]],[JXJudgeStrObjc judgestr:dic[@"s_county"]],[JXJudgeStrObjc judgestr:dic[@"r_address"]]];
            self.contentLabel.text = [NSString stringWithFormat:@"商品回寄地址：%@(%@:%@)",address,name,phone];
            [self layoutIfNeeded];
            modelTime.cellHeight = CGRectGetMaxY(_contentLabel.frame)+15;
        }
            break;
            
        default:
            break;
    }
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
