//
//  JXNetworkRequest.m
//  JaneCargo
//
//  Created by 鹏 on 2017/8/12.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^uploadCallBlock)();
typedef void(^uploadSuccess)(NSDictionary *imgDic, int idx);
typedef void(^uploadFailure)(NSError *error, int idx);

@interface UploadManager : NSObject

+ (void)uploadImagesWith:(NSArray *)images uploadFinish:(uploadCallBlock)finish success:(uploadSuccess)success failure:(uploadFailure)failure;


+ (void)commentReqWithImages:(NSArray *)imageArr
                      params:(NSMutableDictionary *)pramaDic
                     success:(void (^)(id JSON))success
                     failure:(void (^)(NSError *))failure;

@end
