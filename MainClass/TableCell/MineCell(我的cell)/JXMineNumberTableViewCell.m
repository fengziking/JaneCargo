//
//  JXMineNumberTableViewCell.m
//  JaneCargo
//
//  Created by cxy on 2017/7/5.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXMineNumberTableViewCell.h"

@interface JXMineNumberTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *clearLabel;

@property (weak, nonatomic) IBOutlet UILabel *numberLabel;


@end

@implementation JXMineNumberTableViewCell


+ (instancetype)cellWithTable {
    
    return  [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JXMineNumberTableViewCell class]) owner:self options:nil] lastObject];
}


- (void)setTitle:(NSString *)title {
    
    self.clearLabel.text = title;
}

- (void)setCache:(NSString *)cache {
    _numberLabel.text = cache;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    [self.clearLabel setTextColor:kUIColorFromRGB(0x333333)];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
