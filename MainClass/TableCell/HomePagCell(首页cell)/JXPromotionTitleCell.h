//
//  JXPromotionTitleCell.h
//  JaneCargo
//
//  Created by cxy on 2017/6/28.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JXPromotionTitleCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *titleImage;

+ (instancetype)cellWithTable;

@property (nonatomic, strong) UILabel *gradientLabel;
@property (nonatomic, strong) UIView *sdleftView;
@property (nonatomic, strong) UIView *sdrightView;


@end
