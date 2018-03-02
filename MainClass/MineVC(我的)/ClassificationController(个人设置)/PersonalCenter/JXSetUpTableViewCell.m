//
//  JXSetUpTableViewCell.m
//  JaneCargo
//
//  Created by cxy on 2017/7/5.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXSetUpTableViewCell.h"

@interface JXSetUpTableViewCell ()

@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIView *BigbackView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *backViewHeight;

@end

@implementation JXSetUpTableViewCell

+ (instancetype)cellWithTable {

    return [[[NSBundle mainBundle] loadNibNamed:@"JXSetUpTableViewCell" owner:self options:nil] lastObject];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.backView.layer setMasksToBounds:true];
    [self.backView.layer setCornerRadius:self.BigbackView.frame.size.width/2];
    [self.backView setBackgroundColor:kUIColorFromRGB(0xffffff)];
    [self.backView setAlpha:0.4];
    [self.backView.layer setMasksToBounds:true];
    [self.backView.layer setCornerRadius:self.backView.frame.size.height/2];
    
    [self.iconImage.layer setMasksToBounds:true];
    [self.iconImage.layer setCornerRadius:self.iconImage.frame.size.height/2];
    
    [JXEncapSulationObjc addGradientColorView:_BigbackView cgrectMake:CGRectMake(0, 0, NPWidth, 140) colors:@[(id)kUIColorFromRGB(0xef5b4c).CGColor, (id)kUIColorFromRGB(0xe82b48).CGColor,(id)kUIColorFromRGB(0xe82b48).CGColor]];
    NSDictionary *user = [JXUserDefaultsObjc loginUserInfo];
    
    if (!kDictIsEmpty(user)) {
        [self.nameLabel setText:user[@"username"]];
        [self.iconImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",iconImage_Url,user[@"tximg"]]] placeholderImage:[UIImage imageNamed:@"icon_默认头像"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
        }];
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
