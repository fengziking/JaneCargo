//
//  JXOrderdetailImageTableViewCell.m
//  JaneCargo
//
//  Created by 鹏 on 2017/7/10.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXOrderdetailImageTableViewCell.h"

@interface JXOrderdetailImageTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *startImage;

@end

@implementation JXOrderdetailImageTableViewCell

+ (instancetype)cellWithTable {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JXOrderdetailImageTableViewCell class]) owner:self options:nil] lastObject];
}

- (void)setStart_Image:(NSString *)start_Image {
    [self.startImage setImage:[UIImage imageNamed:start_Image]];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setSelectionStyle:(UITableViewCellSelectionStyleNone)];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
