//
//  JXBranchOrderViewController+JXAllBranch.h
//  JaneCargo
//
//  Created by 鹏 on 2017/7/10.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXBranchOrderViewController.h"

@interface JXBranchOrderViewController (JXAllBranch)


- (NSInteger)allNumberOfSectionsInTableView:(UITableView *)tableView;
- (NSInteger)tableView:(UITableView *)tableView allNumberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *)tableView:(UITableView *)tableView allCellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)tableView didAllSelectRowAtIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)tableView:(UITableView *)tableView allHeightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)tableView:(UITableView *)tableView allHeightForHeaderInSection:(NSInteger)section;


- (CGFloat)tableView:(UITableView *)tableView allheightForFooterInSection:(NSInteger)section;

@end
