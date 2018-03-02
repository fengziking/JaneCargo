//
//  JXManagementTableViewCell.m
//  JaneCargo
//
//  Created by 鹏 on 2018/1/17.
//  Copyright © 2018年 鹏. All rights reserved.
//

#import "JXManagementTableViewCell.h"


@interface JXManagementTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *typelabel;
@property (weak, nonatomic) IBOutlet UILabel *pricelabel;
@property (weak, nonatomic) IBOutlet UILabel *ispaylabel;

@property (weak, nonatomic) IBOutlet UILabel *timelabel;


@end


@implementation JXManagementTableViewCell

+ (instancetype)cellwithTable {
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JXManagementTableViewCell class]) owner:self options:nil] lastObject];
    
}


- (void)setModel:(JXHomepagModel *)model {  // 3-支出   4   0 在处理
    
    _model = model;
    _title.text = model.docs;
    
    
    if ([[NSString stringWithFormat:@"%@",model.status] isEqualToString:@"2"]) {
        _typelabel.text = @"类型:消费";
        _pricelabel.text = [NSString stringWithFormat:@"-%@",model.money];
        [_pricelabel setTextColor:kUIColorFromRGB(0x38b711)];
    }
    

    if ([[NSString stringWithFormat:@"%@",model.status] isEqualToString:@"3"]) {
        _typelabel.text = @"类型:支出";
        _pricelabel.text = [NSString stringWithFormat:@"-%@",model.money];
        [_pricelabel setTextColor:kUIColorFromRGB(0x38b711)];
    }else if ([[NSString stringWithFormat:@"%@",model.status] isEqualToString:@"4"]) {
        _typelabel.text = @"类型:收入";
        _pricelabel.text = [NSString stringWithFormat:@"+%@",model.money];
    }
    
    if ([[NSString stringWithFormat:@"%@",model.is_pay] isEqualToString:@"0"]) {
        _ispaylabel.text = @"在处理";
    }else if ([[NSString stringWithFormat:@"%@",model.status] isEqualToString:@"4"]) {
        _ispaylabel.text = @"成功转账";
    }
    _timelabel.text = [NSString stringWithFormat:@"%@",model.pay_time];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    [self setSelectionStyle:(UITableViewCellSelectionStyleNone)];
    [self.layer setBorderWidth:0.5];
    [self.layer setBorderColor:[kUIColorFromRGB(0xe3e3e3) CGColor]];
    [_typelabel setTextColor:kUIColorFromRGB(0x999999)];
    [_ispaylabel setTextColor:kUIColorFromRGB(0x999999)];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
