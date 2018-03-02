//
//  JXShareTableViewCellf.m
//  JaneCargo
//
//  Created by 鹏 on 2018/1/25.
//  Copyright © 2018年 鹏. All rights reserved.
//

#import "JXShareTableViewCellf.h"

@interface JXShareTableViewCellf()

@property (weak, nonatomic) IBOutlet UIView *backview;
@property (weak, nonatomic) IBOutlet UILabel *netLabel;
@property (weak, nonatomic) IBOutlet UIButton *fxbt;

@end


@implementation JXShareTableViewCellf



+ (instancetype)cellwithTable {
    
   return  [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JXShareTableViewCellf class]) owner:self options:nil] lastObject];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setSelectionStyle:(UITableViewCellSelectionStyleNone)];
    self.backgroundColor = kUIColorFromRGB(0xf2f2f2);
    [self.backview.layer setMasksToBounds:true];
    [self.backview.layer setCornerRadius:5.0];
    [self.fxbt.layer setMasksToBounds:true];
    [self.fxbt.layer setCornerRadius:3.0];
    [self.fxbt setBackgroundColor:kUIColorFromRGB(0x333333)];
    
    [self.netLabel.layer setBorderWidth:0.5];
    [self.netLabel.layer setBorderColor:[kUIColorFromRGB(0xcccccc) CGColor]];
    [self.netLabel setBackgroundColor:kUIColorFromRGB(0xfafafa)];
    [self.netLabel setTextColor:kUIColorFromRGB(0x999999)];
}


- (void)setModel:(JXHomepagModel *)model {
    
    _model = model;
    _netLabel.text = model.url;
    
}

- (IBAction)fxbtAction:(UIButton *)sender {
    
    _ShareUrlblock();
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
