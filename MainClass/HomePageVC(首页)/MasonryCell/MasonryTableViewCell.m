//
//  MasonryTableViewCell.m
//  MasonryLayOut
//
//  Created by cxy on 2017/8/24.
//  Copyright © 2017年 cxy. All rights reserved.
//

#import "MasonryTableViewCell.h"
#import "Masonry.h"

@interface MasonryTableViewCell ()

// 闪电图
@property (nonatomic, strong) UIImageView *graphImage;
// 抢购
@property (nonatomic, strong) UILabel *buyLabel;
// 时
@property (nonatomic, strong) UILabel *hourLabel;
// 分
@property (nonatomic, strong) UILabel *minuteLabel;
// 秒
@property (nonatomic, strong) UILabel *secLabel;
// ：点
@property (nonatomic, strong) UILabel *fspotLabel;
@property (nonatomic, strong) UILabel *sspotLabel;
// 更多
@property (nonatomic, strong) UIButton *moreButton;
// 第一张
@property (nonatomic, strong) UIImageView *fgoodImage;
@property (nonatomic, strong) UILabel *fnameLabel;
@property (nonatomic, strong) UILabel *fpriceLabel;
@property (nonatomic, strong) UILabel *fdiscountLabel;
@property (nonatomic, strong) UIView *fdiscountLine;
// 第二张
@property (nonatomic, strong) UIImageView *sgoodImage;
@property (nonatomic, strong) UILabel *snameLabel;
@property (nonatomic, strong) UILabel *spriceLabel;
@property (nonatomic, strong) UILabel *sdiscountLabel;
@property (nonatomic, strong) UIView *sdiscountLine;
// 第三张
@property (nonatomic, strong) UIImageView *tgoodImage;
@property (nonatomic, strong) UILabel *tnameLabel;
@property (nonatomic, strong) UILabel *tpriceLabel;
@property (nonatomic, strong) UILabel *tdiscountLabel;
@property (nonatomic, strong) UIView *tdiscountLine;
// 线条
@property (nonatomic, strong) UIView *fline;
@property (nonatomic, strong) UIView *sline;
@property (nonatomic, strong) UIView *tline;
// button
@property (nonatomic, strong) UIButton *fisbt;
@property (nonatomic, strong) UIButton *secbt;
@property (nonatomic, strong) UIButton *thibt;

@end


@implementation MasonryTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self y_masonryLayOut];
    }
    return self;
}


- (void)y_masonryLayOut {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _graphImage = ({
        UIImageView * image = [UIImageView new];
        [image setImage:[UIImage imageNamed:HomePageLightningImage]];
        image;
    });
    [self.contentView addSubview:_graphImage];
    
    _buyLabel = ({
        UILabel * label = [UILabel new];
        [JXContTextObjc p_SetfondLabel:label fondSize:16.0];
        [label setText:HomePageSnapUp_Text];
        label;
    });
    [self.contentView addSubview:_buyLabel];
    
    _hourLabel = ({
        UILabel * label = [UILabel new];
        [label setFont:[UIFont systemFontOfSize:12.0f]];
        [label setText:@"10"];
        [label setBackgroundColor:[UIColor blackColor]];
        [label setTextColor:[UIColor whiteColor]];
        [label setTextAlignment:NSTextAlignmentCenter];
        [label.layer setMasksToBounds:true];
        [label.layer setCornerRadius:4.0];
        label;
    });
    [self.contentView addSubview:_hourLabel];
    
    _fspotLabel = ({
        UILabel * label = [UILabel new];
        [label setFont:[UIFont systemFontOfSize:12.0f]];
        [label setText:@":"];
        [label setTextColor:[UIColor blackColor]];
        [label setTextAlignment:NSTextAlignmentCenter];
        
        label;
    });
    [self.contentView addSubview:_fspotLabel];
    
    _minuteLabel = ({
        UILabel * label = [UILabel new];
        [label setFont:[UIFont systemFontOfSize:12.0f]];
        [label setText:@"10"];
        [label setBackgroundColor:[UIColor blackColor]];
        [label setTextColor:[UIColor whiteColor]];
        [label setTextAlignment:NSTextAlignmentCenter];
        [label.layer setMasksToBounds:true];
        [label.layer setCornerRadius:4.0];
        label;
    });
    [self.contentView addSubview:_minuteLabel];
    
    _sspotLabel = ({
        UILabel * label = [UILabel new];
        [label setFont:[UIFont systemFontOfSize:12.0f]];
        [label setText:@":"];
        [label setTextColor:[UIColor blackColor]];
        [label setTextAlignment:NSTextAlignmentCenter];
        label;
    });
    [self.contentView addSubview:_sspotLabel];
    
    _secLabel = ({
        UILabel * label = [UILabel new];
        [label setFont:[UIFont systemFontOfSize:12.0f]];
        [label setText:@"10"];
        [label setBackgroundColor:[UIColor blackColor]];
        [label setTextColor:[UIColor whiteColor]];
        [label setTextAlignment:NSTextAlignmentCenter];
        [label.layer setMasksToBounds:true];
        [label.layer setCornerRadius:4.0];
        label;
    });
    [self.contentView addSubview:_secLabel];
    
    _moreButton = ({
        UIButton * button = [UIButton new];
        [button setTitle:@"更多" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [button.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
        [button addTarget:self action:@selector(moreAction:) forControlEvents:(UIControlEventTouchUpInside)];
        button;
    });
    [self.contentView addSubview:_moreButton];
    
    _fline = ({
        UIView * line = [UIView new];
        [line setBackgroundColor:kUIColorFromRGB(0xCCCCCC)];
        line;
    });
    [self.contentView addSubview:_fline];
    // 第一张
    _fgoodImage = ({
        UIImageView * image = [UIImageView new];
        image;
    });
    [self.contentView addSubview:_fgoodImage];
    _fnameLabel = ({
        UILabel * label = [UILabel new];
        [JXContTextObjc p_SetfondLabel:label fondSize:12.0];
        [label setNumberOfLines:2];
        [label setTextColor:[UIColor blackColor]];
        label;
    });
    [self.contentView addSubview:_fnameLabel];
    _fpriceLabel = ({
        UILabel * label = [UILabel new];
        [JXContTextObjc p_SetfondLabel:label fondSize:16.0];
        [label setTextColor:[UIColor redColor]];
        [label setTextAlignment:NSTextAlignmentCenter];
        label;
    });
    [self.contentView addSubview:_fpriceLabel];
    _fdiscountLabel = ({
        UILabel * label = [UILabel new];
        [JXContTextObjc p_SetfondLabel:label fondSize:9.0];
        [label setTextColor:[UIColor grayColor]];
        [label setTextAlignment:NSTextAlignmentCenter];
        label;
    });
    [self.contentView addSubview:_fdiscountLabel];
    _fdiscountLine = ({
        UIView * line = [UIView new];
        [line setBackgroundColor:kUIColorFromRGB(0x999999)];
        line;
    });
    [self.contentView addSubview:_fdiscountLine];
    
    // 线条
    _sline = ({
        UIView * line = [UIView new];
        [line setBackgroundColor:kUIColorFromRGB(0xCCCCCC)];
        line;
    });
    [self.contentView addSubview:_sline];
    // 第二张
    _sgoodImage = ({
        UIImageView * image = [UIImageView new];
        image;
    });
    [self.contentView addSubview:_sgoodImage];
    _snameLabel = ({
        UILabel * label = [UILabel new];
        [JXContTextObjc p_SetfondLabel:label fondSize:12.0];
        [label setNumberOfLines:2];
        [label setTextColor:[UIColor blackColor]];
        label;
    });
    [self.contentView addSubview:_snameLabel];
    _spriceLabel = ({
        UILabel * label = [UILabel new];
        [JXContTextObjc p_SetfondLabel:label fondSize:16.0];
        [label setTextColor:[UIColor redColor]];
        [label setTextAlignment:NSTextAlignmentCenter];
        label;
    });
    [self.contentView addSubview:_spriceLabel];
    _sdiscountLabel = ({
        UILabel * label = [UILabel new];
        [JXContTextObjc p_SetfondLabel:label fondSize:9.0];
        
        [label setTextColor:[UIColor grayColor]];
        [label setTextAlignment:NSTextAlignmentCenter];
        label;
    });
    [self.contentView addSubview:_sdiscountLabel];
    _sdiscountLine = ({
        UIView * line = [UIView new];
        [line setBackgroundColor:kUIColorFromRGB(0x999999)];
        line;
    });
    [self.contentView addSubview:_sdiscountLine];
    // 线条
    _tline = ({
        UIView * line = [UIView new];
        [line setBackgroundColor:kUIColorFromRGB(0xCCCCCC)];
        line;
    });
    [self.contentView addSubview:_tline];
    // 第三张
    _tgoodImage = ({
        UIImageView * image = [UIImageView new];
        image;
    });
    [self.contentView addSubview:_tgoodImage];
    _tnameLabel = ({
        UILabel * label = [UILabel new];
        [JXContTextObjc p_SetfondLabel:label fondSize:12.0];
        [label setNumberOfLines:2];
        [label setTextColor:[UIColor blackColor]];
        label;
    });
    [self.contentView addSubview:_tnameLabel];
    _tpriceLabel = ({
        UILabel * label = [UILabel new];
        [JXContTextObjc p_SetfondLabel:label fondSize:16.0];
        [label setTextColor:[UIColor redColor]];
        [label setTextAlignment:NSTextAlignmentCenter];
        label;
    });
    [self.contentView addSubview:_tpriceLabel];
    _tdiscountLabel = ({
        UILabel * label = [UILabel new];
        [JXContTextObjc p_SetfondLabel:label fondSize:9.0];
        [label setTextColor:[UIColor grayColor]];
        [label setTextAlignment:NSTextAlignmentCenter];
        label;
    });
    [self.contentView addSubview:_tdiscountLabel];
    _tdiscountLine = ({
        UIView * line = [UIView new];
        [line setBackgroundColor:kUIColorFromRGB(0x999999)];
        line;
    });
    [self.contentView addSubview:_tdiscountLine];
    
    
    _fisbt = ({
        UIButton * fibt = [UIButton new];
        fibt.tag = 0;
        [fibt addTarget:self action:@selector(fibtAction:) forControlEvents:(UIControlEventTouchUpInside)];
        fibt;
    });
    [self.contentView addSubview:_fisbt];
    
    _secbt = ({
        UIButton * fibt = [UIButton new];
        fibt.tag = 1;
        [fibt addTarget:self action:@selector(secbtAction:) forControlEvents:(UIControlEventTouchUpInside)];
        fibt;
    });
    [self.contentView addSubview:_secbt];
    
    _thibt = ({
        UIButton * fibt = [UIButton new];
        fibt.tag = 2;
        [fibt addTarget:self action:@selector(thibtAction:) forControlEvents:(UIControlEventTouchUpInside)];
        fibt;
    });
    [self.contentView addSubview:_thibt];
}

- (void)fibtAction:(UIButton *)sender {

    _goodbk(sender.tag);
}
- (void)secbtAction:(UIButton *)sender {
    _goodbk(sender.tag);
    
}
- (void)thibtAction:(UIButton *)sender {
    _goodbk(sender.tag);
    
}



- (void)layoutSubviews {
    [super layoutSubviews];
    // 闪电
    [_graphImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(14);
        make.left.equalTo(self.mas_left).offset(15);
        make.height.equalTo(@16);
        make.width.equalTo(@9);
    }];
    // 抢购
    [_buyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(14);
        make.left.equalTo(_graphImage.mas_right).offset(5);
        make.height.equalTo(@16);

    }];
    // 时
    [_hourLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(12);
        make.left.equalTo(_buyLabel.mas_right).offset(10);
        make.height.equalTo(@(20));
        make.width.equalTo(@(20));
    }];
    // :
    [_fspotLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(12);
        make.left.equalTo(_hourLabel.mas_right);
        make.height.equalTo(@(20));
        make.width.equalTo(@(10));
    }];
    // 分
    [_minuteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(12);
        make.left.equalTo(_fspotLabel.mas_right);
        make.height.equalTo(@(20));
        make.width.equalTo(@(20));
    }];
    // :
    [_sspotLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(12);
        make.left.equalTo(_minuteLabel.mas_right);
        make.height.equalTo(@(20));
        make.width.equalTo(@(10));
    }];
    // 秒
    [_secLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(12);
        make.left.equalTo(_sspotLabel.mas_right);
        make.height.equalTo(@(20));
        make.width.equalTo(@(20));
    }];
    
    // 更多
    CGFloat more_With = [self stringWidth:_moreButton.titleLabel.text maxSize:200 fontSize:14.0f];
    [_moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(12);
        make.left.equalTo(self.mas_right).offset(-15-more_With);
        make.height.equalTo(@(20));
    }];
    // 线条
    [_fline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(43);
        make.left.equalTo(self.mas_left);
        make.height.equalTo(@(0.5));
        make.width.equalTo(self.mas_width);
    }];
    // 第一张
    [_fgoodImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(44);
        make.left.equalTo(self.mas_left);
        make.height.equalTo(@(self.frame.size.width/3*19/25));
        make.width.equalTo(@(self.frame.size.width/3));
    }];

    [_fnameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_fgoodImage.mas_top).offset(self.frame.size.width/3*19/25+3);
        make.left.equalTo(_fgoodImage.mas_left).offset(10);
        make.right.equalTo(_fgoodImage.mas_right).offset(-10);
    }];
    
    [_fpriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(-6);
        make.left.equalTo(_fgoodImage.mas_left).offset(10);
        make.height.equalTo(@(16));
    }];
    
    [_fdiscountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(-8);
        make.right.equalTo(_fgoodImage.mas_right).offset(-10);
        make.height.equalTo(@(9));
    }];
    
    [_fdiscountLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_fdiscountLabel.mas_top).offset(4);
        make.right.equalTo(_fdiscountLabel.mas_right);
        make.left.equalTo(_fdiscountLabel.mas_left);
        make.height.equalTo(@(0.5));
    }];
    
    // 线条
    [_sline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_fgoodImage.mas_top);
        make.right.equalTo(_fgoodImage.mas_right);
        make.width.equalTo(@(0.5));
        make.height.equalTo(@(self.frame.size.width/3*19/25+9+12+12+30));
    }];
    
    // 第二张
    [_sgoodImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(44);
        make.left.equalTo(_fgoodImage.mas_left).offset(self.frame.size.width/3);
        make.height.equalTo(@(self.frame.size.width/3*19/25));
        make.width.equalTo(@(self.frame.size.width/3));
    }];
    
    [_snameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_sgoodImage.mas_top).offset(self.frame.size.width/3*19/25+3);
        make.left.equalTo(_sgoodImage.mas_left).offset(10);
        make.right.equalTo(_sgoodImage.mas_right).offset(-10);
    }];
    
    [_spriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(-6);
        make.left.equalTo(_sgoodImage.mas_left).offset(10);
        make.height.equalTo(@(16));
    }];
    
    [_sdiscountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(-8);
        make.right.equalTo(_sgoodImage.mas_right).offset(-10);
        make.height.equalTo(@(9));
    }];
    
    [_sdiscountLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_sdiscountLabel.mas_top).offset(4);
        make.right.equalTo(_sdiscountLabel.mas_right);
        make.left.equalTo(_sdiscountLabel.mas_left);
        make.height.equalTo(@(0.5));
    }];
    // 线条
    [_tline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_sgoodImage.mas_top);
        make.right.equalTo(_sgoodImage.mas_right);
        make.width.equalTo(@(0.5));
        make.height.equalTo(@(self.frame.size.width/3*19/25+9+12+12+30));
    }];
    
    // 第三张
    [_tgoodImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(44);
        make.left.equalTo(_sgoodImage.mas_left).offset(self.frame.size.width/3);
        make.height.equalTo(@(self.frame.size.width/3*19/25));
        make.width.equalTo(@(self.frame.size.width/3));
    }];
    
    [_tnameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_tgoodImage.mas_top).offset(self.frame.size.width/3*19/25+3);
        make.left.equalTo(_tgoodImage.mas_left).offset(10);
        make.right.equalTo(_tgoodImage.mas_right).offset(-10);
    }];
    
    [_tpriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(-6);
        make.left.equalTo(_tgoodImage.mas_left).offset(10);
        make.height.equalTo(@(16));
    }];
    
    [_tdiscountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(-8);
        make.right.equalTo(_tgoodImage.mas_right).offset(-10);
        make.height.equalTo(@(9));
    }];
    
    [_tdiscountLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_tdiscountLabel.mas_top).offset(4);
        make.right.equalTo(_tdiscountLabel.mas_right);
        make.left.equalTo(_tdiscountLabel.mas_left);
        make.height.equalTo(@(0.5));
    }];
    
    [_fisbt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(44);
        make.left.equalTo(self.mas_left);
        make.height.equalTo(@(self.frame.size.width/3*19/25+9+12+12+30));
        make.width.equalTo(@(self.frame.size.width/3));
    }];
    
    [_secbt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(44);
        make.left.equalTo(_fisbt.mas_right);
        make.height.equalTo(@(self.frame.size.width/3*19/25+9+12+12+30));
        make.width.equalTo(@(self.frame.size.width/3));
    }];
    [_thibt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(44);
        make.left.equalTo(_secbt.mas_right);
        make.height.equalTo(@(self.frame.size.width/3*19/25+9+12+12+30));
        make.width.equalTo(@(self.frame.size.width/3));
    }];
    
    
    
}


-(void)setModel:(JXHomepagModel *)model {
    _model = model;
    [JXContTextObjc changelabelColor:self.buyLabel range:NSMakeRange(0, 2) color:[UIColor redColor]];
    switch (model.type_model) {
        case 0:
        {
            
            UIImage *cacheImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:[NSString stringWithFormat:@"%@%@",Image_Url,model.good_img]];
            [self.fgoodImage setImage:cacheImage];
            [self.fgoodImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Image_Url,model.good_img]] placeholderImage:[UIImage imageNamed:@"img_图片加载_小"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                
            }];
            self.fnameLabel.text = model.good_name;
            self.fpriceLabel.text = [NSString stringWithFormat:@"￥%@",model.good_price];
            self.fdiscountLabel.text = [NSString stringWithFormat:@"￥%@",model.market_price];
            [JXEncapSulationObjc changeWordSize:self.fnameLabel size:12.0f];
            [JXEncapSulationObjc changeWordSize:self.fpriceLabel size:12.0f];
            [JXEncapSulationObjc changeWordSize:self.fdiscountLabel size:7.0f];
        }
            break;
        case 1:
        {
            UIImage *cacheImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:[NSString stringWithFormat:@"%@%@",Image_Url,model.good_img]];
            [self.sgoodImage setImage:cacheImage];
            [self.sgoodImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Image_Url,model.good_img]] placeholderImage:[UIImage imageNamed:@"img_图片加载_小"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                
            }];
            self.snameLabel.text = model.good_name;
            self.spriceLabel.text = [NSString stringWithFormat:@"￥%@",model.good_price];
            self.sdiscountLabel.text = [NSString stringWithFormat:@"￥%@",model.market_price];
            [JXEncapSulationObjc changeWordSize:self.snameLabel size:12.0f];
            [JXEncapSulationObjc changeWordSize:self.spriceLabel size:12.0f];
            [JXEncapSulationObjc changeWordSize:self.sdiscountLabel size:7.0f];
        }
            break;
        case 2:
        {
            UIImage *cacheImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:[NSString stringWithFormat:@"%@%@",Image_Url,model.good_img]];
            [self.tgoodImage setImage:cacheImage];
            [self.tgoodImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Image_Url,model.good_img]] placeholderImage:[UIImage imageNamed:@"img_图片加载_小"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                
            }];
            self.tnameLabel.text = model.good_name;
            self.tpriceLabel.text = [NSString stringWithFormat:@"￥%@",model.good_price];
            self.tdiscountLabel.text = [NSString stringWithFormat:@"￥%@",model.market_price];
            [JXEncapSulationObjc changeWordSize:self.tnameLabel size:12.0f];
            [JXEncapSulationObjc changeWordSize:self.tpriceLabel size:12.0f];
            [JXEncapSulationObjc changeWordSize:self.tdiscountLabel size:7.0f];
        }
            break;
        default:
            break;
    }
    
    
}

- (void)moreAction:(UIButton *)sender {

    _morebt();

}




#pragma mark ---- 自适应宽度
- (CGFloat)stringWidth:(NSString *)aString maxSize:(CGFloat)size fontSize:(CGFloat)fontSize {
    CGRect r = [aString boundingRectWithSize:CGSizeMake(size, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil];
    return r.size.width;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
