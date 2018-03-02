//
//  JXRefundImageTableViewCell.m
//  JaneCargo
//
//  Created by 鹏 on 2017/8/5.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXRefundImageTableViewCell.h"

@interface JXRefundImageTableViewCell ()


@property (weak, nonatomic) IBOutlet UIButton *uploadpicbt;
@property (weak, nonatomic) IBOutlet UIImageView *uploadImage;



@end

@implementation JXRefundImageTableViewCell


+ (instancetype)cellWithTable {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JXRefundImageTableViewCell class]) owner:self options:nil] lastObject];
}


- (IBAction)uploadAction:(UIButton *)sender {
    
    _upblock();
}


- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)adduploadImage:(UIImage *)image {

    [self.uploadImage setImage:image];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
