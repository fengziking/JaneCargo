//
//  JXHomepagModel.m
//  JaneCargo
//
//  Created by cxy on 2017/6/23.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXHomepagModel.h"

@implementation JXHomepagModel

+ (instancetype)jxStratdic:(NSDictionary *)dic {
    
    JXHomepagModel *model = [[JXHomepagModel alloc] init];
    [model setValuesForKeysWithDictionary:dic];
    return model;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {

}
-(id)valueForUndefinedKey:(NSString *)key {
    return nil;
}

@end
