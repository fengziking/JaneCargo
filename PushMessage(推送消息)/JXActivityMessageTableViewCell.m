//
//  JXActivityMessageTableViewCell.m
//  JaneCargo
//
//  Created by 鹏 on 2017/8/21.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXActivityMessageTableViewCell.h"

@interface JXActivityMessageTableViewCell ()

@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIView *line;
@property (weak, nonatomic) IBOutlet UIButton *checkbt;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;


@end



@implementation JXActivityMessageTableViewCell

+ (instancetype)cellwithTable {
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JXActivityMessageTableViewCell class]) owner:self options:nil] lastObject];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setSelectionStyle:(UITableViewCellSelectionStyleNone)];
    [self.line setBackgroundColor:kUIColorFromRGB(0xe3e3e3)];
    [self.timeLabel.layer setMasksToBounds:true];
    [self.timeLabel.layer setCornerRadius:2.0f];
    
    
    [self.backView.layer setMasksToBounds:true];
    [self.backView.layer setCornerRadius:10.0f];
    
   // [self.timeLabel setText:@"  2017年6月23  "];
    [self.timeLabel setBackgroundColor:kUIColorFromRGB(0xbebebe)];
    
    self.backView.layer.shadowColor = kUIColorFromRGB(0xeeeeee).CGColor;//shadowColor阴影颜色
    self.backView.layer.shadowOffset = CGSizeMake(2,4);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    self.backView.layer.shadowOpacity = 1;//阴影透明度，默认0
    self.backView.layer.shadowRadius = 4;//阴影半径，默认3
    
    [self.contentLabel setTextColor:kUIColorFromRGB(0x666666)];
    [self.checkbt setTitleColor:kUIColorFromRGB(0x666666) forState:(UIControlStateNormal)];
    
}
- (void)setModel:(JXHomepagModel *)model {
    
    _model = model;
    self.timeLabel.text = [NSString stringWithFormat:@"  %@  ",model.create_time];
    self.titleLabel.text = model.title;
    self.contentLabel.text = model.content;
    UIImage *cacheImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:[NSString stringWithFormat:@"%@%@",Image_Url,model.good_img]];
    [self.iconImage setImage:cacheImage];
    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Image_Url,model.img]] placeholderImage:[UIImage imageNamed:@"img_活动推送加载"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
}

- (IBAction)checkAction:(UIButton *)sender {
    
    _WebJumpblock(_model);
}






- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
