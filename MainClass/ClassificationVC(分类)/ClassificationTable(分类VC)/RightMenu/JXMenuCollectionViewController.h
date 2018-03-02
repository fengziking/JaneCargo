//
//  JXMenuCollectionViewController.h
//  JaneCargo
//
//  Created by cxy on 2017/6/29.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ClassifiedDelegate <NSObject>



@end


@interface JXMenuCollectionViewController : UICollectionViewController

@property (nonatomic,assign)id<ClassifiedDelegate>classifieddelegate;
// 内容
@property (nonatomic, strong) NSMutableArray *dateArray;
// 标题
@property (nonatomic, strong) NSMutableArray *lTitleArray;
@property (nonatomic, assign) NSInteger left_selectIndex;


@end
