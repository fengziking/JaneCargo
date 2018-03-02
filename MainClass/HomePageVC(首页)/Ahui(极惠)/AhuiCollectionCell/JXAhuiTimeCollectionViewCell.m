//
//  JXAhuiTimeCollectionViewCell.m
//  JaneCargo
//
//  Created by 鹏 on 2017/8/10.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXAhuiTimeCollectionViewCell.h"

@interface JXAhuiTimeCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
 // hours minutes seconds

@property (weak, nonatomic) IBOutlet UILabel *hoursLabel;
@property (weak, nonatomic) IBOutlet UILabel *minutesLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondsLabel;

@end

@implementation JXAhuiTimeCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [JXContTextObjc changelabelColor:self.titleLabel range:NSMakeRange(0, 2) color:[UIColor redColor]];
//    _hoursLabel.text = @" 10 ";
//    _minutesLabel.text = @" 10 ";
//    _secondsLabel.text = @" 10 ";
}

@end
