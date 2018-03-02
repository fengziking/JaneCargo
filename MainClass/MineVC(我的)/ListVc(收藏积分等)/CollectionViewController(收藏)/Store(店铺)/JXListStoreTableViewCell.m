//
//  JXListStoreTableViewCell.m
//  JaneCargo
//
//  Created by 鹏 on 2017/8/8.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXListStoreTableViewCell.h"


@interface JXListStoreTableViewCell ()

@property (weak, nonatomic) IBOutlet UIView *backView;

@property (weak, nonatomic) IBOutlet UIImageView *shopImage;
@property (weak, nonatomic) IBOutlet UILabel *shopName;

@property (weak, nonatomic) IBOutlet UIButton *removebt;

@property (weak, nonatomic) IBOutlet UIImageView *goodsImagef;
@property (weak, nonatomic) IBOutlet UIImageView *goodsImages;
@property (weak, nonatomic) IBOutlet UIImageView *goodsImaget;

@property (weak, nonatomic) IBOutlet UILabel *goodsNamef;
@property (weak, nonatomic) IBOutlet UILabel *goodsNames;
@property (weak, nonatomic) IBOutlet UILabel *goodsNamet;



@property (weak, nonatomic) IBOutlet UIButton *firstbt;
@property (weak, nonatomic) IBOutlet UIButton *secondbt;

@property (weak, nonatomic) IBOutlet UIButton *morebt;


@property (weak, nonatomic) IBOutlet UIView *line;
@property (weak, nonatomic) IBOutlet UIView *linef;

@property (weak, nonatomic) IBOutlet UIButton *fbt;
@property (weak, nonatomic) IBOutlet UIButton *sbt;
@property (weak, nonatomic) IBOutlet UIButton *tbt;

@end

@implementation JXListStoreTableViewCell





+ (instancetype)cellWithTable {

    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JXListStoreTableViewCell class]) owner:self options:nil] lastObject];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [_line setBackgroundColor:kUIColorFromRGB(0xe3e3e3)];
    [_linef setBackgroundColor:kUIColorFromRGB(0xe3e3e3)];
    
    [self.backView.layer setMasksToBounds:true];
    [self.backView.layer setCornerRadius:5.0];
    
    [self.firstbt setBackgroundColor:kUIColorFromRGB(0xe82b48)];
    [self.firstbt.layer setMasksToBounds:true];
    [self.firstbt.layer setCornerRadius:2.0];
    [self.secondbt setBackgroundColor:kUIColorFromRGB(0xff974b)];
    [self.secondbt.layer setMasksToBounds:true];
    [self.secondbt.layer setCornerRadius:2.0];
    
    
    [self.removebt setTitleColor:kUIColorFromRGB(0x999999) forState:(UIControlStateNormal)];
    
    
    
}

- (void)setModel:(JXStoreMore *)model {
    _model = model;
    _shopName.text = model.seller_name;
    NSMutableArray *imageArray = @[].mutableCopy;
    NSMutableArray *nameArray = @[].mutableCopy;
    NSArray *dateArray = model.info;
    for (JXHomepagModel *model in dateArray) {
        [imageArray addObject:model.good_img];
        [nameArray addObject:model.good_name];
    }
    
    switch (imageArray.count) {
            case 0:
        {
            [_fbt setEnabled:NO];
            [_sbt setEnabled:NO];
            [_tbt setEnabled:NO];
           
        }
            break;
            
        case 1:
        {
            [_sbt setEnabled:NO];
            [_tbt setEnabled:NO];
            [self setdateArray:nameArray[0] imagearray:imageArray[0] namelabel:self.goodsNamef image:self.goodsImagef];

        }
            break;
        case 2:
        {
            [_tbt setEnabled:NO];
            [self setdateArray:nameArray[0] imagearray:imageArray[0] namelabel:self.goodsNamef image:self.goodsImagef];
            [self setdateArray:nameArray[1] imagearray:imageArray[1] namelabel:self.goodsNames image:self.goodsImages];
            
            
        }
            break;
        case 3:
        {
            
            
            [self setdateArray:nameArray[0] imagearray:imageArray[0] namelabel:self.goodsNamef image:self.goodsImagef];
            [self setdateArray:nameArray[1] imagearray:imageArray[1] namelabel:self.goodsNames image:self.goodsImages];
            [self setdateArray:nameArray[2] imagearray:imageArray[2] namelabel:self.goodsNamet image:self.goodsImaget];
        }
            break;
        default:
            break;
    }
   

}


- (void)setdateArray:(NSString *)nameArray imagearray:(NSString *)imageArray namelabel:(UILabel *)namelabel image:(UIImageView *)image{

    [namelabel setText:nameArray];
    UIImage *cacheImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:[NSString stringWithFormat:@"%@%@",Image_Url,imageArray]];
    [image setImage:cacheImage];
    [image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Image_Url,imageArray]] placeholderImage:[UIImage imageNamed:@"img_图片加载_小"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
    }];
    [image.layer setBorderWidth:0.5];
    [image.layer setBorderColor:[kUIColorFromRGB(0xe3e3e3) CGColor]];
}



// 移除
- (IBAction)removeAction:(UIButton *)sender {
    
    _Deletegoodshop(_model);
    
}
// 更多
- (IBAction)moreAction:(UIButton *)sender {
    
    _Moreblock(_model);
}


- (IBAction)fbtAction:(UIButton *)sender {
    
    _SelectImage(sender.tag,_model);
}

- (IBAction)sbtAction:(UIButton *)sender {
    _SelectImage(sender.tag,_model);
}

- (IBAction)tbtAction:(UIButton *)sender {
    _SelectImage(sender.tag,_model);
}












@end
