//
//  JXBranchOrderViewController+JXPaymentController.h
//  JaneCargo
//
//  Created by 鹏 on 2017/7/10.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXBranchOrderViewController.h"

@interface JXBranchOrderViewController (JXPaymentController)

- (NSInteger)payNumberOfSectionsInTableView:(UITableView *)tableView;
- (NSInteger)tableView:(UITableView *)tableView payNumberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *)tableView:(UITableView *)tableView payCellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)tableView didpaySelectRowAtIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)tableView:(UITableView *)tableView payHeightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)tableView:(UITableView *)tableView payHeightForHeaderInSection:(NSInteger)section;

- (CGFloat)tableView:(UITableView *)tableView payheightForFooterInSection:(NSInteger)section;
@end
