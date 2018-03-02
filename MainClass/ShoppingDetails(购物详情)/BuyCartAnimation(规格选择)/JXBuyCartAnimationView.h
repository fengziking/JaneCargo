//
//  JXBuyCartAnimationView.h
//  JaneCargo
//
//  Created by cxy on 2017/6/30.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JXHomepagModel;
@class MKGoodsModel;

typedef void(^CloseAnimation)();
typedef void(^NumberIncrease)(NSInteger type);
typedef void(^JoinShopcart)();

@interface JXBuyCartAnimationView : UIView


@property (nonatomic, copy) CloseAnimation close;
@property (nonatomic, copy) JoinShopcart joinShop;


@property (weak, nonatomic) IBOutlet UIImageView *goodsImage;
@property (weak, nonatomic) IBOutlet UILabel *goodName;
@property (weak, nonatomic) IBOutlet UILabel *goodprice;
@property (weak, nonatomic) IBOutlet UIButton *closeButton;

// 加入购物车
@property (weak, nonatomic) IBOutlet UIButton *joinbt;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UILabel *discountlabel;
@property (weak, nonatomic) IBOutlet UIView *discountline;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *backViewHeight;
@property (weak, nonatomic) IBOutlet UIView *backView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomheight;


@property (nonatomic, strong) JXHomepagModel *model;

@property (nonatomic, strong) MKGoodsModel *mkmodel;

@end
