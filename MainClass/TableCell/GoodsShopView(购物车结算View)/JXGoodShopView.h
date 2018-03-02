//
//  JXGoodShopView.h
//  JaneCargo
//
//  Created by cxy on 2017/7/3.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^IsSelect)(BOOL choose);
typedef void(^Setcoll)(NSString *typeString);


@interface JXGoodShopView : UIView


- (void)sethiddenViewWithPrice:(BOOL)price settle:(NSString *)settle;
- (void)sethiddenViewWithCollectionButton:(BOOL)collec;

@property (nonatomic, assign) BOOL dotType;
@property (nonatomic, copy) IsSelect choosedot;
@property (nonatomic, strong) NSString *settlementPrice;
@property (nonatomic, strong) Setcoll setcoll;

@end
