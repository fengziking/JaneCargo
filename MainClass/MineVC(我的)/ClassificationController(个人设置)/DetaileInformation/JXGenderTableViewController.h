//
//  JXGenderTableViewController.h
//  JaneCargo
//
//  Created by cxy on 2017/7/6.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JXGenderTableViewController;
@protocol GenderDelegate <NSObject>

- (void)returnGender:(JXGenderTableViewController *)gender sex:(NSInteger)sex;

@end
@interface JXGenderTableViewController : UITableViewController
@property (nonatomic, assign)id<GenderDelegate>genderdelegate;
@property (nonatomic, assign) NSInteger sexNum;

@end
