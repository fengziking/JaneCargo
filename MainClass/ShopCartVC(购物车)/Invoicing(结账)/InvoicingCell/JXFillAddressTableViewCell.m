//
//  JXFillAddressTableViewCell.m
//  JaneCargo
//
//  Created by 鹏 on 2017/8/1.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXFillAddressTableViewCell.h"

@implementation JXFillAddressTableViewCell


+ (instancetype)cellWithTable {
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JXFillAddressTableViewCell class]) owner:self options:nil] lastObject];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
