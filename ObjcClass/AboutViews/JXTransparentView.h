//
//  JXTransparentView.h
//  JaneCargo
//
//  Created by 鹏 on 2017/8/25.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^HidenViewBlock)();
@interface JXTransparentView : UIView
@property (nonatomic, copy) HidenViewBlock hidenMask;
+ (instancetype)showMaskViewWith:(HidenViewBlock)hiden;
@end
