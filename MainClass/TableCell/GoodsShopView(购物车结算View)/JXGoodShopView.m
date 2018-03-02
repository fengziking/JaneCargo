//
//  JXGoodShopView.m
//  JaneCargo
//
//  Created by cxy on 2017/7/3.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXGoodShopView.h"

@interface JXGoodShopView ()

@property (weak, nonatomic) IBOutlet UIButton *coverDot;
@property (weak, nonatomic) IBOutlet UIButton *dot;
// 价格
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
// 结算
@property (weak, nonatomic) IBOutlet UIButton *settlementButon;
// 收藏
@property (weak, nonatomic) IBOutlet UIButton *collectionButton;
//// 运费
//@property (weak, nonatomic) IBOutlet UILabel *freightLable;


@property (weak, nonatomic) IBOutlet UIView *lineView;

@end


@implementation JXGoodShopView

- (void)awakeFromNib {
    [super awakeFromNib];
    [_settlementButon setBackgroundColor:kUIColorFromRGB(0xe82b48)];
    [_lineView setBackgroundColor:kUIColorFromRGB(0xe3e3e3)];
    [_collectionButton setBackgroundColor:kUIColorFromRGB(0xffc000)];
    [self.coverDot addTarget:self action:@selector(clickAction:) forControlEvents:(UIControlEventTouchUpInside)];
}

// 点击全选
- (void)clickAction:(UIButton *)sender {
    _dot.selected = !_dot.selected;
    _choosedot(_dot.selected);
    
}
// 收藏
- (IBAction)collectionAction:(UIButton *)sender {
    
    _setcoll(@"收藏");
}
// 结算
- (IBAction)settlementAction:(UIButton *)sender {
    
    _setcoll(@"结算");
}

- (void)setDotType:(BOOL)dotType {
    _dot.selected = dotType;
}
- (void)setSettlementPrice:(NSString *)settlementPrice {
    
    if ([settlementPrice containsString:@"-"]) {
        self.priceLabel.text = @"¥0.0";
    }else {
        [self.priceLabel setText:[NSString stringWithFormat:@"合计:%@",settlementPrice]];
    }
}

// 隐藏价格
- (void)sethiddenViewWithPrice:(BOOL)price settle:(NSString *)settle{

    [self.priceLabel setHidden:price];
    [self.settlementButon setTitle:settle forState:(UIControlStateNormal)];
}

// 隐藏收藏
- (void)sethiddenViewWithCollectionButton:(BOOL)collec {
    
    [self.collectionButton setHidden:collec];
    
}


@end
