//
//  JXContTextObjc.m
//  JaneCargo
//
//  Created by 鹏 on 2017/7/26.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXContTextObjc.h"

@implementation JXContTextObjc


#pragma makr --- 正常字体
+ (void)p_SetfondLabel:(UILabel *)label fondSize:(float)fondSize {
    
    float fontSize = 0.0;
    if (iPhone4) fontSize = 4;
    if (iPhone5) fontSize = 3;
    if (iPhone6) fontSize = 1;
    [label setFont:[UIFont systemFontOfSize:fondSize-fontSize]];
}

+ (void)p_SetfondButton:(UIButton *)button fondSize:(float)fondSize {
    
    
    float fontSize = 0.0;
    if (iPhone4) fontSize = 4;
    if (iPhone5) fontSize = 3;
    if (iPhone6) fontSize = 1;
    [button.titleLabel setFont:[UIFont systemFontOfSize:fondSize-fontSize]];
}

#pragma makr --- 粗字体
+ (void)p_SetfondboldLabel:(UILabel *)label fondSize:(float)fondSize {
    

    float fontSize = 0.0;
    if (iPhone4) fontSize = 4;
    if (iPhone5) fontSize = 3;
    if (iPhone6) fontSize = 1;
    [label setFont:[UIFont fontWithName:@"Helvetica-Bold" size:fondSize-fontSize]];
}

+ (void)p_SetfondboldButton:(UIButton *)button fondSize:(float)fondSize {
    
    
    float fontSize = 0.0;
    if (iPhone4) fontSize = 4;
    if (iPhone5) fontSize = 3;
    if (iPhone6) fontSize = 1;
    [button.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:fondSize-fontSize]];
}


#pragma makr ---  改变某一个字体的大小
+ (void)changeWordSize:(UILabel *)label size:(CGFloat)size {
    
    float fontSize = 0.0;
    if (iPhone4) fontSize = 4;
    if (iPhone5) fontSize = 3;
    if (iPhone6) fontSize = 1;
    NSMutableAttributedString *content = [[NSMutableAttributedString alloc]initWithString:label.text];
    [content addAttribute:NSFontAttributeName
     
                    value:[UIFont systemFontOfSize:size-fontSize]
     
                    range:NSMakeRange(0, 1)];
    label.attributedText = content;
    
}

#pragma mark -- 改变任意位置字体的颜色
+ (void)changelabelColor:(UILabel *)label range:(NSRange)range color:(UIColor *)color{
    // NSMakeRange(0,4)
    NSMutableAttributedString *content = [[NSMutableAttributedString alloc]initWithString:label.text];
    [content addAttribute:NSForegroundColorAttributeName
     
                    value:color
     
                    range:range];
    label.attributedText = content;
}

#pragma mark -- 改变字体大小 颜色
+ (void)changeLabelFontSize:(CGFloat)size sizeRange:(NSRange)sizeRange color:(UIColor *)color colorRange:(NSRange)colorRange label:(UILabel *)label {

    NSMutableAttributedString *content = [[NSMutableAttributedString alloc]initWithString:label.text];
    [content addAttribute:NSFontAttributeName
     
                    value:[UIFont systemFontOfSize:size]
     
                    range:sizeRange];
    [content addAttribute:NSForegroundColorAttributeName
     
                    value:color
     
                    range:colorRange];
    label.attributedText = content;

}




@end
