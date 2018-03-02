//
//  JXInvoicingAddressTableViewCell.m
//  JaneCargo
//
//  Created by 鹏 on 2017/7/28.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXInvoicingAddressTableViewCell.h"

@interface JXInvoicingAddressTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *photoNumber;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (weak, nonatomic) IBOutlet UILabel *defaultLabel;


@end


@implementation JXInvoicingAddressTableViewCell


+ (instancetype)cellWithTable {
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JXInvoicingAddressTableViewCell class]) owner:self options:nil] lastObject];
}

- (void)setModel:(JXAddressModel *)model {
    _model = model;
    if ([model.is_default isEqualToString:@"1"]) {
        [self.defaultLabel setText:@"默认"];
        [self.defaultLabel.layer setMasksToBounds:true];
        [self.defaultLabel.layer setCornerRadius:2.0];
        [self.defaultLabel.layer setBorderWidth:0.5];
        [self.defaultLabel.layer setBorderColor:[[UIColor redColor] CGColor]];
    }
    
    NSString *before_str = [model.phone substringWithRange:NSMakeRange(0, 3)];
    NSString *after_str = [model.phone substringWithRange:NSMakeRange(model.phone.length-3, 3)];
    [_photoNumber setText:[NSString stringWithFormat:@"%@***%@",before_str,after_str]];
    _nameLabel.text = model.name;
    
    NSString*prostr= [self procitycount:model.s_province];
    NSString*citystr= [self procitycount:model.s_city];
    NSString*countystr= [self procitycount:model.s_county];
    _contentLabel.text = [NSString stringWithFormat:@"%@%@%@%@",prostr,citystr,countystr,model.address];
}

- (NSString *)procitycount:(NSString *)prostr {
    if (kStringIsEmpty(prostr)) {
        return @"";
    }else {
        return prostr;
    }
}



- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
