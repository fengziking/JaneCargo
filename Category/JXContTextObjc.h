//
//  JXContTextObjc.h
//  JaneCargo
//
//  Created by 鹏 on 2017/7/26.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JXContTextObjc : NSObject

#pragma makr --- 正常字体
+ (void)p_SetfondLabel:(UILabel *)label fondSize:(float)fondSize;
+ (void)p_SetfondButton:(UIButton *)button fondSize:(float)fondSize;
#pragma makr --- 粗字体
+ (void)p_SetfondboldLabel:(UILabel *)label fondSize:(float)fondSize;
+ (void)p_SetfondboldButton:(UIButton *)button fondSize:(float)fondSize;
#pragma makr ---  改变某一个字体的大小
+ (void)changeWordSize:(UILabel *)label size:(CGFloat)size;
+ (void)changelabelColor:(UILabel *)label range:(NSRange)range color:(UIColor *)color;
#pragma makr ---  改变字体大小 颜色
+ (void)changeLabelFontSize:(CGFloat)size sizeRange:(NSRange)sizeRange color:(UIColor *)color colorRange:(NSRange)colorRange label:(UILabel *)label ;
@end
