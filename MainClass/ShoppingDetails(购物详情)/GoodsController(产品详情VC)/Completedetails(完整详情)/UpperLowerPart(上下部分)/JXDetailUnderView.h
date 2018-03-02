//
//  JXDetailUnderView.h
//  JaneCargo
//
//  Created by 鹏 on 2017/9/12.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JXDetailUnderView : UIViewController <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *productParameterTable;
@property (nonatomic,strong)UILabel *headLabel;
@property (nonatomic, strong) NSNumber *goodsid;
@end
