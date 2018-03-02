//
//  JXNoOrderTableViewCell.m
//  JaneCargo
//
//  Created by 鹏 on 2017/8/16.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXNoOrderTableViewCell.h"

@interface JXNoOrderTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titles;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *shopbt;
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;


@end


@implementation JXNoOrderTableViewCell


+ (instancetype)cellWithTable {
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JXNoOrderTableViewCell class]) owner:self options:nil] lastObject];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setBackgroundColor:kUIColorFromRGB(0xf2f2f2)];

    [self.iconImage setImage:[UIImage imageNamed:@"订单列表无内容"]];
    [self.titles setText:@"您还没有相关的订单"];
    [self.titleLabel setText:@"可以去看看哪些想买的"];
    [self.shopbt setTitle:@"随便逛逛" forState:(UIControlStateNormal)];
    [JXContTextObjc p_SetfondLabel:_titles fondSize:16];
    [JXContTextObjc p_SetfondLabel:_titleLabel fondSize:12];
    [JXContTextObjc p_SetfondButton:_shopbt fondSize:15];
    [_titleLabel setTextColor:kUIColorFromRGB(0x999999)];
    
    [_shopbt.layer setMasksToBounds:true];
    [_shopbt.layer setCornerRadius:5.0];
    [_shopbt.layer setBorderWidth:0.5];
    [_shopbt.layer setBorderColor:[[UIColor redColor] CGColor]];
    
    
    
}


- (IBAction)goshopAction:(UIButton *)sender {
    _Goshoppingblock();
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
