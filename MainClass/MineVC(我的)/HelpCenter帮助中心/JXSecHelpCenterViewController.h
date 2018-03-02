//
//  JXSecHelpCenterViewController.h
//  JaneCargo
//
//  Created by 鹏 on 2017/10/16.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RefreshWebdelegate <NSObject>

- (void)refreshWeb;

@end

@interface JXSecHelpCenterViewController : UIViewController
@property (nonatomic, strong) NSString *weburl;
@property (nonatomic, assign)id<RefreshWebdelegate>refweb;
@end
