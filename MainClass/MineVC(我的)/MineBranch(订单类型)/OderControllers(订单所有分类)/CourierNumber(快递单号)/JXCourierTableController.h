//
//  JXCourierTableController.h
//  JaneCargo
//
//  Created by 鹏 on 2017/10/25.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CourierDelegate <NSObject>

- (void)courier:(NSString *)courier coureName:(NSString *)name;

@end

@interface JXCourierTableController : UIViewController
@property (nonatomic, strong) NSArray *dateArray;

@property (nonatomic, assign)id<CourierDelegate>courierdelegate;

@end
