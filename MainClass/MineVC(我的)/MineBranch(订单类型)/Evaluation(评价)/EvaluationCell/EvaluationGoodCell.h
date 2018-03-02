//
//  EvaluationGoodCell.h
//  Evaluation
//
//  Created by 鹏 on 2017/9/14.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EvaluationGoodCell : UITableViewCell
+ (instancetype)cellWithTable;
@property (nonatomic, strong) MKGoodsModel *model;
@end
