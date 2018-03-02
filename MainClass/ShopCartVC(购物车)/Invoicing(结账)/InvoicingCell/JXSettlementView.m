//
//  JXSettlementView.m
//  JaneCargo
//
//  Created by 鹏 on 2017/7/31.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXSettlementView.h"

@interface JXSettlementView ()

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIButton *settbt;


@end


@implementation JXSettlementView


- (void)awakeFromNib {
    [super awakeFromNib];
    [_settbt setBackgroundColor:kUIColorFromRGB(0xe82b48)];
}


- (IBAction)settbtAction:(UIButton *)sender {
    
    _setblock();
}

- (void)setPriceNumber:(CGFloat)priceNumber {

    _priceLabel.text = [NSString stringWithFormat:@"合计:￥%0.2f",priceNumber];
    [JXContTextObjc changelabelColor:_priceLabel range:NSMakeRange(0, 3) color:[UIColor blackColor]];
}

- (void)setBtTitle:(NSString *)btTitle {
    [self.settbt setTitle:btTitle forState:(UIControlStateNormal)];
}



@end
