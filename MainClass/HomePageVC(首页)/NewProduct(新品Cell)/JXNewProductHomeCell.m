//
//  JXNewProductHomeCell.m
//  JaneCargo
//
//  Created by 鹏 on 2017/10/9.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXNewProductHomeCell.h"

@interface JXNewProductHomeCell ()

@property (weak, nonatomic) IBOutlet UILabel *newgoodLabel;
@property (weak, nonatomic) IBOutlet UIButton *newgoodbt;

@property (weak, nonatomic) IBOutlet UILabel *cakeslabel;
@property (weak, nonatomic) IBOutlet UIButton *cakesbt;

@property (weak, nonatomic) IBOutlet UILabel *huilabel;
@property (weak, nonatomic) IBOutlet UIButton *huibt;

@end


@implementation JXNewProductHomeCell


+ (instancetype)cellWithTable {

  return  [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JXNewProductHomeCell class]) owner:self options:nil] lastObject];
}

- (void)awakeFromNib {
    [super awakeFromNib];
   // [self.newgoodLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:12.0f]];
   // [self.cakeslabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:12.0f]];
   // [self.huilabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:12.0f]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)newbtAction:(UIButton *)sender {
    _ification(sender.tag);
}
- (IBAction)cakesbtAction:(UIButton *)sender {
    _ification(sender.tag);
}
- (IBAction)huibtAction:(UIButton *)sender {
    _ification(sender.tag);
}

@end
