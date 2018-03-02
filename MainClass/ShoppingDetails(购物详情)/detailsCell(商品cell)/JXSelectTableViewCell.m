//
//  JXSelectTableViewCell.m
//  JaneCargo
//
//  Created by cxy on 2017/6/27.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXSelectTableViewCell.h"

@interface JXSelectTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *selectLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIView *colorView;


@end


@implementation JXSelectTableViewCell

+ (instancetype)cellWithTable {
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JXSelectTableViewCell class]) owner:self options:nil] lastObject];
}



- (void)setModel:(JXHomepagModel *)model {
    
    _model = model;
    [_contentLabel setText:[NSString stringWithFormat:@"%@/￥%@(库存:%@)",model.key_name,model.price,model.store_count]];
    
    
}
- (void)setTitle:(NSString *)title {
    _selectLabel.text = title;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [_colorView setBackgroundColor:kUIColorFromRGB(0xe3e3e3)];
    [_selectLabel setTextColor:kUIColorFromRGB(0x999999)];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
