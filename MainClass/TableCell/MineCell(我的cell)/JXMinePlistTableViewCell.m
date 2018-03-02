//
//  JXMinePlistTableViewCell.m
//  JaneCargo
//
//  Created by cxy on 2017/7/5.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXMinePlistTableViewCell.h"

@interface JXMinePlistTableViewCell ()

@property (weak, nonatomic) IBOutlet UIButton *collectionButton;
@property (weak, nonatomic) IBOutlet UIButton *addressButton;
@property (weak, nonatomic) IBOutlet UIButton *browseButto;
@property (weak, nonatomic) IBOutlet UIButton *integralButton;
@property (weak, nonatomic) IBOutlet UIButton *invoiceButton;
@property (weak, nonatomic) IBOutlet UIButton *questionButton;

@property (weak, nonatomic) IBOutlet UIView *lines;
@property (weak, nonatomic) IBOutlet UIView *linet;
@property (weak, nonatomic) IBOutlet UIView *linefo;

@end


@implementation JXMinePlistTableViewCell

+ (instancetype)cellWithTable {
    
    return  [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JXMinePlistTableViewCell class]) owner:self options:nil] lastObject];
}



- (void)awakeFromNib {
    [super awakeFromNib];
    
    [_lines setBackgroundColor:kUIColorFromRGB(0xe3e3e3)];
    [_linet setBackgroundColor:kUIColorFromRGB(0xe3e3e3)];
    [_linefo setBackgroundColor:kUIColorFromRGB(0xe3e3e3)];
    
    [_collectionButton addTarget:self action:@selector(collectionAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [_addressButton addTarget:self action:@selector(addressAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [_browseButto addTarget:self action:@selector(browseAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [_integralButton addTarget:self action:@selector(integralAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [_invoiceButton addTarget:self action:@selector(invoiceAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [_questionButton addTarget:self action:@selector(questionAction:) forControlEvents:(UIControlEventTouchUpInside)];

    
    
}

- (void)collectionAction:(UIButton *)sender {
    
    _clickplist(sender.tag);
}

- (void)addressAction:(UIButton *)sender {
    
    _clickplist(sender.tag);
}
- (void)browseAction:(UIButton *)sender {
    _clickplist(sender.tag);
    
}
- (void)integralAction:(UIButton *)sender {
    
    _clickplist(sender.tag);
}
- (void)invoiceAction:(UIButton *)sender {
    
    _clickplist(sender.tag);
}
- (void)questionAction:(UIButton *)sender {
    
    _clickplist(sender.tag);
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
