//
//  Listener.h
//  IMCHUMO
//
//  Created by xy2 on 16/9/19.
//  Copyright © 2016年 xy2. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"
@interface Listener : NSObject
// 开启监听网络
+ (void)listening;
// 当前网络状态
+ (BOOL )isNetAvialible;
@end
