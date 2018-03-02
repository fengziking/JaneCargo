//
//  JXBranchOrderViewController+JXsendGoods.h
//  JaneCargo
//
//  Created by 鹏 on 2017/7/10.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXBranchOrderViewController.h"

@interface JXBranchOrderViewController (JXsendGoods)

- (NSInteger)sendNumberOfSectionsInTableView:(UITableView *)tableView;
- (NSInteger)tableView:(UITableView *)tableView sendNumberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *)tableView:(UITableView *)tableView sendCellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)tableView didsendSelectRowAtIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)tableView:(UITableView *)tableView sendHeightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)tableView:(UITableView *)tableView sendHeightForHeaderInSection:(NSInteger)section;

- (CGFloat)tableView:(UITableView *)tableView sendheightForFooterInSection:(NSInteger)section;
@end
