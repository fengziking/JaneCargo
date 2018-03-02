//
//  JXGoodDetailView.m
//  JaneCargo
//
//  Created by 鹏 on 2017/9/12.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXGoodDetailView.h"

@implementation JXGoodDetailView

- (instancetype)init {
    if (self == [super init]) {
        [self setUp];
    }
    return self;
}

- (void)setUp {
    
    self.detailTable = [[UITableView alloc]init];
    self.detailTable.frame = CGRectMake(0, 0, NPWidth, NPHeight-50);
    [self addSubview:self.detailTable];
    [self setUpFootLabel];
}


- (void)setUpFootLabel {
    
    self.footLabel = [[UILabel alloc]init];
    self.footLabel.frame = CGRectMake(0, 0, NPWidth, 45);
    self.footLabel.textAlignment = NSTextAlignmentCenter;
    self.footLabel.text = @"——————  往下查看产品参数  ——————";
    self.footLabel.font = [UIFont systemFontOfSize:14.0f];
    [self.footLabel setTextColor:kUIColorFromRGB(0x999999)];
    self.detailTable.tableFooterView = self.footLabel;
    [self.detailTable setBackgroundColor:kUIColorFromRGB(0xf2f2f2)];
}


@end
