//
//  JXClassificationTableViewCell.m
//  JaneCargo
//
//  Created by cxy on 2017/6/23.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXClassificationTableViewCell.h"

#define iMAGEHW 48

@interface JXClassificationTableViewCell () {

    // 产品
    UIButton *productButton;
    UILabel *productLabel;
    // 团购
    UIButton *bulkButton;
    UILabel *bulkLabel;
    // 清仓
    UIButton *clearButton;
    UILabel *clearLabel;
    // 优惠
    UIButton *preferentialButton;
    UILabel *preferentialLabel;
    
}
@end

@implementation JXClassificationTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self jxClassLayOut];
    }
    return self;
}


- (void)jxClassLayOut {

    productButton = [[UIButton alloc] init];
    bulkButton = [[UIButton alloc] init];
    clearButton = [[UIButton alloc] init];
    preferentialButton = [[UIButton alloc] init];
    
    productButton.tag = 0;
    bulkButton.tag = 1;
    clearButton.tag = 2;
    preferentialButton.tag = 3;
    
    productLabel = [[UILabel alloc] init];
    bulkLabel = [[UILabel alloc] init];
    clearLabel = [[UILabel alloc] init];
    preferentialLabel = [[UILabel alloc] init];
    
    
    [productLabel setText:HomePageNewGoodImage_Text];
    [bulkLabel setText:HomePageBulkImage_Text];
    [clearLabel setText:HomePageIntegralImage_Text];
    [preferentialLabel setText:HomePageAhuiImage_Text];
    [productButton setImage:[UIImage imageNamed:HomePageNewGoodImage] forState:(UIControlStateNormal)];
    [bulkButton setImage:[UIImage imageNamed:HomePageBulkImage] forState:(UIControlStateNormal)];
    [clearButton setImage:[UIImage imageNamed:HomePageIntegralImage] forState:(UIControlStateNormal)];
    [preferentialButton setImage:[UIImage imageNamed:HomePageAhuiImage] forState:(UIControlStateNormal)];
    productButton.contentMode = UIViewContentModeScaleToFill;
    bulkButton.contentMode = UIViewContentModeScaleToFill;
    clearButton.contentMode = UIViewContentModeScaleToFill;
    preferentialButton.contentMode = UIViewContentModeScaleToFill;
    
    [productLabel setTextAlignment:(NSTextAlignmentCenter)];
    [bulkLabel setTextAlignment:(NSTextAlignmentCenter)];
    [clearLabel setTextAlignment:(NSTextAlignmentCenter)];
    [preferentialLabel setTextAlignment:(NSTextAlignmentCenter)];
    
    [productLabel setFont:[UIFont systemFontOfSize:12.0f]];
    [bulkLabel setFont:[UIFont systemFontOfSize:12.0f]];
    [clearLabel setFont:[UIFont systemFontOfSize:12.0f]];
    [preferentialLabel setFont:[UIFont systemFontOfSize:12.0f]];
    
    
    
    [productButton addTarget:self action:@selector(productAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [bulkButton addTarget:self action:@selector(bulkAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [clearButton addTarget:self action:@selector(clearAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [preferentialButton addTarget:self action:@selector(preferentialAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self.contentView addSubview:productButton];
    [self.contentView addSubview:bulkButton];
    [self.contentView addSubview:clearButton];
    [self.contentView addSubview:preferentialButton];
    [self.contentView addSubview:productLabel];
    [self.contentView addSubview:bulkLabel];
    [self.contentView addSubview:clearLabel];
    [self.contentView addSubview:preferentialLabel];
    
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    [productButton setFrame:CGRectMake((NPWidth/4-48)/2, 11, iMAGEHW, iMAGEHW)];
    [bulkButton setFrame:CGRectMake(CGRectGetMaxX(productButton.frame)+(NPWidth/4-48), 11, iMAGEHW, iMAGEHW)];
    [clearButton setFrame:CGRectMake(CGRectGetMaxX(bulkButton.frame)+(NPWidth/4-48), 11, iMAGEHW, iMAGEHW)];
    [preferentialButton setFrame:CGRectMake(CGRectGetMaxX(clearButton.frame)+(NPWidth/4-48), 11, iMAGEHW, iMAGEHW)];
    
    [productLabel setFrame:CGRectMake(0, CGRectGetMaxY(productButton.frame)+7, NPWidth/4, 12)];
    [bulkLabel setFrame:CGRectMake(CGRectGetMaxX(productLabel.frame), CGRectGetMaxY(productButton.frame)+7, NPWidth/4, 12)];
    [clearLabel setFrame:CGRectMake(CGRectGetMaxX(bulkLabel.frame), CGRectGetMaxY(productButton.frame)+7, NPWidth/4, 12)];
    [preferentialLabel setFrame:CGRectMake(CGRectGetMaxX(clearLabel.frame), CGRectGetMaxY(productButton.frame)+7, NPWidth/4, 12)];
}

// 点击事件
- (void)productAction:(UIButton *)sender {
    _ification(sender.tag);
}
- (void)bulkAction:(UIButton *)sender {
    _ification(sender.tag);
}
- (void)clearAction:(UIButton *)sender {
    _ification(sender.tag);
}
- (void)preferentialAction:(UIButton *)sender {
    _ification(sender.tag);
}

-(void)setModel:(JXHomepagModel *)model {

    _model = model;
    
}




- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
