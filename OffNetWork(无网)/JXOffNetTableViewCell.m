//
//  JXOffNetTableViewCell.m
//  JaneCargo
//
//  Created by cxy on 2017/8/29.
//  Copyright © 2017年 鹏. All rights reserved.
//  208

#import "JXOffNetTableViewCell.h"


@interface JXOffNetTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;

@property (weak, nonatomic) IBOutlet UIButton *updatebt;
@property (weak, nonatomic) IBOutlet UILabel *namelabel;


@end


@implementation JXOffNetTableViewCell

+ (instancetype)cellWithTable {

    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JXOffNetTableViewCell class]) owner:self options:nil] lastObject];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    [self setSelectionStyle:(UITableViewCellSelectionStyleNone)];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_iconImage setImage:[UIImage imageNamed:@"icon_断网"]];
        [_namelabel setText:@"网络请求失败"];
        [_titleNameLabel setText:@"请检查您的网络"];
        [_titleLabel setText:@"重新加载吧"];
        [_updatebt setTitle:@"重新加载" forState:(UIControlStateNormal)];
        [self setBackgroundColor:kUIColorFromRGB(0xf2f2f2)];
        [self.titleNameLabel setTextColor:kUIColorFromRGB(0x666666)];
        [self.titleLabel setTextColor:kUIColorFromRGB(0x666666)];
        
        [self.updatebt.layer setMasksToBounds:YES];
        [self.updatebt.layer setCornerRadius:3];
        [self.updatebt.layer setBorderColor:[kUIColorFromRGB(0xe3e3e3) CGColor]];
        [self.updatebt.layer setBorderWidth:0.5f];

    });
    
    
    
}


- (IBAction)updateAction:(UIButton *)sender {
    
    _UpdateRequest();
}





@end
