//
//  JXFourBtCollectionViewCell.m
//  JaneCargo
//
//  Created by 鹏 on 2017/8/15.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXFourBtCollectionViewCell.h"

@interface JXFourBtCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end


@implementation JXFourBtCollectionViewCell




- (void)awakeFromNib {
    [super awakeFromNib];
    [self setBackgroundColor:[UIColor whiteColor]];
    [_nameLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:12.0f]];
}


- (void)setImageIcon:(NSString *)icon title:(NSString *)title {

    _iconImage.image = [UIImage imageNamed:icon];
    _nameLabel.text = title;
}


@end
