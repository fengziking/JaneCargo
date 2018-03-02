//
//  JXInvoicingTitleShopTableViewCell.m
//  JaneCargo
//
//  Created by 鹏 on 2017/7/28.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXInvoicingTitleShopTableViewCell.h"
#import "MKOrderListModel.h"
@interface JXInvoicingTitleShopTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIView *line;


@end

@implementation JXInvoicingTitleShopTableViewCell


+ (instancetype)cellWithTable {
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JXInvoicingTitleShopTableViewCell class]) owner:self options:nil] lastObject];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    [self.line setBackgroundColor:kUIColorFromRGB(0xcccccc)];
}

- (void)setListmodel:(MKOrderListModel *)listmodel {
    
    _listmodel = listmodel;
    _titleLabel.text = listmodel.nickname;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
