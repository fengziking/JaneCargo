//
//  JXCourierCell.m
//  JaneCargo
//
//  Created by 鹏 on 2017/10/25.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXCourierCell.h"

@interface JXCourierCell ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;


@end

@implementation JXCourierCell

+ (instancetype)cellWithTable {
    
    return  [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JXCourierCell class]) owner:self options:nil] lastObject];
}

- (void)awakeFromNib {
    [super awakeFromNib];
//    [self.nameLabel setTextAlignment:(NSTextAlignmentCenter)];
}

- (void)setModel:(JXHomepagModel *)model {
    _model = model;
    self.nameLabel.text = [NSString stringWithFormat:@"%@快递",model.exname];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
