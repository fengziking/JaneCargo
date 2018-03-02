//
//  EvaluationOrderCell.m
//  Evaluation
//
//  Created by 鹏 on 2017/9/14.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "EvaluationOrderCell.h"

@interface EvaluationOrderCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *orderNumber;

@property (weak, nonatomic) IBOutlet UIView *lineView;

@end


@implementation EvaluationOrderCell


+ (instancetype)cellWithTable {

    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([EvaluationOrderCell class]) owner:self options:nil] lastObject];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setSelectionStyle:(UITableViewCellSelectionStyleNone)];
    [self.lineView setBackgroundColor:kUIColorFromRGB(0xe3e3e3)];
}
- (void)setModel:(MKOrderListModel *)model {

    self.orderNumber.text = model.ordersn;
}
- (void)setTitle:(NSString *)title {
    self.titleLabel.text = title;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
