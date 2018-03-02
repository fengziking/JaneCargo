//
//  JXAskQuestionsViewController.h
//  JaneCargo
//
//  Created by 鹏 on 2017/8/9.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AsquestionDelegate <NSObject>

- (void)reloaddate;

@end

@interface JXAskQuestionsViewController : UIViewController

@property (nonatomic, assign)id<AsquestionDelegate>asquestdelegate;
@end
