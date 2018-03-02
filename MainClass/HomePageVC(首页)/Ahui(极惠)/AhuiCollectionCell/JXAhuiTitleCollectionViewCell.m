//
//  JXAhuiTitleCollectionViewCell.m
//  JaneCargo
//
//  Created by 鹏 on 2017/8/10.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXAhuiTitleCollectionViewCell.h"

@interface JXAhuiTitleCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *comprehensivelabel;
@property (weak, nonatomic) IBOutlet UIButton *comprehensivebt;

@property (weak, nonatomic) IBOutlet UILabel *salesLabel;
@property (weak, nonatomic) IBOutlet UIImageView *salesImage;
@property (weak, nonatomic) IBOutlet UIButton *salesbt;

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *priceImage;
@property (weak, nonatomic) IBOutlet UIButton *pricebt;


@property (weak, nonatomic) IBOutlet UIImageView *collectionImage;
@property (weak, nonatomic) IBOutlet UIButton *collectionbt;



@property (weak, nonatomic) IBOutlet UIView *line;

@end

@implementation JXAhuiTitleCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

#pragma mark ----- tag 0-综合 1-销量 2-价格 3-九宫
- (IBAction)comprehensiveAction:(UIButton *)sender {
    
    [self changeColorRed:_comprehensivelabel whitelabel:_salesLabel swhitelabel:_priceLabel twhitelabel:nil];
    [_salesImage setImage:[UIImage imageNamed:@"icon_价格筛选"]];
    [_priceImage setImage:[UIImage imageNamed:@"icon_价格筛选"]];
    if ([_sortingdelegate respondsToSelector:@selector(sortinggood:boolclick:)]) {
        [_sortingdelegate sortinggood:sender.tag boolclick:sender.selected];
    }
    
}


- (IBAction)salesAction:(UIButton *)sender {
    
    [self changeColorRed:_salesLabel whitelabel:_comprehensivelabel swhitelabel:_priceLabel twhitelabel:nil];
    sender.selected = !sender.selected;
    if (sender.selected) {
        [_salesImage setImage:[UIImage imageNamed:@"icon_价格筛选_倒序"]];
    }else {
        [_salesImage setImage:[UIImage imageNamed:@"icon_价格筛选_升序"]];
    }
    [_priceImage setImage:[UIImage imageNamed:@"icon_价格筛选"]];
    if ([_sortingdelegate respondsToSelector:@selector(sortinggood:boolclick:)]) {
        [_sortingdelegate sortinggood:sender.tag boolclick:sender.selected];
    }
}


- (IBAction)priceAction:(UIButton *)sender {
    
    [self changeColorRed:_priceLabel whitelabel:_salesLabel swhitelabel:_comprehensivelabel twhitelabel:nil];
    sender.selected = !sender.selected;
    if (sender.selected) {
        [_priceImage setImage:[UIImage imageNamed:@"icon_价格筛选_倒序"]];
    }else {
        [_priceImage setImage:[UIImage imageNamed:@"icon_价格筛选_升序"]];
    }
    [_salesImage setImage:[UIImage imageNamed:@"icon_价格筛选"]];
    if ([_sortingdelegate respondsToSelector:@selector(sortinggood:boolclick:)]) {
        [_sortingdelegate sortinggood:sender.tag boolclick:sender.selected];
    }
}


- (IBAction)collectionAction:(UIButton *)sender {
    
    [self changeColorRed:nil whitelabel:_salesLabel swhitelabel:_priceLabel twhitelabel:_comprehensivelabel];
    sender.selected = !sender.selected;
    if (sender.selected) {
        [_collectionImage setImage:[UIImage imageNamed:@"icon_切换竖排"]];
    }else {
        [_collectionImage setImage:[UIImage imageNamed:@"icon_切换横排"]];
    }
    [_salesImage setImage:[UIImage imageNamed:@"icon_价格筛选"]];
    [_priceImage setImage:[UIImage imageNamed:@"icon_价格筛选"]];
    if ([_sortingdelegate respondsToSelector:@selector(sortinggood:boolclick:)]) {
        [_sortingdelegate sortinggood:sender.tag boolclick:sender.selected];
    }
}




#pragma mark -- 改变颜色
- (void)changeColorRed:(UILabel *)redlabel whitelabel:(UILabel *)whiteLabel swhitelabel:(UILabel *)swhiteLabel twhitelabel:(UILabel *)twhitelabel{
    
    [redlabel setTextColor:[UIColor redColor]];
    [whiteLabel setTextColor:[UIColor blackColor]];
    [swhiteLabel setTextColor:[UIColor blackColor]];
    [twhitelabel setTextColor:[UIColor blackColor]];
}







@end
