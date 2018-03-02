//
//  EvaluationSubmitCell.m
//  Evaluation
//
//  Created by 鹏 on 2017/9/14.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "EvaluationSubmitCell.h"

@interface EvaluationSubmitCell ()

@property (weak, nonatomic) IBOutlet UIButton *submitbt;
@property (weak, nonatomic) IBOutlet UIView *colorview;

@end



@implementation EvaluationSubmitCell


+ (instancetype)cellWithTable {
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([EvaluationSubmitCell class]) owner:self options:nil] lastObject];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    [self setBackgroundColor:kUIColorFromRGB(0xf1f1f1)];
    [self.colorview.layer setMasksToBounds:YES];
    [self.colorview.layer setCornerRadius:5];
//    [self.submitbt setBackgroundColor:kUIColorFromRGB(0xef5b4c)];
    [JXEncapSulationObjc addGradientColorView:self.colorview cgrectMake:CGRectMake(0, 0, NPWidth, 45) colors:@[(id)kUIColorFromRGB(0xef5b4c).CGColor, (id)kUIColorFromRGB(0xe82b48).CGColor]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)submitAction:(UIButton *)sender {
    
    if ([_subitdelegate respondsToSelector:@selector(submit)]) {
        [_subitdelegate submit];
    }
}

@end
