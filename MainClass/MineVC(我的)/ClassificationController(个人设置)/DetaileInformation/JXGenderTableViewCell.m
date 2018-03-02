//
//  JXGenderTableViewCell.m
//  JaneCargo
//
//  Created by cxy on 2017/7/6.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXGenderTableViewCell.h"

@interface JXGenderTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;



@property (weak, nonatomic) IBOutlet UIView *lineView;

@end

@implementation JXGenderTableViewCell


+ (instancetype)cellWithTable {
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JXGenderTableViewCell class]) owner:self options:nil] lastObject];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.lineView setBackgroundColor:kUIColorFromRGB(0xe3e3e3)];
    
//    [self.iconImage setImage:[UIImage imageNamed:@""]];
}




- (void)setTitle:(NSString *)title {
    _titleLabel.text = title;
}


- (void)setHiddenLine:(BOOL)hiddenLine {
    [self.lineView setHidden:hiddenLine];
}





- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
