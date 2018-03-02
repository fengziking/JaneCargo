//
//  EvaluationSubmitCell.h
//  Evaluation
//
//  Created by 鹏 on 2017/9/14.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SubmitEvaluationDelegate <NSObject>

- (void)submit;

@end

@interface EvaluationSubmitCell : UITableViewCell
+ (instancetype)cellWithTable ;
@property (nonatomic, weak)id<SubmitEvaluationDelegate>subitdelegate;
@end
