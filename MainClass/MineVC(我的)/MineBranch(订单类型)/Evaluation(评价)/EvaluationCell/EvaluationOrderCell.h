//
//  EvaluationOrderCell.h
//  Evaluation
//
//  Created by 鹏 on 2017/9/14.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EvaluationOrderCell : UITableViewCell
+ (instancetype)cellWithTable;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) MKOrderListModel *model;
@end
