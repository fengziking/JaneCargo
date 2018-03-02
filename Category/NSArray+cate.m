//
//  NSArray+cate.m
//  WXWorkPlatform
//
//  Created by 何飞 on 16/8/4.
//  Copyright © 2016年 zhusf. All rights reserved.
//

#import "NSArray+cate.h"

@implementation NSArray (cate)


- (id)objectAtIndexCheck:(NSUInteger)index
{
    if (index >= [self count]) {
        return nil;
    }
    
    id value = [self objectAtIndex:index];
    if (value == [NSNull null]) {
        return nil;
    }
    return value;
}


@end

