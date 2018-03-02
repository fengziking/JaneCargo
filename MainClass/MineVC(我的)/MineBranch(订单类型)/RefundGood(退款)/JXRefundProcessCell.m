//
//  JXRefundProcessCell.m
//  JaneCargo
//
//  Created by 鹏 on 2017/8/5.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXRefundProcessCell.h"

@interface JXRefundProcessCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIImageView *arowImage;
@property (weak, nonatomic) IBOutlet UIView *line;

@end

@implementation JXRefundProcessCell

+ (instancetype)cellWithTable {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JXRefundProcessCell class]) owner:self options:nil] lastObject];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    
}
- (void)setArowImage_str:(NSString *)arowImage_str {
    [_arowImage setImage:[UIImage imageNamed:arowImage_str]];
}
- (void)setLinecolor:(UIColor *)linecolor {
    [_line setBackgroundColor:linecolor];
}
- (void)setTitle:(NSString *)title {
    [_titleLabel setText:title];
}
- (void)setFontSize:(CGFloat)fontSize {
    [_titleLabel setFont:[UIFont systemFontOfSize:fontSize]];
}
- (void)setTitlecolor:(UIColor *)titlecolor {
    [_titleLabel setTextColor:titlecolor];
}
- (void)changeLabelFontSize:(CGFloat)size sizeRange:(NSRange)sizeRange color:(UIColor *)color colorRange:(NSRange)colorRange {
    [JXContTextObjc changeLabelFontSize:size sizeRange:sizeRange color:color colorRange:colorRange label:_titleLabel];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
