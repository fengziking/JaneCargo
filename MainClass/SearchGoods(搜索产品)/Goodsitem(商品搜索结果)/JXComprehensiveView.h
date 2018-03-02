//
//  JXComprehensiveView.h
//  JaneCargo
//
//  Created by 鹏 on 2017/7/14.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^Sequencing)(NSInteger index);

@interface JXComprehensiveView : UIView

@property (nonatomic, copy) Sequencing sequen;

@end
