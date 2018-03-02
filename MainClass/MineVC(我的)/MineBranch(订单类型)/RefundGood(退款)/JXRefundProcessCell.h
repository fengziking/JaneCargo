//
//  JXRefundProcessCell.h
//  JaneCargo
//
//  Created by 鹏 on 2017/8/5.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JXRefundProcessCell : UITableViewCell
+ (instancetype)cellWithTable;


@property (nonatomic, strong) NSString *arowImage_str;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) CGFloat fontSize;
@property (nonatomic, strong) UIColor *linecolor;
@property (nonatomic, strong) UIColor *titlecolor;
- (void)changeLabelFontSize:(CGFloat)size sizeRange:(NSRange)sizeRange color:(UIColor *)color colorRange:(NSRange)colorRange ;
@end
