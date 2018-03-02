//
//  JXSearchResultsViewController.h
//  JaneCargo
//
//  Created by 鹏 on 2017/8/23.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol Orderpaydelegate <NSObject>

- (void)orderpaysuccess;

@end

@interface JXSearchResultsViewController : UIViewController

@property (nonatomic, strong) NSString *orederStr;
@property (nonatomic, assign)id<Orderpaydelegate>orderpaydelegte;


@end
