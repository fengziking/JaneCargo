//
//  JXGoodDetailedViewController.h
//  JaneCargo
//
//  Created by 鹏 on 2017/7/18.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JXGoodDetailedViewController : UIViewController
@property (nonatomic, strong) NSString *goods_id;
// 产品参数
@property (nonatomic, strong) NSArray *goodparameterArray;
@end
