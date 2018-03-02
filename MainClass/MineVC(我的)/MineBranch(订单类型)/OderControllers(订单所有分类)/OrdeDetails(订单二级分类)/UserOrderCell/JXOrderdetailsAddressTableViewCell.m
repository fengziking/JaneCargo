//
//  JXOrderdetailsAddressTableViewCell.m
//  JaneCargo
//
//  Created by 鹏 on 2017/7/10.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXOrderdetailsAddressTableViewCell.h"

@interface JXOrderdetailsAddressTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *photoNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *defaultLabel;

@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@end

@implementation JXOrderdetailsAddressTableViewCell


+ (instancetype)cellWithTable {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JXOrderdetailsAddressTableViewCell class]) owner:self options:nil] lastObject];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    [self setSelectionStyle:(UITableViewCellSelectionStyleNone)];
    [self.defaultLabel.layer setMasksToBounds:true];
    [self.defaultLabel.layer setCornerRadius:2];
    [self.defaultLabel.layer setBorderColor:[kUIColorFromRGB(0xef5b4c) CGColor]];
    [self.defaultLabel.layer setBorderWidth:0.5f];
    
}

- (void)setModel:(MKOrderListModel *)model {
    
    _model = model;
    self.nameLabel.text = model.address[@"name"];
    self.photoNumberLabel.text = model.address[@"phone"];
    NSString *provinces = [JXJudgeStrObjc judgestr:model.address[@"s_province"]];
    NSString *city = [JXJudgeStrObjc judgestr:model.address[@"s_city"]];
    NSString *county = [JXJudgeStrObjc judgestr:model.address[@"s_county"]];
    NSString *address = [JXJudgeStrObjc judgestr:model.address[@"address"]];
    self.addressLabel.text = [NSString stringWithFormat:@"%@%@%@%@",provinces,city,county,address];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
