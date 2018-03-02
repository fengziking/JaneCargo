//
//  JXParameterTableViewCell.m
//  JaneCargo
//
//  Created by 鹏 on 2017/7/18.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXParameterTableViewCell.h"

@interface JXParameterTableViewCell ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contntLabel;
@property (weak, nonatomic) IBOutlet UIView *concolorView;
@property (weak, nonatomic) IBOutlet UIView *colorView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *content;

@end

@implementation JXParameterTableViewCell


+ (instancetype)cellWithTable {
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JXParameterTableViewCell class]) owner:self options:nil] lastObject];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [_concolorView setBackgroundColor:kUIColorFromRGB(0xcccccc)];
    [_colorView setBackgroundColor:kUIColorFromRGB(0xcccccc)];
    
}
- (void)setTitle:(NSString *)title {
    _nameLabel.text = title;
}

- (void)setModel:(JXHomepagModel *)model {
    _model = model;
    self.nameLabel.text = model.name;
    self.content.text = model.value;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}


@end
