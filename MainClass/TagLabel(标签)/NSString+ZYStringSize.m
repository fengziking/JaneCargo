//
//  NSString+ZYStringSize.m
//  可以自动调整列数的CollectionView
//
//  Created by tarena on 16/7/3.
//  Copyright © 2016年 张永强. All rights reserved.
//

#import "NSString+ZYStringSize.h"

@implementation NSString (ZYStringSize)
- (CGSize)xhl_stringSizeWithFount:(UIFont *)font maxWidth:(CGFloat)maxWidth maxHeight:(CGFloat)maxHeight {
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    CGSize maxSize = CGSizeMake(maxWidth, maxHeight);
    attributes[NSFontAttributeName] = font;
    return [self boundingRectWithSize:maxSize options:NSStringDrawingTruncatesLastVisibleLine |NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:attributes context:nil].size;
}
- (CGSize)xhl_stringSizeWithFont:(UIFont *)font maxWidth:(CGFloat)maxWidth {
    return [self xhl_stringSizeWithFount:font maxWidth:maxWidth maxHeight:MAXFLOAT];
}
- (CGSize)xhl_stringSizeWithFont:(UIFont *)font {
    return [self xhl_stringSizeWithFont:font maxWidth:MAXFLOAT];
}

@end
