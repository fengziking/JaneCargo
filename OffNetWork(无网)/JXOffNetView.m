//
//  JXOffNetView.m
//  JaneCargo
//
//  Created by cxy on 2017/8/29.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXOffNetView.h"

@interface JXOffNetView ()

@property (weak, nonatomic) IBOutlet UILabel *titleNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIButton *updatebt;


@end


@implementation JXOffNetView




- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setBackgroundColor:kUIColorFromRGB(0xf2f2f2)];
    [self.titleNameLabel setTextColor:kUIColorFromRGB(0x666666)];
    [self.titleLabel setTextColor:kUIColorFromRGB(0x666666)];
    
    [self.updatebt.layer setMasksToBounds:YES];
    [self.updatebt.layer setCornerRadius:3];
    [self.updatebt.layer setBorderColor:[kUIColorFromRGB(0xe3e3e3) CGColor]];
    [self.updatebt.layer setBorderWidth:0.5f];
}
- (IBAction)updateAction:(UIButton *)sender {
    
    _UpdateRequest();
}

@end
