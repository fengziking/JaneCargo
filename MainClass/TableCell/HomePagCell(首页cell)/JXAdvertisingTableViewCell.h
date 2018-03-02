//
//  JXAdvertisingTableViewCell.h
//  JaneCargo
//
//  Created by cxy on 2017/6/28.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JXHomepagModel;
@interface JXAdvertisingTableViewCell : UITableViewCell

+ (instancetype)cellwithTable;
@property (weak, nonatomic) IBOutlet UIScrollView *sdScrollView;


@property (nonatomic, strong) UIScrollView *sd_ScrollView;
@property (nonatomic, strong) UILabel *gradientLabel;
@property (nonatomic, strong) UIView *sdleftView;
@property (nonatomic, strong) UIView *sdrightView;

@property (nonatomic, strong) JXHomepagModel *model;

@end
