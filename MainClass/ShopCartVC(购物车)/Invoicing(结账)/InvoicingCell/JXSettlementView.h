//
//  JXSettlementView.h
//  JaneCargo
//
//  Created by 鹏 on 2017/7/31.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SettlementBlock)();

@interface JXSettlementView : UIView

@property (nonatomic, copy) SettlementBlock setblock;

@property (nonatomic, assign) CGFloat priceNumber;
@property (nonatomic, strong) NSString *btTitle;

@end
