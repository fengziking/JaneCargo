//
//  NSString+ZYStringSize.h
//  可以自动调整列数的CollectionView
//
//  Created by tarena on 16/7/3.
//  Copyright © 2016年 张永强. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

@interface NSString (ZYStringSize)

- (CGSize)xhl_stringSizeWithFount:(UIFont *)font maxWidth:(CGFloat)maxWidth maxHeight:(CGFloat)maxHeight;
- (CGSize)xhl_stringSizeWithFont:(UIFont *)font maxWidth:(CGFloat)maxWidth;
- (CGSize)xhl_stringSizeWithFont:(UIFont *)font;



@end
