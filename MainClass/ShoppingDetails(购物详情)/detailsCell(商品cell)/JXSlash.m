//
//  JXSlash.m
//  JaneCargo
//
//  Created by cxy on 2017/6/26.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXSlash.h"

@implementation JXSlash

- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, 1);  //线宽
    CGContextSetAllowsAntialiasing(context, true);
    CGContextSetRGBStrokeColor(context, 255.0 / 255.0, 255.0 / 255.0, 255.0 / 255.0, 1.0);  //线的颜色
    CGContextBeginPath(context);
    
    CGContextMoveToPoint(context, 28, 11);  //起点坐标
    CGContextAddLineToPoint(context, 11, 28);   //终点坐标
    // w-40-20, 200-40-20
    CGContextStrokePath(context);
}

@end
