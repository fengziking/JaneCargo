//
//  JXGoodsdetailViewController.h
//  JaneCargo
//
//  Created by cxy on 2017/6/30.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MKGoodsModel;
@protocol XWPresentedOneControllerDelegate <NSObject>

- (void)presentedOneControllerPressedDissmiss;
- (id<UIViewControllerInteractiveTransitioning>)interactiveTransitionForPresent;
// 修改规格
- (void)refreshGoodCart;
// 加入购物车
- (void)returnGoods_number:(NSInteger)number;

@end

@interface JXGoodsdetailViewController : UIViewController

@property (nonatomic, assign) id<XWPresentedOneControllerDelegate> delegate;

// 产品信息
@property (nonatomic, strong) NSArray *goodsInformationArray;
// 产品规格
@property (nonatomic, strong) NSArray *goodsspecificationsArray;


//   1----- 加入购物车  2 ------ 购物车里面选择规格
@property (nonatomic, assign) NSInteger seleType;
@property (nonatomic, strong) MKGoodsModel *mkMode;

@end
