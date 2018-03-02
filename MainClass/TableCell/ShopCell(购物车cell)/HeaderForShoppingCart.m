//
//  HeaderForShoppingCart.m
//  ShoppingCart
//
//  Created by 鹏 on 2017/7/11.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "HeaderForShoppingCart.h"

@implementation HeaderForShoppingCart


- (instancetype)init
{
    self = [super init];
    if (self) {
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 10)];
        [view setBackgroundColor:kUIColorFromRGB(0xf2f2f2)];
        [self addSubview:view];
        
        CGRect btnFrame = CGRectMake(15, 20, 19, 19);
        _headerBtn = [[UIButton alloc] initWithFrame:btnFrame];
        [_headerBtn setImage:[UIImage imageNamed:@"icon_支付方式_未选择"] forState:UIControlStateNormal];
        [_headerBtn setImage:[UIImage imageNamed:@"icon_选中"] forState:UIControlStateSelected];
        [_headerBtn addTarget:self action:@selector(headerBtnClick::) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_headerBtn];
        
        UIButton * bigSelectedBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 10, 40, 40)];
        bigSelectedBtn.center = _headerBtn.center;
        [self addSubview:bigSelectedBtn];
        [bigSelectedBtn addTarget:self action:@selector(headerBtnClick::) forControlEvents:UIControlEventTouchUpInside];
        
        
        UIButton *storebt = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(bigSelectedBtn.frame), 10, [[UIScreen mainScreen] bounds].size.width-40, 40)];
        [self addSubview:storebt];
        [storebt addTarget:self action:@selector(storebtClick:) forControlEvents:UIControlEventTouchUpInside];
        
        _storeImage = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_headerBtn.frame)+12, 16.5, 27, 27)];
        [_storeImage setImage:[UIImage imageNamed:@"icon_店铺"]];
        [self addSubview:_storeImage];
        _sectionLabel = [[UILabel alloc] init];
        _sectionLabel.frame = CGRectMake(CGRectGetMaxX(_storeImage.frame)+12, 23, 300, 14);
        [_sectionLabel setFont:[UIFont systemFontOfSize:14.0f]];
        [self addSubview:_sectionLabel];
        
        
        _arrowImage = [[UIImageView alloc] initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width-15-8, 23, 8, 14)];
        [_arrowImage setImage:[UIImage imageNamed:@"icon_详细"]];
        [self addSubview:_arrowImage];
        
        
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)storebtClick:(UIButton *)sender {

    if ([self.headerDelegate respondsToSelector:@selector(headerSelectedBtnClick:)]) {
        [self.headerDelegate storeSelectedBtnClick:self.tag];
    }
}

// 组头的点击事件
- (void)headerBtnClick: (UIButton*)HeaderBtn :(NSInteger)section{
    HeaderBtn.selected = !HeaderBtn.selected;
    if ([self.headerDelegate respondsToSelector:@selector(headerSelectedBtnClick:)]) {
        [self.headerDelegate headerSelectedBtnClick:self.tag];
    }
}

- (void)setOrderListModel:(MKOrderListModel *)orderListModel {
    _orderListModel = orderListModel;
    _sectionLabel.text = _orderListModel.nickname;
    _headerBtn.selected = orderListModel.groupSelected;
}




@end
