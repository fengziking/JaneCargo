//
//  JXHisRecordTableViewCell.m
//  JaneCargo
//
//  Created by 鹏 on 2017/7/13.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXHisRecordTableViewCell.h"

@interface JXHisRecordTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *hisLabel;

@property (weak, nonatomic) IBOutlet UIView *line;

@end

@implementation JXHisRecordTableViewCell


+ (instancetype)cellWithTable {

    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JXHisRecordTableViewCell class]) owner:self options:nil] lastObject];
}



- (void)awakeFromNib {
    [super awakeFromNib];
    [_line setBackgroundColor:kUIColorFromRGB(0xe3e3e3)];
    [_hisLabel setTextColor:kUIColorFromRGB(0x999999)];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

- (void)setY_title:(NSString *)y_title {
    self.hisLabel.text = [JXJudgeStrObjc judgestr:y_title];
}



@end
