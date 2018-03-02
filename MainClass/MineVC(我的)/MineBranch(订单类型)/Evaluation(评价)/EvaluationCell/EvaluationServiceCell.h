//
//  EvaluationServiceCell.h
//  Evaluation
//
//  Created by 鹏 on 2017/9/14.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EvaluationServiceCell : UITableViewCell

+ (instancetype)cellWithTable;
@property (nonatomic,copy) void(^EvaluationStrat)(NSInteger startNumber,MKGoodsModel *model);
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) MKGoodsModel *model;
- (void)changestratType:(NSInteger)type ;
@end
