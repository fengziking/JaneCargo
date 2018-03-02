//
//  MasonryHomeTableViewCell.m
//  MasonryLayOut
//
//  Created by cxy on 2017/8/24.
//  Copyright © 2017年 cxy. All rights reserved.
//

#import "MasonryHomeTableViewCell.h"
#import "Masonry.h"


#define PRICE_BOTTOM (-6)

@interface MasonryHomeTableViewCell ()

@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIView *fisview;
@property (nonatomic, strong) UIView *secview;
@property (nonatomic, strong) UIView *thiview;
@property (nonatomic, strong) UIView *fouview;
@property (nonatomic, strong) UIView *fivview;

// 1
@property (nonatomic, strong) UIImageView *fImage;
@property (nonatomic, strong) UILabel *ftitleLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UIView *colorView;
// 2
@property (nonatomic, strong) UIImageView *sImage;
@property (nonatomic, strong) UILabel *stitleLabel;
@property (nonatomic, strong) UILabel *spriceLabel;
@property (nonatomic, strong) UIView *scolorView;
//3
@property (nonatomic, strong) UILabel *ttitleLabel;
@property (nonatomic, strong) UIImageView *tImage;
@property (nonatomic, strong) UILabel *tpriceLabel;
// 4
@property (nonatomic, strong) UILabel *fotitleLabel;
@property (nonatomic, strong) UIImageView *foImage;
@property (nonatomic, strong) UILabel *fopriceLabel;
// 5
@property (nonatomic, strong) UILabel *fititleLabel;
@property (nonatomic, strong) UIImageView *fiImage;
@property (nonatomic, strong) UILabel *fipriceLabel;

// 更多图片
@property (nonatomic, strong) UIImageView *moreImage;
@property (nonatomic, strong) UILabel *moreLabel;
@property (nonatomic, strong) UIButton *morebt;

// bt
@property (nonatomic, strong) UIButton *fisbt;
@property (nonatomic, strong) UIButton *secbt;
@property (nonatomic, strong) UIButton *thibt;
@property (nonatomic, strong) UIButton *foubt;
@property (nonatomic, strong) UIButton *fivbt;

// 线条
@property (nonatomic, strong) UIView *linefir;
@property (nonatomic, strong) UIView *linesec;
@property (nonatomic, strong) UIView *linethi;
@property (nonatomic, strong) UIView *linefou;
@property (nonatomic, strong) UIView *linefiv;

@end


@implementation MasonryHomeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self y_masonryLayOut];
    }
    return self;
}

- (void)y_masonryLayOut {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self setBackgroundColor:[UIColor grayColor]];

    
    
    _backView = ({
        UIView * view = [UIView new];
        [view setBackgroundColor:[UIColor whiteColor]];
        [view.layer setMasksToBounds:YES];
        [view.layer setCornerRadius:5];
        view;
    });
    [self.contentView addSubview:_backView];
    
    _fisview = ({
        UIView * view = [UIView new];
        view;
    });
    [self.contentView addSubview:_fisview];
    
    _secview = ({
        UIView * view = [UIView new];
        view;
    });
    [self.contentView addSubview:_secview];
    
    _thiview = ({
        UIView * view = [UIView new];
        view;
    });
    [self.contentView addSubview:_thiview];
    
    _fouview = ({
        UIView * view = [UIView new];
        view;
    });
    [self.contentView addSubview:_fouview];
    
    _fivview = ({
        UIView * view = [UIView new];
        view;
    });
    [self.contentView addSubview:_fivview];
    // 1
    _fImage = ({
        UIImageView * image = [UIImageView new];
        image;
    });
    [self.contentView addSubview:_fImage];
    
    _ftitleLabel = ({
        UILabel *label = [UILabel new];
        [JXContTextObjc p_SetfondLabel:label fondSize:12.0];
        [label setTextColor:[UIColor blackColor]];
        [label setNumberOfLines:2];
        label;
    
    });
    [self.contentView addSubview:_ftitleLabel];
    
    _priceLabel = ({
        
        UILabel *label = [UILabel new];
        [JXContTextObjc p_SetfondLabel:label fondSize:14.0];
        [label setTextColor:[UIColor whiteColor]];
//        [label setText:@"  ¥ 3.00  "];
        [label setNumberOfLines:2];
        label;
        
    });
    [self.contentView addSubview:_priceLabel];
    
    _colorView = ({
        
        UIView * view = [UIView new];
        view;
    });
    [self.contentView addSubview:_colorView];
    [self.contentView bringSubviewToFront:_priceLabel];
    
    // 2
    _sImage = ({
        UIImageView * image = [UIImageView new];
        image;
    });
    [self.contentView addSubview:_sImage];
    
    _stitleLabel = ({
        UILabel *label = [UILabel new];
        [JXContTextObjc p_SetfondLabel:label fondSize:12.0];
        [label setTextColor:[UIColor blackColor]];
        [label setNumberOfLines:2];
        label;
        
    });
    [self.contentView addSubview:_stitleLabel];
    
    _spriceLabel = ({
        
        UILabel *label = [UILabel new];
        [JXContTextObjc p_SetfondLabel:label fondSize:14.0];
        [label setTextColor:[UIColor whiteColor]];
        [label setNumberOfLines:2];
        label;
        
    });
    [self.contentView addSubview:_spriceLabel];
    
    _scolorView = ({
        
        UIView * view = [UIView new];
        view;
    });
    [self.contentView addSubview:_scolorView];
    [self.contentView bringSubviewToFront:_spriceLabel];
    //3
    _ttitleLabel = ({
        UILabel *label = [UILabel new];
        [JXContTextObjc p_SetfondLabel:label fondSize:12.0];
        [label setTextColor:[UIColor blackColor]];
        [label setNumberOfLines:2];
        label;
        
    });
    [self.contentView addSubview:_ttitleLabel];
    _tImage = ({
        UIImageView * image = [UIImageView new];
        image;
    });
    [self.contentView addSubview:_tImage];
    
    _tpriceLabel = ({
        
        UILabel *label = [UILabel new];
        [JXContTextObjc p_SetfondLabel:label fondSize:16.0];
        [label setNumberOfLines:2];
        label;
        
    });
    [self.contentView addSubview:_tpriceLabel];
    
    // 4
    _fotitleLabel = ({
        UILabel *label = [UILabel new];
        [JXContTextObjc p_SetfondLabel:label fondSize:12.0];
        [label setTextColor:[UIColor blackColor]];
        [label setNumberOfLines:2];
        label;
        
    });
    [self.contentView addSubview:_fotitleLabel];
    _foImage = ({
        UIImageView * image = [UIImageView new];
        image;
    });
    [self.contentView addSubview:_foImage];
    
    _fopriceLabel = ({
        
        UILabel *label = [UILabel new];
        [JXContTextObjc p_SetfondLabel:label fondSize:16.0];
        [label setNumberOfLines:2];
        label;
        
    });
    [self.contentView addSubview:_fopriceLabel];
    
    // 5
    _fititleLabel = ({
        UILabel *label = [UILabel new];
        [JXContTextObjc p_SetfondLabel:label fondSize:12.0];
        [label setTextColor:[UIColor blackColor]];
        [label setNumberOfLines:2];
        label;
        
    });
    [self.contentView addSubview:_fititleLabel];
    _fiImage = ({
        UIImageView * image = [UIImageView new];
        image;
    });
    [self.contentView addSubview:_fiImage];
    
    _fipriceLabel = ({
        
        UILabel *label = [UILabel new];
        [JXContTextObjc p_SetfondLabel:label fondSize:16.0];
        [label setNumberOfLines:2];
        label;
        
    });
    [self.contentView addSubview:_fipriceLabel];
    
    // 更多
    _moreImage = ({
        UIImageView * image = [UIImageView new];
        image;
    });
    [self.contentView addSubview:_moreImage];
    
    _moreLabel = ({
        UILabel *label = [UILabel new];
        [JXContTextObjc p_SetfondLabel:label fondSize:14.0];
        [label setTextColor:[UIColor blackColor]];
        [label setText:@"更多产品信息"];
        label;
    });
    [self.contentView addSubview:_moreLabel];
    
    
    _morebt = ({
        UIButton * fibt = [UIButton new];
        fibt.tag = 5;
        [fibt addTarget:self action:@selector(morebtAction:) forControlEvents:(UIControlEventTouchUpInside)];
        fibt;
    });
    [self.contentView addSubview:_morebt];
    
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
    _foubt = ({
        UIButton * fibt = [UIButton new];
        fibt.tag = 3;
        [fibt addTarget:self action:@selector(foubtAction:) forControlEvents:(UIControlEventTouchUpInside)];
        fibt;
    });
    [self.contentView addSubview:_foubt];
    _fivbt = ({
        UIButton * fibt = [UIButton new];
        fibt.tag = 4;
        [fibt addTarget:self action:@selector(fivebtAction:) forControlEvents:(UIControlEventTouchUpInside)];
        fibt;
    });
    [self.contentView addSubview:_fivbt];
    
    _linefir = ({
        UIView * view = [UIView new];
        [view setBackgroundColor:kUIColorFromRGB(0xcccccc)];
        view;
    });
    [self.contentView addSubview:_linefir];
    _linesec = ({
        UIView * view = [UIView new];
        [view setBackgroundColor:kUIColorFromRGB(0xcccccc)];
        view;
    });
    [self.contentView addSubview:_linesec];
    _linethi = ({
        UIView * view = [UIView new];
        [view setBackgroundColor:kUIColorFromRGB(0xcccccc)];
        view;
    });
    [self.contentView addSubview:_linethi];
    _linefou = ({
        UIView * view = [UIView new];
        [view setBackgroundColor:kUIColorFromRGB(0xcccccc)];
        view;
    });
    [self.contentView addSubview:_linefou];
    _linefiv = ({
        UIView * view = [UIView new];
        [view setBackgroundColor:kUIColorFromRGB(0xcccccc)];
        view;
    });
    [self.contentView addSubview:_linefiv];
    
}

- (void)fibtAction:(UIButton *)sender {
    
    _Imageblock(sender.tag,_model);
}
- (void)secbtAction:(UIButton *)sender {
    
    _Imageblock(sender.tag,_model);
}
- (void)thibtAction:(UIButton *)sender {
    
    _Imageblock(sender.tag,_model);
}
- (void)foubtAction:(UIButton *)sender {
    
    _Imageblock(sender.tag,_model);
}
- (void)fivebtAction:(UIButton *)sender {
    
    _Imageblock(sender.tag,_model);
}

- (void)morebtAction:(UIButton *)sender {
    
    _Imageblock(sender.tag,_model);
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left).offset(10);
        make.right.equalTo(self.mas_right).offset(-10);
        make.height.equalTo(@(self.frame.size.width*56/73));
    }];
    
    [_fisview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.left.equalTo(_backView.mas_left);
        make.width.equalTo(@((self.frame.size.width*56/73)/4*43/15));
        make.height.equalTo(@((self.frame.size.width*56/73)/4));
    }];
    
    [_secview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_fisview.mas_bottom);
        make.left.equalTo(_backView.mas_left);
        make.width.equalTo(_fisview.mas_width);
        make.height.equalTo(_fisview.mas_height);
    }];
    
    [_thiview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_secview.mas_bottom);
        make.left.equalTo(_backView.mas_left);
        make.width.equalTo(@((self.frame.size.width-20)/3));
        make.height.equalTo(@((self.frame.size.width*56/73)/2));
    }];
    
    [_fouview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_thiview.mas_top);
        make.left.equalTo(_thiview.mas_right);
        make.width.equalTo(_thiview.mas_width);
        make.height.equalTo(_thiview.mas_height);
    }];
    [_fivview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_fouview.mas_top);
        make.left.equalTo(_fouview.mas_right);
        make.width.equalTo(_thiview.mas_width);
        make.height.equalTo(_thiview.mas_height);
    }];
    // 1
    [_fImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_fisview.mas_top).offset(5);
        make.left.equalTo(_fisview.mas_left).offset(5);
        make.bottom.equalTo(_fisview.mas_bottom).offset(-5);
        make.width.equalTo(@(((self.frame.size.width*56/73)/4*43/14)*16/43));
        
    }];
    
    [_ftitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_fisview.mas_top).offset(10);
        make.left.equalTo(_fImage.mas_right).offset(8);
        make.right.equalTo(_fisview.mas_right).offset(-13);
    }];
    
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_fisview.mas_bottom).offset(-8);
        make.left.equalTo(_fImage.mas_right).offset(8);
        make.height.equalTo(@(14+4));
    }];
    [_colorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_priceLabel.mas_top);
        make.left.equalTo(_priceLabel.mas_left);
        make.height.equalTo(_priceLabel.mas_height);
        make.width.equalTo(_priceLabel.mas_width);
    }];
    
    // 2
    [_sImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_secview.mas_top).offset(5);
        make.left.equalTo(_secview.mas_left).offset(5);
        make.bottom.equalTo(_secview.mas_bottom).offset(-5);
        make.width.equalTo(_fImage.mas_width);
    }];
    
    [_stitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_secview.mas_top).offset(10);
        make.left.equalTo(_sImage.mas_right).offset(8);
        make.right.equalTo(_secview.mas_right).offset(-13);
    }];
    
    [_spriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_secview.mas_bottom).offset(-8);
        make.left.equalTo(_sImage.mas_right).offset(8);
        make.height.equalTo(@(14+4));
    }];
    [_scolorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_spriceLabel.mas_top);
        make.left.equalTo(_spriceLabel.mas_left);
        make.height.equalTo(_spriceLabel.mas_height);
        make.width.equalTo(_spriceLabel.mas_width);
    }];
    
    
    // 3
    [_ttitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_thiview.mas_top).offset(3*((self.frame.size.width*56/73)/2)/28);
        make.left.equalTo(_thiview.mas_left).offset(12);
        make.right.equalTo(_thiview.mas_right).offset(-12);
    }];

    [_tImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_ttitleLabel.mas_bottom).offset(18*((self.frame.size.width*56/73)/2)/280);
        make.centerX.equalTo(_ttitleLabel.mas_centerX);
        make.width.equalTo(@(2*(self.frame.size.width-20)/3/3));
        make.height.equalTo(@(3*(self.frame.size.width*56/73)/2/7));
    }];
    [_tpriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_thiview.mas_bottom).offset(PRICE_BOTTOM);
        make.centerX.equalTo(_ttitleLabel.mas_centerX);
    }];
    // 4
    [_fotitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_fouview.mas_top).offset(3*((self.frame.size.width*56/73)/2)/28);
        make.left.equalTo(_fouview.mas_left).offset(12);
        make.right.equalTo(_fouview.mas_right).offset(-12);
    }];
    
    [_foImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_fotitleLabel.mas_bottom).offset(18*((self.frame.size.width*56/73)/2)/280);
        make.centerX.equalTo(_fotitleLabel.mas_centerX);
        make.width.equalTo(@(2*(self.frame.size.width-20)/3/3));
        make.height.equalTo(@(3*(self.frame.size.width*56/73)/2/7));
    }];
    [_fopriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_fouview.mas_bottom).offset(PRICE_BOTTOM);
        make.centerX.equalTo(_fotitleLabel.mas_centerX);
    }];
    // 5
    [_fititleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_fivview.mas_top).offset(3*((self.frame.size.width*56/73)/2)/28);
        make.left.equalTo(_fivview.mas_left).offset(12);
        make.right.equalTo(_fivview.mas_right).offset(-12);
    }];
    
    [_fiImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_fititleLabel.mas_bottom).offset(18*((self.frame.size.width*56/73)/2)/280);
        make.centerX.equalTo(_fititleLabel.mas_centerX);
        make.width.equalTo(@(2*(self.frame.size.width-20)/3/3));
        make.height.equalTo(@(3*(self.frame.size.width*56/73)/2/7));
    }];
    [_fipriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_fivview.mas_bottom).offset(PRICE_BOTTOM);
        make.centerX.equalTo(_fititleLabel.mas_centerX);
    }];
    // 更多
    [_moreImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.left.equalTo(_fisview.mas_right);
        make.right.equalTo(_backView.mas_right);
        make.height.equalTo(_thiview.mas_height);
        
    }];
    
    [_moreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(14);
        make.left.equalTo(_fisview.mas_right).offset(13);
        
    }];
    
    [_morebt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.left.equalTo(_fisview.mas_right);
        make.right.equalTo(_backView.mas_right);
        make.height.equalTo(_thiview.mas_height);
        
    }];
    
    
    [_fisbt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.left.equalTo(_backView.mas_left);
        make.width.equalTo(@((self.frame.size.width*56/73)/4*43/14));
        make.height.equalTo(@((self.frame.size.width*56/73)/4));
    }];
    
    [_secbt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_fisview.mas_bottom);
        make.left.equalTo(_backView.mas_left);
        make.width.equalTo(@((self.frame.size.width*56/73)/4*43/14));
        make.height.equalTo(_fisview.mas_height);
    }];
    
    [_thibt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_secview.mas_bottom);
        make.left.equalTo(_backView.mas_left);
        make.width.equalTo(@((self.frame.size.width-20)/3));
        make.height.equalTo(@((self.frame.size.width*56/73)/2));
    }];
    
    [_foubt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_thiview.mas_top);
        make.left.equalTo(_thiview.mas_right);
        make.width.equalTo(@((self.frame.size.width-20)/3));
        make.height.equalTo(_thiview.mas_height);
    }];
    [_fivbt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_fouview.mas_top);
        make.left.equalTo(_fouview.mas_right);
        make.width.equalTo(@((self.frame.size.width-20)/3));
        make.height.equalTo(_thiview.mas_height);
    }];
    
    
    // 第一条线
    [_linefir mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.left.equalTo(_fisview.mas_right);
        make.width.equalTo(@(0.5));
        make.height.equalTo(_thiview.mas_height);
        
    }];
    // 第二条线
    [_linesec mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_fisview.mas_bottom);
        make.left.equalTo(_backView.mas_left);
        make.width.equalTo(_fisview.mas_width);
        make.height.equalTo(@(0.5));
    }];
    // 第三条线
    [_linethi mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_secview.mas_bottom);
        make.left.equalTo(_backView.mas_left);
        make.width.equalTo(_backView.mas_width);
        make.height.equalTo(@(0.5));
    }];
    [_linefou mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_thiview.mas_top);
        make.left.equalTo(_thiview.mas_right);
        make.width.equalTo(@(0.5));
        make.height.equalTo(_thiview.mas_height);
    }];
    [_linefiv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_thiview.mas_top);
        make.left.equalTo(_fouview.mas_right);
        make.width.equalTo(@(0.5));
        make.height.equalTo(_thiview.mas_height);
    }];
}


- (void)setModel:(JXHomepagModel *)model {
    
    _model = model;
    NSArray *infoArray = model.good[@"info"];
    [self adddateRequest:infoArray indexNumber:0 image:self.fImage titleLabel:self.ftitleLabel priceLabel:self.priceLabel];
    [self adddateRequest:infoArray indexNumber:1 image:self.sImage titleLabel:self.stitleLabel priceLabel:self.spriceLabel];
    [self adddateRequest:infoArray indexNumber:2 image:self.tImage titleLabel:self.ttitleLabel priceLabel:self.tpriceLabel];
    [self adddateRequest:infoArray indexNumber:3 image:self.foImage titleLabel:self.fotitleLabel priceLabel:self.fopriceLabel];
    [self adddateRequest:infoArray indexNumber:4 image:self.fiImage titleLabel:self.fititleLabel priceLabel:self.fipriceLabel];
    
    NSString *colorStr = model.color;
    if (colorStr.length == 12) {
        NSString *colorf = [colorStr substringWithRange:NSMakeRange(0, 6)];
        NSString *colors = [colorStr substringWithRange:NSMakeRange(6, 6)];
        [self addGradientColorView:self.colorView cgrectMake:CGRectMake(0, 0,250, 18) colorf:colorf scolor:colorf tcolor:colors];
        [self addGradientColorView:self.scolorView cgrectMake:CGRectMake(0, 0,250, 18) colorf:colorf scolor:colorf tcolor:colors];
        [_colorView.layer setMasksToBounds:YES];
        [_colorView.layer setCornerRadius:9];
        [_scolorView.layer setMasksToBounds:YES];
        [_scolorView.layer setCornerRadius:9];
        [self.tpriceLabel setTextColor:[UIColor redColor]];
        [self.fopriceLabel setTextColor:[UIColor redColor]];
        [self.fipriceLabel setTextColor:[UIColor redColor]];
        
    }
  // 需要更改的-----分类图片    http://img.1jzhw.com/2017-10-13/150787939874081.jpg
    [_moreImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Image_Url,model.phone_img]] placeholderImage:[UIImage imageNamed:@"img_分类"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
}

- (void)adddateRequest:(NSArray*)dateArray indexNumber:(NSInteger)indexNumber image:(UIImageView *)image titleLabel:(UILabel *)titleLabel priceLabel:(UILabel *)priceLabel{
    
    if (dateArray.count>indexNumber) {
        NSDictionary *dic = dateArray[indexNumber];
        UIImage *cacheImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:[NSString stringWithFormat:@"%@%@",Image_Url,dic[@"good_img"]]];
        [image setImage:cacheImage];
        [image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Image_Url,dic[@"good_img"]]] placeholderImage:[UIImage imageNamed:@"img_图片加载_小"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
        }];
        titleLabel.text = [NSString stringWithFormat:@"%@",dic[@"good_name"]];
        priceLabel.text = [NSString stringWithFormat:@"  ￥%@  ",dic[@"good_price"]];
        
    }
}

- (void)addGradientColorView:(UIView *)view cgrectMake:(CGRect)frame colorf:(NSString *)colorf scolor:(NSString *)scolor tcolor:(NSString *)tcolor{
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(id)[self colorWithHexString:colorf].CGColor,(id)[self colorWithHexString:tcolor].CGColor];
    gradientLayer.locations = @[@0,@0.5,@0.5,@1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0.5, 0);
    gradientLayer.frame = frame;
    [view.layer addSublayer:gradientLayer];
}

- (UIColor *) colorWithHexString: (NSString *)color
{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];     // String should be 6 or 8 characters
    if ([cString length] < 6)
    {
        return [UIColor clearColor];
    }
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
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
