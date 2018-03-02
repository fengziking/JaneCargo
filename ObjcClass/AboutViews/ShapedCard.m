//
//  ShapedCard.m
//  Gensheiyou1
//
//  Created by 穆相臣 on 15/8/21.
//  Copyright (c) 2015年 Mo's tec. All rights reserved.
//

#import "ShapedCard.h"

#define ALLHEIGHT 70
#define ARCHEIGHT 30
#define ARCSHEIGHT 20

@implementation ShapedCard

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:CGRectMake(0, 207-(ALLHEIGHT - ARCHEIGHT), NPWidth, ALLHEIGHT - ARCHEIGHT)])
    {
        self.backgroundColor = [UIColor clearColor];
        [self setNeedsDisplay];
        
    }
    return self;
}

-(void)drawRect:(CGRect)rect
{

    CGFloat startPosition = 100;  // 起始点绝对值
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(context, 1, 1, 1, 1);//改变画笔颜色
    CGContextSetLineWidth(context, 100.0);//线的宽度
    CGContextMoveToPoint(context, -startPosition, ARCSHEIGHT);
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextAddCurveToPoint(context, (NPWidth/4-startPosition/2), 110, (3*NPWidth/4 + startPosition/2), 110, NPWidth+startPosition, ARCSHEIGHT);
    CGContextStrokePath(context);//绘画路径
    
    CGRect rect1 = CGRectMake(0, 100, NPWidth, ALLHEIGHT - ARCHEIGHT - ARCSHEIGHT);
    CGContextAddRect(context, rect1);
    CGContextFillRect(context, rect1);
    CGContextStrokePath(context);

}




@end
