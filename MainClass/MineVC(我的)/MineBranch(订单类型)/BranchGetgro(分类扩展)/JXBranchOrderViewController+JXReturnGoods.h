//
//  JXBranchOrderViewController+JXReturnGoods.h
//  JaneCargo
//
//  Created by 鹏 on 2017/7/10.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXBranchOrderViewController.h"

@interface JXBranchOrderViewController (JXReturnGoods)

- (NSInteger)refundNumberOfSectionsInTableView:(UITableView *)tableView;
- (NSInteger)tableView:(UITableView *)tableView refundNumberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *)tableView:(UITableView *)tableView refundCellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)tableView didrefundSelectRowAtIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)tableView:(UITableView *)tableView refundHeightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)tableView:(UITableView *)tableView refundHeightForHeaderInSection:(NSInteger)section;
- (CGFloat)tableView:(UITableView *)tableView refundheightForFooterInSection:(NSInteger)section;
@end
