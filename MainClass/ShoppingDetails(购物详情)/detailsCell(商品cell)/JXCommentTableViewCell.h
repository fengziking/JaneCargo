//
//  JXCommentTableViewCell.h
//  JaneCargo
//
//  Created by cxy on 2017/6/29.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JXCommentTableViewCell : UITableViewCell

+(instancetype)cellWithTable;

@property (nonatomic, strong) JXHomepagModel *model;


@end
