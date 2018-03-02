//
//  JXCourierTableViewCell.m
//  JaneCargo
//
//  Created by cxy on 2017/6/27.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXCourierTableViewCell.h"

@interface JXCourierTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *salesLabel;

@property (weak, nonatomic) IBOutlet UILabel *courierLabel;
@property (weak, nonatomic) IBOutlet UIView *colorView;

@end


@implementation JXCourierTableViewCell


+ (instancetype)cellWithTable {

    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JXCourierTableViewCell class]) owner:self options:nil] lastObject];
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
    [self.colorView setBackgroundColor:kUIColorFromRGB(0xe3e3e3)];
    
}

- (void)setModel:(JXHomepagModel *)model {

    _model = model;
    if (model.buy_num!=nil) {
        [_salesLabel setText:[NSString stringWithFormat:@"月销量：%@",model.buy_num]];
        NSMutableAttributedString *content = [[NSMutableAttributedString alloc]initWithString:self.salesLabel.text];
        [content addAttribute:NSForegroundColorAttributeName
                        value:[UIColor blackColor]
                        range:NSMakeRange(0,4)];
        self.salesLabel.attributedText = content;
    }
    if ([[NSString stringWithFormat:@"%@",model.count] isEqualToString:@"0"]) {
        [_courierLabel setText:@"好评度：暂无好评"];
    }else {
        if (model.count!=nil) {
            [_courierLabel setText:[NSString stringWithFormat:@"好评度：%@",model.count]];
        }
        
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
