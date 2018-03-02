//
//  ShowMaskView.h
//  自定义选择器
//
//  Created by 鹏 on 16/11/21.
//  Copyright © 2016年 鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^HidenViewBlock)();

@interface ShowMaskView : UIView


@property (nonatomic, copy) HidenViewBlock hidenMask;
+ (instancetype)showMaskViewWith:(HidenViewBlock)hiden;

@end
