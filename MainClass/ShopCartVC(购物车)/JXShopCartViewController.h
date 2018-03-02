//
//  JXShopCartViewController.h
//  JaneCargo
//
//  Created by 鹏 on 17/6/23.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol Shopdetailsdelegate <NSObject>

- (void)shopdetailsdegatereload;

@end


@interface JXShopCartViewController : UIViewController

// 区分主次页面
@property (nonatomic, strong) NSString *typeNavigate;

@property (nonatomic, assign)id<Shopdetailsdelegate>shopdetaildelegate;

@end
