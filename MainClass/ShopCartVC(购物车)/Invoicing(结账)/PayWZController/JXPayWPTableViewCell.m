//
//  JXPayWPTableViewCell.m
//  JaneCargo
//
//  Created by 鹏 on 2017/8/1.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXPayWPTableViewCell.h"

@interface JXPayWPTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *payImage;

@property (weak, nonatomic) IBOutlet UILabel *payLabel;
@property (weak, nonatomic) IBOutlet UIButton *paybt;
@property (weak, nonatomic) IBOutlet UIView *line;

@end

@implementation JXPayWPTableViewCell

+ (instancetype)cellWithTable {
    
  return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JXPayWPTableViewCell class]) owner:self options:nil] lastObject];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    [self.line setBackgroundColor:kUIColorFromRGB(0xe3e3e3)];
}

- (IBAction)paybtAction:(UIButton *)sender {

    if ([_paydotdelegate respondsToSelector:@selector(payDotTag:)]) {
        [_paydotdelegate payDotTag:sender.tag];
    }
}

- (void)setModel:(JXHomepagModel *)model {
    
    _model = model;
    _payLabel.text = model.name;
    _paybt.tag = [model.buy_num integerValue];
    _payImage.image = [UIImage imageNamed:model.img];
}

- (void)setSelectImageStr:(NSString *)selectImageStr {
    
    [_paybt setImage:[UIImage imageNamed:selectImageStr] forState:(UIControlStateNormal)];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
