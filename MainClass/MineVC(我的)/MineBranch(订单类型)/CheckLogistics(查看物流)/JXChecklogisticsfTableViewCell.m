//
//  JXChecklogisticsfTableViewCell.m
//  JaneCargo
//
//  Created by 鹏 on 2017/8/11.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXChecklogisticsfTableViewCell.h"

@interface JXChecklogisticsfTableViewCell ()

@property (weak, nonatomic) IBOutlet UIView *line;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;


@end

@implementation JXChecklogisticsfTableViewCell

+ (instancetype)cellWithTable {

    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JXChecklogisticsfTableViewCell class]) owner:self options:nil] lastObject];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    [self.line setBackgroundColor:kUIColorFromRGB(0xe3e3e3)];
    
}


- (void)setTitle:(NSString *)title
{
    self.titleLabel.text = title;
}

- (void)setModel:(JXHomepagModel *)model {

    _model = model;
    switch (model.type_model) {
        
        case 0:
        {
            self.contentLabel.text = model.com;
            [self.contentLabel setTextColor:kUIColorFromRGB(0x333333)];
        }
            break;
        case 1:
        {
            self.contentLabel.text = model.nu;
            [self.contentLabel setTextColor:kUIColorFromRGB(0x0960cc)];
        }
            break;
        default:
            break;
    }
}


- (NSString *)expressCargostatus:(NSString *)status {

    NSString *expressType;
    if ([status isEqualToString:@"0"]) {
        expressType = @"在途中";
    }else if ([status isEqualToString:@"1"]) {
        expressType = @"已揽收";
    }else if ([status isEqualToString:@"3"]) {
        expressType = @"已签收";
    }else if ([status isEqualToString:@"4"]) {
        expressType = @"退签";
    }else if ([status isEqualToString:@"5"]) {
        expressType = @"同城派送中";
    }else if ([status isEqualToString:@"6"]) {
        expressType = @"退回";
    }else if ([status isEqualToString:@"7"]) {
        expressType = @"转单中";
    }
    return expressType;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
