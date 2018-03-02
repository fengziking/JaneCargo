//
//  JXDeletehisTableViewCell.m
//  JaneCargo
//
//  Created by 鹏 on 2017/7/13.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXDeletehisTableViewCell.h"

@interface JXDeletehisTableViewCell ()

@property (weak, nonatomic) IBOutlet UIButton *deletehisbt;

@end

@implementation JXDeletehisTableViewCell


+ (instancetype)cellWithTable {
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JXDeletehisTableViewCell class]) owner:self options:nil] lastObject];
}


- (IBAction)deleteHisAction:(UIButton *)sender {
    
    _deletehis();
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.deletehisbt.layer setMasksToBounds:true];
    [self.deletehisbt.layer setCornerRadius:5];
    [self.deletehisbt.layer setBorderColor:[kUIColorFromRGB(0xe3e3e3) CGColor]];
    [self.deletehisbt.layer setBorderWidth:0.5f];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
