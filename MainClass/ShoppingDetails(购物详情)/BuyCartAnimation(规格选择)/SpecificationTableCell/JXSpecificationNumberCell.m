//
//  JXSpecificationNumberCell.m
//  JaneCargo
//
//  Created by 鹏 on 2017/9/12.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXSpecificationNumberCell.h"

@interface JXSpecificationNumberCell()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


@end

@implementation JXSpecificationNumberCell

+ (instancetype)cellWithTable {
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JXSpecificationNumberCell class]) owner:self options:nil] lastObject];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setSelectionStyle:(UITableViewCellSelectionStyleNone)];
    [self.titleLabel setTextColor:kUIColorFromRGB(0x333333)];
}


- (void)setTitle:(NSString *)title {

    self.titleLabel.text = title;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
