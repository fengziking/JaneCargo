//
//  JXFicationLeftView.h
//  JaneCargo
//
//  Created by 鹏 on 2017/8/18.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JXFicationLeftView : UIView

- (void)setupTitle:(NSArray *)titleArrays selectIndex:(NSInteger)selectIndex;
@property (nonatomic, copy) void(^LeftTitleblock)(NSInteger index);



@end
