//
//  ShoppingView.m
//  DemoShopping
//
//  Created by cxy on 2017/6/29.
//  Copyright © 2017年 cxy. All rights reserved.
//

#import "ShoppingView.h"


@interface ShoppingView ()

@property (weak, nonatomic) IBOutlet UIImageView *storeImage;
@property (weak, nonatomic) IBOutlet UILabel *storeLabel;
@property (weak, nonatomic) IBOutlet UIButton *storeButton;

@property (weak, nonatomic) IBOutlet UIImageView *shopImage;
@property (weak, nonatomic) IBOutlet UILabel *shopNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *shopLabel;
@property (weak, nonatomic) IBOutlet UIButton *shopButton;



@property (weak, nonatomic) IBOutlet UIButton *shopCartButton;

@property (weak, nonatomic) IBOutlet UIView *linef;
@property (weak, nonatomic) IBOutlet UIView *lines;
@property (weak, nonatomic) IBOutlet UIView *linet;
@property (weak, nonatomic) IBOutlet UIView *fourline;
@property (weak, nonatomic) IBOutlet UIView *fiveline;

@end

@implementation ShoppingView



- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.linef setBackgroundColor:kUIColorFromRGB(0xCCCCCC)];
    [self.lines setBackgroundColor:kUIColorFromRGB(0xCCCCCC)];
    [self.linet setBackgroundColor:kUIColorFromRGB(0xCCCCCC)];
    [self.fourline setBackgroundColor:kUIColorFromRGB(0xCCCCCC)];
    [self.fiveline setBackgroundColor:kUIColorFromRGB(0xCCCCCC)];
    [self.shopCartButton setBackgroundColor:kUIColorFromRGB(0xe82b48)];
    [self.shopNumberLabel.layer setMasksToBounds:true];
    [self.shopNumberLabel.layer setCornerRadius:self.shopNumberLabel.frame.size.height/2];
    
    [self.storeButton addTarget:self action:@selector(storeAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.shopButton addTarget:self action:@selector(shopAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.focusButton addTarget:self action:@selector(focusAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.shopCartButton addTarget:self action:@selector(shopCartAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
}


- (void)setNumber:(NSString *)number {

    if ([number isEqualToString:@"0"]) {
        
        return;
    }
    self.shopNumberLabel.text = [NSString stringWithFormat:@" %@ ",number];
}


- (void)storeAction:(UIButton *)sender {

    
    _buyCart(sender.tag,sender.selected);
}
- (void)shopAction:(UIButton *)sender {
    
    
    _buyCart(sender.tag,sender.selected);
}
- (void)focusAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    _buyCart(sender.tag,sender.selected);
    
//    if ([_attentiondelegate respondsToSelector:@selector(attentiongoods:)]) {
//        [_attentiondelegate attentiongoods:sender.selected];
//    }
    
}
- (void)shopCartAction:(UIButton *)sender {
    
    
    _buyCart(sender.tag,sender.selected);
}

- (IBAction)qqAction:(UIButton *)sender {
    
    _QQcontactblock();
}





@end
