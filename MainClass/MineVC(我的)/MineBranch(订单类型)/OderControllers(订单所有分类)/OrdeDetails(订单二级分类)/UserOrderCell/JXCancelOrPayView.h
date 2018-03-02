//
//  JXCancelOrPayView.h
//  JaneCargo
//
//  Created by 鹏 on 2017/7/10.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UserOrderClickDelegate <NSObject>

- (void)infrontbt:(NSString*)str;

@end

@interface JXCancelOrPayView : UIView

@property (weak, nonatomic) IBOutlet UIButton *ordercancelbt;
@property (weak, nonatomic) IBOutlet UIButton *orderpaybt;
@property (nonatomic, assign)id<UserOrderClickDelegate>userorderdelegate;

@end
