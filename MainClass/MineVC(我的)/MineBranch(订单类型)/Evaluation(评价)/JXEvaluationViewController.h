//
//  JXEvaluationViewController.h
//  Evaluation
//
//  Created by 鹏 on 2017/9/14.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EvaluationGoodDelegate <NSObject>

- (void)evaluationGoodStart;

@end

@interface JXEvaluationViewController : UIViewController


@property (nonatomic, assign) id<EvaluationGoodDelegate>evaluatdelegate;
@property (nonatomic, strong) MKOrderListModel *model;
@property (nonatomic, strong) NSArray *datasArray;

@end
