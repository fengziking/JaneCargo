//
//  JXReasonRefundtableTableViewCell.m
//  JaneCargo
//
//  Created by 鹏 on 2017/8/5.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXReasonRefundtableTableViewCell.h"

@interface JXReasonRefundtableTableViewCell ()


@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *is_selectImage;

@property (weak, nonatomic) IBOutlet UIView *line;

@end

@implementation JXReasonRefundtableTableViewCell


+ (instancetype)cellWithTable {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JXReasonRefundtableTableViewCell class]) owner:self options:nil] lastObject];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [_line setBackgroundColor:kUIColorFromRGB(0xe3e3e3)];
//    [JXContTextObjc p_SetfondLabel:_titleLabel fondSize:15.0f];
    [self.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (void)setTitle:(NSString *)title {
    [_titleLabel setText:title];
}

- (void)setSelect_image:(NSString *)select_image {
    [_is_selectImage setImage:[UIImage imageNamed:select_image]];
}


@end
