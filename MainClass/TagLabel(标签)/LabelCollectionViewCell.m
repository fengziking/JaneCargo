//
//  LabelCollectionViewCell.m
//  可以自动调整列数的CollectionView
//
//  Created by 鹏 on 2017/7/1.
//  Copyright © 2017年 张永强. All rights reserved.
//

#import "LabelCollectionViewCell.h"

@interface LabelCollectionViewCell ()

@property (nonatomic, strong) UILabel *label;

@end

@implementation LabelCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        _label  = [[UILabel alloc] init];
        [_label setBackgroundColor:[UIColor redColor]];
        [_label setFrame:self.bounds];
        [_label setFont:[UIFont systemFontOfSize:18.0f]];
        [self.contentView addSubview:_label];
        
        
    }
    return self;
}

- (void)setTitle:(NSString *)title {

    self.label.text = title;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
