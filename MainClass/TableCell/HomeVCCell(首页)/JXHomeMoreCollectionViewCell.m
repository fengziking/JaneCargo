//
//  JXHomeMoreCollectionViewCell.m
//  JaneCargo
//
//  Created by 鹏 on 2017/8/15.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXHomeMoreCollectionViewCell.h"

@interface JXHomeMoreCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *hoursLabel;
@property (weak, nonatomic) IBOutlet UILabel *minutesLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondsLabel;
@property (weak, nonatomic) IBOutlet UIView *line;

@end

@implementation JXHomeMoreCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.line setBackgroundColor:kUIColorFromRGB(0xCCCCCC)];
    NSMutableAttributedString *content = [[NSMutableAttributedString alloc]initWithString:self.titleLabel.text];
    [content addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0,2)];
    self.titleLabel.attributedText = content;
}



- (IBAction)btAction:(UIButton *)sender {
    
    
}

@end
