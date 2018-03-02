//
//  JXEmptyShopTableViewCell.m
//  JaneCargo
//
//  Created by cxy on 2017/7/3.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXEmptyShopTableViewCell.h"

@interface JXEmptyShopTableViewCell ()


@property (weak, nonatomic) IBOutlet UIButton *goShopping;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation JXEmptyShopTableViewCell


+ (instancetype)cellWhiTable {

    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JXEmptyShopTableViewCell class]) owner:self options:nil] lastObject];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.goShopping.layer setMasksToBounds:true];
    [self.goShopping.layer setCornerRadius:5];
    [self.goShopping.layer setBorderColor:[kUIColorFromRGB(0xef5b4c) CGColor]];
    [self.goShopping.layer setBorderWidth:0.5f];
    
    [self.titleLabel setTextColor:kUIColorFromRGB(0x999999)];
    
    [_goShopping addTarget:self action:@selector(shoppingAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
}

- (void)shoppingAction:(UIButton *)sender {
    _goshop();
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}




@end
