//
//  JXNoContentTableViewCell.m
//  JaneCargo
//
//  Created by 鹏 on 2017/9/1.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXNoContentTableViewCell.h"

@implementation JXNoContentTableViewCell


+ (instancetype)cellWithTable {

    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JXNoContentTableViewCell class]) owner:self options:nil] lastObject];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
