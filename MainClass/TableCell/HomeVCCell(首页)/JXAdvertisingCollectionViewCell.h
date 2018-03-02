//
//  JXAdvertisingCollectionViewCell.h
//  JaneCargo
//
//  Created by 鹏 on 2017/8/15.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JXAdvertisingCollectionViewCell : UICollectionViewCell


@property (weak, nonatomic) IBOutlet UIScrollView *advertisingScr;
@property (nonatomic, strong) UILabel *gradientLabel;
@property (nonatomic, strong) UIView *sdleftView;
@property (nonatomic, strong) UIView *sdrightView;

@property (nonatomic, strong) JXHomepagModel *model;

@end
