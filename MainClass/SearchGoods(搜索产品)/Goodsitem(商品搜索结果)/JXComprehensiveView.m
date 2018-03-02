//
//  JXComprehensiveView.m
//  JaneCargo
//
//  Created by 鹏 on 2017/7/14.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXComprehensiveView.h"


@interface JXComprehensiveView ()

@property (weak, nonatomic) IBOutlet UILabel *sortingLabel;

@property (weak, nonatomic) IBOutlet UILabel *productLabel;

@property (weak, nonatomic) IBOutlet UILabel *commentsLabel;

@property (weak, nonatomic) IBOutlet UIImageView *sortingImage;

@property (weak, nonatomic) IBOutlet UIImageView *productImage;

@property (weak, nonatomic) IBOutlet UIImageView *commenImage;

@property (weak, nonatomic) IBOutlet UIButton *sortingButton;

@property (weak, nonatomic) IBOutlet UIButton *productButton;

@property (weak, nonatomic) IBOutlet UIButton *commenButton;

@end


@implementation JXComprehensiveView



- (IBAction)sortingAction:(UIButton *)sender {
    
    [_sortingLabel setTextColor:[UIColor redColor]];
    [_sortingImage setImage:[UIImage imageNamed:@"icon_排序选择"]];
    [_productLabel setTextColor:[UIColor blackColor]];
    [_commentsLabel setTextColor:[UIColor blackColor]];
    [_productImage setImage:[UIImage imageNamed:@""]];
    [_commenImage setImage:[UIImage imageNamed:@""]];
    
    _sequen(sender.tag);
    
}


- (IBAction)productAction:(UIButton *)sender {
    
    [_productLabel setTextColor:[UIColor redColor]];
    [_productImage setImage:[UIImage imageNamed:@"icon_排序选择"]];
    [_sortingLabel setTextColor:[UIColor blackColor]];
    [_commentsLabel setTextColor:[UIColor blackColor]];
    [_sortingImage setImage:[UIImage imageNamed:@""]];
    [_commenImage setImage:[UIImage imageNamed:@""]];
    _sequen(sender.tag);
}

- (IBAction)commenAction:(UIButton *)sender {
    
    [_commentsLabel setTextColor:[UIColor redColor]];
    [_commenImage setImage:[UIImage imageNamed:@"icon_排序选择"]];
    [_productLabel setTextColor:[UIColor blackColor]];
    [_sortingLabel setTextColor:[UIColor blackColor]];
    [_productImage setImage:[UIImage imageNamed:@""]];
    [_sortingImage setImage:[UIImage imageNamed:@""]];
    _sequen(sender.tag);
}






@end
