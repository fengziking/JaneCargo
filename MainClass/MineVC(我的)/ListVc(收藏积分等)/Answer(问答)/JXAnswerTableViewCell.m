//
//  JXAnswerTableViewCell.m
//  JaneCargo
//
//  Created by 鹏 on 2017/8/9.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXAnswerTableViewCell.h"

@interface JXAnswerTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *contentlabel;

@property (weak, nonatomic) IBOutlet UIImageView *answerImage;
@property (weak, nonatomic) IBOutlet UIView *line;

@end

@implementation JXAnswerTableViewCell


+ (instancetype)cellWithTable {
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JXAnswerTableViewCell class]) owner:self options:nil] lastObject];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    [self setSelectionStyle:(UITableViewCellSelectionStyleNone)];
}


- (void)setModel:(JXHomepagModel *)model {

    _model = model;
    if (model.type_model == 0) {
        
        [self.iconImage setImage:[UIImage imageNamed:@"icon_问题"]];
        [self.contentlabel setText:model.question];
        [self layoutIfNeeded];
        model.cellHeight = CGRectGetMaxY(self.contentlabel.frame)+15;
        [self.line setBackgroundColor:kUIColorFromRGB(0xe3e3e3)];
        
    }else if (model.type_model == 1) {
        
        [self.iconImage setImage:[UIImage imageNamed:@"icon_解答"]];
        if ([[NSString stringWithFormat:@"%@",model.answer] isEqualToString:@"null"]) {
            [self.contentlabel setText:model.answer];
        }else {
            [self.contentlabel setText:@"专家未解答"];
            [self.answerImage setImage:[UIImage imageNamed:@"icon_等待解答"]];
        }
        [self.line setBackgroundColor:[UIColor whiteColor]];
        [self layoutIfNeeded];
        model.cellHeight = CGRectGetMaxY(self.contentlabel.frame)+15;
    }
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
