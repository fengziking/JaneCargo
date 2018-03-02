//
//  JXCategoryCollectionViewCell.m
//  JaneCargo
//
//  Created by 鹏 on 2017/8/15.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXCategoryCollectionViewCell.h"

@interface JXCategoryCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIView *backView;

@property (weak, nonatomic) IBOutlet UIImageView *firstImage;
@property (weak, nonatomic) IBOutlet UIImageView *secondImage;
@property (weak, nonatomic) IBOutlet UIImageView *thirtImage;
@property (weak, nonatomic) IBOutlet UIImageView *fourImage;
@property (weak, nonatomic) IBOutlet UIImageView *fiveImage;

@property (weak, nonatomic) IBOutlet UILabel *firstTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *thirtTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *fourTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *fiveTitleLabel;

@property (weak, nonatomic) IBOutlet UILabel *firstprice;
@property (weak, nonatomic) IBOutlet UILabel *secondprice;
@property (weak, nonatomic) IBOutlet UILabel *thirtprice;
@property (weak, nonatomic) IBOutlet UILabel *fourprice;
@property (weak, nonatomic) IBOutlet UILabel *fiveprice;

@property (weak, nonatomic) IBOutlet UIView *fline;
@property (weak, nonatomic) IBOutlet UIView *secondline;
@property (weak, nonatomic) IBOutlet UIView *thirtline;
@property (weak, nonatomic) IBOutlet UIView *fourline;
@property (weak, nonatomic) IBOutlet UIView *fiveline;

@property (weak, nonatomic) IBOutlet UIView *fcolorView;
@property (weak, nonatomic) IBOutlet UIView *scolorView;

@property (weak, nonatomic) IBOutlet UILabel *moreLabel;
@property (weak, nonatomic) IBOutlet UIImageView *moreImage;



@end


@implementation JXCategoryCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.backView.layer setMasksToBounds:true];
    [self.backView.layer setCornerRadius:5.0];
    [self.fline setBackgroundColor:kUIColorFromRGB(0xe3e3e3)];
    [self.secondline setBackgroundColor:kUIColorFromRGB(0xe3e3e3)];
    [self.thirtline setBackgroundColor:kUIColorFromRGB(0xe3e3e3)];
    [self.fourline setBackgroundColor:kUIColorFromRGB(0xe3e3e3)];
    [self.fiveline setBackgroundColor:kUIColorFromRGB(0xe3e3e3)];
    
    
    [self.fcolorView.layer setMasksToBounds:true];
    [self.fcolorView.layer setCornerRadius:self.fcolorView.frame.size.height/2];
    [self.scolorView.layer setMasksToBounds:true];
    [self.scolorView.layer setCornerRadius:self.scolorView.frame.size.height/2];
    [JXEncapSulationObjc addGradientColorView:self.fcolorView cgrectMake:CGRectMake(self.fcolorView.originX, self.fcolorView.originY, self.fcolorView.frame.size.width*2, self.fcolorView.frame.size.height) colors:@[(id)[UIColor redColor].CGColor, (id)[UIColor blueColor].CGColor,(id)[UIColor greenColor].CGColor]];
    [JXEncapSulationObjc addGradientColorView:self.scolorView cgrectMake:CGRectMake(self.scolorView.originX, self.scolorView.originY, self.scolorView.frame.size.width*2, self.scolorView.frame.size.height) colors:@[(id)[UIColor redColor].CGColor, (id)[UIColor blueColor].CGColor,(id)[UIColor greenColor].CGColor]];
    
    [JXContTextObjc p_SetfondLabel:self.firstTitleLabel fondSize:12.0];
    [JXContTextObjc p_SetfondLabel:self.secondTitleLabel fondSize:12.0];
    [JXContTextObjc p_SetfondLabel:self.thirtTitleLabel fondSize:12.0];
    [JXContTextObjc p_SetfondLabel:self.fourTitleLabel fondSize:12.0];
    [JXContTextObjc p_SetfondLabel:self.fiveTitleLabel fondSize:12.0];
    [JXContTextObjc p_SetfondLabel:self.moreLabel fondSize:14.0];
    
    [JXContTextObjc p_SetfondLabel:self.firstprice fondSize:14.0];
    [JXContTextObjc p_SetfondLabel:self.secondprice fondSize:14.0];
    [JXContTextObjc p_SetfondLabel:self.thirtprice fondSize:16.0];
    [JXContTextObjc p_SetfondLabel:self.fourprice fondSize:16.0];
    [JXContTextObjc p_SetfondLabel:self.fiveprice fondSize:16.0];
    
    
}
- (void)setModel:(JXHomepagModel *)model {
    
    _model = model;
    NSArray *infoArray = model.good[@"info"];
    [self adddateRequest:infoArray indexNumber:0 image:self.firstImage titleLabel:self.firstTitleLabel priceLabel:self.firstprice];
    [self adddateRequest:infoArray indexNumber:1 image:self.secondImage titleLabel:self.secondTitleLabel priceLabel:self.secondprice];
    [self adddateRequest:infoArray indexNumber:2 image:self.thirtImage titleLabel:self.thirtTitleLabel priceLabel:self.thirtprice];
    [self adddateRequest:infoArray indexNumber:3 image:self.fourImage titleLabel:self.fourTitleLabel priceLabel:self.fourprice];
    [self adddateRequest:infoArray indexNumber:4 image:self.fiveImage titleLabel:self.fiveTitleLabel priceLabel:self.fiveprice];
    
    [self layoutIfNeeded];
    // 获取最后一个View的最低层Y值
    _model.cellHeight = CGRectGetMaxY(self.backView.frame)-50;
}

- (void)adddateRequest:(NSArray*)dateArray indexNumber:(NSInteger)indexNumber image:(UIImageView *)image titleLabel:(UILabel *)titleLabel priceLabel:(UILabel *)priceLabel{
    
    if (dateArray.count>indexNumber) {
        NSDictionary *dic = dateArray[indexNumber];
        UIImage *cacheImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:[NSString stringWithFormat:@"%@%@",Image_Url,dic[@"good_img"]]];
        [image setImage:cacheImage];
        [image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Image_Url,dic[@"good_img"]]] placeholderImage:[UIImage imageNamed:@"img_图片加载_小"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
        }];
        titleLabel.text = [NSString stringWithFormat:@"%@",dic[@"good_name"]];
        priceLabel.text = [NSString stringWithFormat:@"￥%@",dic[@"good_price"]];
    }
    
}

- (IBAction)firstAction:(UIButton *)sender {
    _Imageblock(sender.tag,_model);
}

- (IBAction)secondAction:(UIButton *)sender {
    _Imageblock(sender.tag,_model);
    
}
- (IBAction)thirtAction:(UIButton *)sender {
    _Imageblock(sender.tag,_model);
    
}
- (IBAction)fourAction:(UIButton *)sender {
    _Imageblock(sender.tag,_model);
    
}
- (IBAction)fiveAction:(UIButton *)sender {
    _Imageblock(sender.tag,_model);
}




@end
