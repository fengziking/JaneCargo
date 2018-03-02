//
//  JXMineExitTableViewCell.m
//  JaneCargo
//
//  Created by cxy on 2017/7/5.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXMineExitTableViewCell.h"

@implementation JXMineExitTableViewCell

+ (instancetype)cellWithTable {
    
    return  [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JXMineExitTableViewCell class]) owner:self options:nil] lastObject];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}


@end
