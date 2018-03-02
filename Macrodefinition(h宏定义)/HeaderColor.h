//
//  HeaderColor.h
//  JaneCargo
//
//  Created by 鹏 on 2017/9/1.
//  Copyright © 2017年 鹏. All rights reserved.
//

#ifndef HeaderColor_h
#define HeaderColor_h


// 颜色
#define kUIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


#define DCBGColor RGB(245,245,245)

#define PFR [[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0 ? @"PingFangSC-Regular" : @"PingFang SC"

#define PFR20Font [UIFont fontWithName:PFR size:20];
#define PFR18Font [UIFont fontWithName:PFR size:18];
#define PFR16Font [UIFont fontWithName:PFR size:16];
#define PFR15Font [UIFont fontWithName:PFR size:15];
#define PFR14Font [UIFont fontWithName:PFR size:14];
#define PFR13Font [UIFont fontWithName:PFR size:13];
#define PFR12Font [UIFont fontWithName:PFR size:12];
#define PFR11Font [UIFont fontWithName:PFR size:11];
#define PFR10Font [UIFont fontWithName:PFR size:10];


// 线条
#define JX_Linecolor kUIColorFromRGB(0xcccccc)
// 灰色背景
#define JX_Backcolor kUIColorFromRGB(0xf2f2f2)
// 红色
#define JX_Redcolor kUIColorFromRGB(0xff5335)


#endif /* HeaderColor_h */
