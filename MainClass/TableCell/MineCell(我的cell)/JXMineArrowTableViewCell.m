//
//  JXMineArrowTableViewCell.m
//  JaneCargo
//
//  Created by cxy on 2017/7/5.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXMineArrowTableViewCell.h"

@interface JXMineArrowTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *lines;

@end

@implementation JXMineArrowTableViewCell

+ (instancetype)cellWithTable {
    
    return  [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JXMineArrowTableViewCell class]) owner:self options:nil] lastObject];
}


- (void)setTitle:(NSString *)title {

    self.titleLabel.text = title;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [_lines setBackgroundColor:kUIColorFromRGB(0xe3e3e3)];
    [self.titleLabel setTextColor:kUIColorFromRGB(0x333333)];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
