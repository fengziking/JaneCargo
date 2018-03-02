//
//  JXCourierChangTableViewCell.m
//  JaneCargo
//
//  Created by cxy on 2017/6/29.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXCourierChangTableViewCell.h"

@implementation JXCourierChangTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    
        
    }
    return self;
}

+ (instancetype)cellWithTable {

    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JXCourierChangTableViewCell class]) owner:self options:nil] lastObject];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
