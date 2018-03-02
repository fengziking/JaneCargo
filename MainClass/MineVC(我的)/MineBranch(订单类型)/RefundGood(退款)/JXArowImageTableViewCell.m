//
//  JXArowImageTableViewCell.m
//  JaneCargo
//
//  Created by 鹏 on 2017/8/5.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXArowImageTableViewCell.h"


@interface JXArowImageTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation JXArowImageTableViewCell


+ (instancetype)cellWithTable {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JXArowImageTableViewCell class]) owner:self options:nil] lastObject];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [_titleLabel setTextColor:kUIColorFromRGB(0xbbbbbb)];
}
- (void)setTitle:(NSString *)title {
    _titleLabel.text = title;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
