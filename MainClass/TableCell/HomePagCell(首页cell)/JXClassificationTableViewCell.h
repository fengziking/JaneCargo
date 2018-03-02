//
//  JXClassificationTableViewCell.h
//  JaneCargo
//
//  Created by cxy on 2017/6/23.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JXHomepagModel;

typedef void(^Classification)(NSInteger typebutton);


@interface JXClassificationTableViewCell : UITableViewCell 


@property (nonatomic, strong) JXHomepagModel *model;
@property (nonatomic, copy) Classification ification;


@end
