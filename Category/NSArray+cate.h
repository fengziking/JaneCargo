//
//  NSArray+cate.h
//  WXWorkPlatform
//
//  Created by 何飞 on 16/8/4.
//  Copyright © 2016年 zhusf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (cate)
/**
 *  数组中如果小标越界返回nil
 *
 *  @param index 所取数组下标
 *
 *  @return 返回数组中下标对应的元素
 */
- (id)objectAtIndexCheck:(NSUInteger)index;

@end
