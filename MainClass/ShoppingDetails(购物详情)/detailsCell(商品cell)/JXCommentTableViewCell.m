//
//  JXCommentTableViewCell.m
//  JaneCargo
//
//  Created by cxy on 2017/6/29.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXCommentTableViewCell.h"


@interface JXCommentTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (weak, nonatomic) IBOutlet UIImageView *starImage0;
@property (weak, nonatomic) IBOutlet UIImageView *starImage1;
@property (weak, nonatomic) IBOutlet UIImageView *starImage2;
@property (weak, nonatomic) IBOutlet UIImageView *starImage3;
@property (weak, nonatomic) IBOutlet UIImageView *starImage4;

@property (weak, nonatomic) IBOutlet UIView *colorView;

@end


@implementation JXCommentTableViewCell


+ (instancetype)cellWithTable {

    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JXCommentTableViewCell class]) owner:self options:nil] lastObject];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    [_colorView setBackgroundColor:kUIColorFromRGB(0xe3e3e3)];
    [_nameLabel setTextColor:kUIColorFromRGB(0x999999)];
    
}

- (void)setModel:(JXHomepagModel *)model { //

    _model = model;
    self.nameLabel.text = model.username;
    self.contentLabel.text = model.assess_con;
    
    NSInteger startnumber = [model.assess_num integerValue];
    switch (startnumber) {
        case 1:
        {
            [self.starImage0 setImage:[UIImage imageNamed:@"评论星星_彩色"]];
        }
            break;
        case 2:
        {
            [self.starImage0 setImage:[UIImage imageNamed:@"评论星星_彩色"]];
            [self.starImage1 setImage:[UIImage imageNamed:@"评论星星_彩色"]];
        }
            break;
        case 3:
        {
            [self.starImage0 setImage:[UIImage imageNamed:@"评论星星_彩色"]];
            [self.starImage1 setImage:[UIImage imageNamed:@"评论星星_彩色"]];
            [self.starImage2 setImage:[UIImage imageNamed:@"评论星星_彩色"]];
        }
            break;
        case 4:
        {
            [self.starImage0 setImage:[UIImage imageNamed:@"评论星星_彩色"]];
            [self.starImage1 setImage:[UIImage imageNamed:@"评论星星_彩色"]];
            [self.starImage2 setImage:[UIImage imageNamed:@"评论星星_彩色"]];
            [self.starImage3 setImage:[UIImage imageNamed:@"评论星星_彩色"]];
        }
            break;
        case 5:
        {
            [self.starImage0 setImage:[UIImage imageNamed:@"评论星星_彩色"]];
            [self.starImage1 setImage:[UIImage imageNamed:@"评论星星_彩色"]];
            [self.starImage2 setImage:[UIImage imageNamed:@"评论星星_彩色"]];
            [self.starImage3 setImage:[UIImage imageNamed:@"评论星星_彩色"]];
            [self.starImage4 setImage:[UIImage imageNamed:@"评论星星_彩色"]];
        }
            break;
        default:
            break;
    }
    
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
