//
//  JXPhotoViewController.h
//  JaneCargo
//
//  Created by cxy on 2017/7/6.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JXPhotoViewController;
@protocol MessagesDelegate <NSObject>

- (void)returnMessage:(JXPhotoViewController *)gender content:(NSString *)content type:(NSInteger)type;

@end


@interface JXPhotoViewController : UIViewController

@property (nonatomic, strong) NSString *navigationTitle;
@property (nonatomic, assign)id<MessagesDelegate>messagedelegate;
@property (nonatomic, strong) NSString *qq_str;
@end
