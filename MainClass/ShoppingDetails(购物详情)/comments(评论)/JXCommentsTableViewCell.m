//
//  JXCommentsTableViewCell.m
//  JaneCargo
//
//  Created by 鹏 on 2017/7/18.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXCommentsTableViewCell.h"

@interface JXCommentsTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImage;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *startImage0;
@property (weak, nonatomic) IBOutlet UIImageView *startImage1;
@property (weak, nonatomic) IBOutlet UIImageView *startImage2;
@property (weak, nonatomic) IBOutlet UIImageView *startImage3;
@property (weak, nonatomic) IBOutlet UIImageView *startImage4;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (weak, nonatomic) IBOutlet UIView *colorView;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation JXCommentsTableViewCell


+ (instancetype)cellWithTable {
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JXCommentsTableViewCell class]) owner:self options:nil] lastObject];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    [_colorView setBackgroundColor:kUIColorFromRGB(0xe3e3e3)];
    [_timeLabel setTextColor:kUIColorFromRGB(0x999999)];
    [_nameLabel setTextColor:kUIColorFromRGB(0x999999)];
    [self.iconImage.layer setMasksToBounds:true];
    [self.iconImage.layer setCornerRadius:self.iconImage.frame.size.height/2];
    
}


- (void)setModel:(JXHomepagModel *)model {
    
    _model = model;
    self.nameLabel.text = model.username;
    self.contentLabel.text = model.assess_con;
    self.timeLabel.text = model.create_time;
    UIImage *cacheImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:[NSString stringWithFormat:@"%@%@",iconImage_Url,model.tximg]];
    [self.iconImage setImage:cacheImage];
    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",iconImage_Url,model.tximg]] placeholderImage:[UIImage imageNamed:@"img_图片加载_小"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
    }];
    
    NSInteger startnumber = [model.assess_num integerValue];
    switch (startnumber) { //
        case 1:
        {
            [self.startImage0 setImage:[UIImage imageNamed:@"评论星星_彩色"]];
            [self.startImage1 setImage:[UIImage imageNamed:@"评论星星_灰色"]];
            [self.startImage2 setImage:[UIImage imageNamed:@"评论星星_灰色"]];
            [self.startImage3 setImage:[UIImage imageNamed:@"评论星星_灰色"]];
            [self.startImage4 setImage:[UIImage imageNamed:@"评论星星_灰色"]];
        }
            break;
        case 2:
        {
            [self.startImage0 setImage:[UIImage imageNamed:@"评论星星_彩色"]];
            [self.startImage1 setImage:[UIImage imageNamed:@"评论星星_彩色"]];
            [self.startImage2 setImage:[UIImage imageNamed:@"评论星星_灰色"]];
            [self.startImage3 setImage:[UIImage imageNamed:@"评论星星_灰色"]];
            [self.startImage4 setImage:[UIImage imageNamed:@"评论星星_灰色"]];
        }
            break;
        case 3:
        {
            [self.startImage0 setImage:[UIImage imageNamed:@"评论星星_彩色"]];
            [self.startImage1 setImage:[UIImage imageNamed:@"评论星星_彩色"]];
            [self.startImage2 setImage:[UIImage imageNamed:@"评论星星_彩色"]];
            [self.startImage3 setImage:[UIImage imageNamed:@"评论星星_灰色"]];
            [self.startImage4 setImage:[UIImage imageNamed:@"评论星星_灰色"]];
        }
            break;
        case 4:
        {
            [self.startImage0 setImage:[UIImage imageNamed:@"评论星星_彩色"]];
            [self.startImage1 setImage:[UIImage imageNamed:@"评论星星_彩色"]];
            [self.startImage2 setImage:[UIImage imageNamed:@"评论星星_彩色"]];
            [self.startImage3 setImage:[UIImage imageNamed:@"评论星星_彩色"]];
            [self.startImage4 setImage:[UIImage imageNamed:@"评论星星_灰色"]];
        }
            break;
        case 5:
        {
            [self.startImage0 setImage:[UIImage imageNamed:@"评论星星_彩色"]];
            [self.startImage1 setImage:[UIImage imageNamed:@"评论星星_彩色"]];
            [self.startImage2 setImage:[UIImage imageNamed:@"评论星星_彩色"]];
            [self.startImage3 setImage:[UIImage imageNamed:@"评论星星_彩色"]];
            [self.startImage4 setImage:[UIImage imageNamed:@"评论星星_彩色"]];
        }
            break;
        default:
            break;
    }
    [self layoutIfNeeded];
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
