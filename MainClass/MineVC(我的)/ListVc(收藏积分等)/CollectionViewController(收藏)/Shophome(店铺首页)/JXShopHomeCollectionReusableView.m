//
//  JXShopHomeCollectionReusableView.m
//  JaneCargo
//
//  Created by 鹏 on 2017/8/8.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXShopHomeCollectionReusableView.h"

@interface JXShopHomeCollectionReusableView ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *fImage;
@property (nonatomic, strong) UIImageView *sImage;
@end


@implementation JXShopHomeCollectionReusableView

- (void)awakeFromNib {
    [super awakeFromNib];
    
}


- (instancetype)initWithFrame:(CGRect)frame {
    
    
    if (self = [super initWithFrame:frame]) {
        
        self.titleLabel = [[UILabel alloc] init];
        [self.titleLabel setFont:[UIFont systemFontOfSize:16.0f]];
        [self addSubview:self.titleLabel];
        
        self.fImage = [[UIImageView alloc] init];
        [self addSubview:self.fImage];
        self.sImage = [[UIImageView alloc] init];
        [self addSubview:self.sImage];
        
        [self.fImage setImage:[UIImage imageNamed:@"icon_adorn"]];
        [self.sImage setImage:[UIImage imageNamed:@"icon_adorn"]];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat titleW = [JXEncapSulationObjc stringWidth:self.titleLabel.text maxSize:NPWidth fontSize:16.0f];
    [self.titleLabel setFrame:CGRectMake((NPWidth-titleW)/2, 14, titleW, 16)];
    [self.fImage setFrame:CGRectMake(CGRectGetMinX(self.titleLabel.frame)-15-12, 14.5, 15, 15)];
    [self.sImage setFrame:CGRectMake(CGRectGetMaxX(self.titleLabel.frame)+12, 14.5, 15, 15)];
    
}
- (void)setTitle:(NSString *)title {
    self.titleLabel.text = title;
    [self layoutSubviews];
    
}


















@end
