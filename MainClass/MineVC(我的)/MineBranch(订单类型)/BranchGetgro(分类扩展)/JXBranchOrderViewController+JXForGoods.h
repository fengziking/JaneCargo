//
//  JXBranchOrderViewController+JXForGoods.h
//  JaneCargo
//
//  Created by 鹏 on 2017/7/10.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXBranchOrderViewController.h"

@interface JXBranchOrderViewController (JXForGoods)

- (NSInteger)goodsNumberOfSectionsInTableView:(UITableView *)tableView;
- (NSInteger)tableView:(UITableView *)tableView goodsNumberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *)tableView:(UITableView *)tableView goodsCellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)tableView didgoodsSelectRowAtIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)tableView:(UITableView *)tableView goodsHeightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)tableView:(UITableView *)tableView goodsHeightForHeaderInSection:(NSInteger)section;
- (CGFloat)tableView:(UITableView *)tableView goodsheightForFooterInSection:(NSInteger)section;
@end
