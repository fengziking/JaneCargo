//
//  JXSetUpContactTableViewCell.m
//  JaneCargo
//
//  Created by cxy on 2017/7/5.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXSetUpContactTableViewCell.h"

@interface JXSetUpContactTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UIView *lines;


@end

@implementation JXSetUpContactTableViewCell


+ (instancetype)cellWithTable {
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JXSetUpContactTableViewCell class]) owner:self options:nil] lastObject];
}



- (void)awakeFromNib {
    [super awakeFromNib];
    [self.lines setBackgroundColor:kUIColorFromRGB(0xe3e3e3)];
}


- (void)setTitle:(NSString *)title {
    self.titleLabel.text = title;
}

- (void)setNumber:(NSString *)number row:(NSInteger)row {

    switch (row) {
        case 0: { // shouji
            [_numberLabel setText:number];
        }
            break;
        case 1: {
            [_numberLabel setText:number];
        }
            break;
        case 2: {
            
            if (number.length>6) {
                [_numberLabel setText:@"已绑定"];
            }else {
                [_numberLabel setText:@"未绑定"];
            }
            _numberLabel.textColor = kUIColorFromRGB(0x0960cc);
        }
            break;
        case 3: {
            if ([number integerValue] == 1) {
                [_numberLabel setText:@"男"];
            }else if ([number integerValue] == 2) {
                [_numberLabel setText:@"女"];
            }
        }
            break;
//        case 3: {
//
//
//        }
//            break;
        default:
            break;
    }
}


- (void)setNumber:(NSString *)number {
    self.numberLabel.text = number;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
