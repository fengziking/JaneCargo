//
//  JXBranchOrderTableViewCell.m
//  JaneCargo
//
//  Created by cxy on 2017/7/7.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXBranchOrderTableViewCell.h"

@interface JXBranchOrderTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;


@end

@implementation JXBranchOrderTableViewCell



+ (instancetype)cellWithTable {

    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JXBranchOrderTableViewCell class]) owner:self options:nil] lastObject];
}



- (void)awakeFromNib {
    [super awakeFromNib];
    [self setSelectionStyle:(UITableViewCellSelectionStyleNone)];
    [self.contentLabel setTextColor:kUIColorFromRGB(0xef5b4c)];
}



- (void)setModel:(MKOrderListModel *)model {
    
    _model = model;
    NSString *goods_name = [JXJudgeStrObjc judgestr:model.nickname];
    if (goods_name.length>10) {
        goods_name = [NSString stringWithFormat:@"%@...",[goods_name substringWithRange:NSMakeRange(0, 7)]];
    }
    self.nameLabel.text = goods_name;
    self.contentLabel.text = [JXJudgeStrObjc judgeType:model recycle:0];

}

- (void)setHiddenStart:(BOOL)hiddenStart {
    [self.contentLabel setHidden:hiddenStart];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
