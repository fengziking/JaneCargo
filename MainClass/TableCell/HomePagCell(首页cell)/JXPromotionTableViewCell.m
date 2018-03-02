//
//  JXPromotionTableViewCell.m
//  JaneCargo
//
//  Created by 鹏 on 2017/8/12.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXPromotionTableViewCell.h"

@implementation JXPromotionTableViewCell


+ (instancetype)cellWithTable {
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JXPromotionTableViewCell class]) owner:self options:nil] lastObject];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
