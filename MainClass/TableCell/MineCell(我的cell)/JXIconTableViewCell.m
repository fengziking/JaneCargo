//
//  JXIconTableViewCell.m
//  JaneCargo
//
//  Created by cxy on 2017/7/5.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXIconTableViewCell.h"


@interface JXIconTableViewCell ()

@property (weak, nonatomic) IBOutlet UIView *backView;

@property (weak, nonatomic) IBOutlet UIImageView *iconImage;

@property (weak, nonatomic) IBOutlet UIView *imageViewaphl;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UIButton *iconButton;


@end

@implementation JXIconTableViewCell



+ (instancetype)cellWithtable {

    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JXIconTableViewCell class]) owner:self options:nil] lastObject];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.nameLabel setTextColor:[UIColor whiteColor]];
    [self addGradientColorView:self.backView];
    [self.imageViewaphl.layer setMasksToBounds:true];
    [self.imageViewaphl.layer setCornerRadius:self.imageViewaphl.frame.size.width/2];
    [self.imageViewaphl setBackgroundColor:kUIColorFromRGB(0xffffff)];
    [self.imageViewaphl setAlpha:0.4];
    [self.iconButton addTarget:self action:@selector(iconAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self.iconImage.layer setMasksToBounds:true];
    [self.iconImage.layer setCornerRadius:self.iconImage.frame.size.width/2];

    
    
    
    NSDictionary *user = [JXUserDefaultsObjc loginUserInfo];
    if (!kDictIsEmpty(user)) {
        [self.nameLabel setText:user[@"username"]];
        [self.iconImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",iconImage_Url,user[@"tximg"]]] placeholderImage:[UIImage imageNamed:@"icon_默认头像"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
        }];
    }
    
}


- (UIImage *)nstringforbase:(NSString *)encodedImageStr {
    
    NSData *decodedImageData = [[NSData alloc]
                                
                                initWithBase64EncodedString:encodedImageStr options:NSDataBase64DecodingIgnoreUnknownCharacters];
    
    UIImage *decodedImage = [UIImage imageWithData:decodedImageData];
    
    return decodedImage;
}

    // 点击头像上传相片
- (void)iconAction:(UIButton *)sender {

    _login();

}


- (void)addGradientColorView:(UIView *)view
{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)kUIColorFromRGB(0xef5b4c).CGColor, (__bridge id)kUIColorFromRGB(0xe82b48).CGColor];
    gradientLayer.locations = @[@0, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 0);
    gradientLayer.frame = CGRectMake(0, 0, NPWidth, 194);
    [view.layer addSublayer:gradientLayer];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
