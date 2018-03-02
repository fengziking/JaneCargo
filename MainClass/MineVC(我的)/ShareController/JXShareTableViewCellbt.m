//
//  JXShareTableViewCellbt.m
//  JaneCargo
//
//  Created by 鹏 on 2018/1/26.
//  Copyright © 2018年 鹏. All rights reserved.
//

#import "JXShareTableViewCellbt.h"

@interface JXShareTableViewCellbt ()

@property (weak, nonatomic) IBOutlet UIButton *sharebt;


@end

@implementation JXShareTableViewCellbt

+ (instancetype)cellwithTable {
    
    return  [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JXShareTableViewCellbt class]) owner:self options:nil] lastObject];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setSelectionStyle:(UITableViewCellSelectionStyleNone)];
    self.backgroundColor = kUIColorFromRGB(0xf2f2f2);
    [self.sharebt setBackgroundColor:kUIColorFromRGB(0xef5b4c)];
    [self.sharebt.layer setMasksToBounds:true];
    [self.sharebt.layer setCornerRadius:5.0];
}

- (void)setModel:(JXHomepagModel *)model {
    
    _model = model;
    if ([[NSString stringWithFormat:@"%@",model.is_dl] isEqualToString:@"1"]) { // 已付款
        [self.sharebt setBackgroundColor:kUIColorFromRGB(0xcccccc)];
        [self.sharebt setTitle:@"已是邀请账户，快去邀请好友吧！" forState:(UIControlStateNormal)];
        [self.sharebt setEnabled:NO];
    }
    
}


- (IBAction)sharebtAction:(UIButton *)sender {
    
    _Paychose();
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
