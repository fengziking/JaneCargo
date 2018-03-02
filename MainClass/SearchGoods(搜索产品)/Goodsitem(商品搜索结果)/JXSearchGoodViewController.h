//
//  JXSearchGoodViewController.h
//  JaneCargo
//
//  Created by 鹏 on 2017/7/13.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger, WBStatusCardType) {
    WBStatusNewGood = 0, ///< 新品 0
    WBStatusHotCakes,    ///< 热销 1
    WBStatusSearch,      ///< 搜索 2
     WBStatusMore,       ///< 更多 3
};



@interface JXSearchGoodViewController : UIViewController

@property (nonatomic, strong) NSMutableArray *dateArray;

@property (nonatomic, strong) NSString *is_NewProduct;
// 搜索id
@property (nonatomic, strong) NSString *goods_id;
// 搜索关键词
@property (nonatomic, strong) NSString *searchStr;
@property (nonatomic, assign) WBStatusCardType retweetType;

@end
