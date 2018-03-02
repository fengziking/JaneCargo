//
//  JXMineOrderTableViewCell.m
//  JaneCargo
//
//  Created by cxy on 2017/7/5.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXMineOrderTableViewCell.h"

@interface JXMineOrderTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *checkOrder;

@property (weak, nonatomic) IBOutlet UIView *lineColor;

@end


@implementation JXMineOrderTableViewCell


+ (instancetype)cellWithTable {

    return  [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JXMineOrderTableViewCell class]) owner:self options:nil] lastObject];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    [self.lineColor setBackgroundColor:kUIColorFromRGB(0xe3e3e3)];
    [self.checkOrder setTextColor:kUIColorFromRGB(0x999999)];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
