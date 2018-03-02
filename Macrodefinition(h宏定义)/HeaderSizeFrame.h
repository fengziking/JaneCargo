//
//  HeaderSizeFrame.h
//  JaneCargo
//
//  Created by 鹏 on 2017/9/1.
//  Copyright © 2017年 鹏. All rights reserved.
//

#ifndef HeaderSizeFrame_h
#define HeaderSizeFrame_h



// 主屏幕大小
#define SCMainScreenBounds [UIScreen mainScreen].bounds

// 宽高
#define NPWidth [[UIScreen mainScreen] bounds].size.width
#define NPHeight [[UIScreen mainScreen] bounds].size.height

//设备
#define iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750,1334), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhonePlus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242,2208), [[UIScreen mainScreen] currentMode].size) : NO)
//iphone6P 放大模式
#define iPhonePlusAM ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size) : NO)

//iphone6 放大模式
#define iPhone6AM ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)



/*      记录frame      */
//  首页促销产品collection高度
#define BranchOrder_Collection_Height (NPWidth/2*16/15)









#endif /* HeaderSizeFrame_h */
