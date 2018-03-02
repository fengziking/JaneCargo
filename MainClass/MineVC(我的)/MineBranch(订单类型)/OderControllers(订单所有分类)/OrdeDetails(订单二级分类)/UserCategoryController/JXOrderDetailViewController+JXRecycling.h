//
//  JXOrderDetailViewController+JXRecycling.h
//  JaneCargo
//
//  Created by 鹏 on 2017/8/4.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXOrderDetailViewController.h"

@interface JXOrderDetailViewController (JXRecycling)

- (NSInteger)recyclingnumberOfSectionsInTableView:(UITableView *)tableView;
- (NSInteger)tableView:(UITableView *)tableView recyclingnumberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *)tableView:(UITableView *)tableView recyclingcellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)tableView recyclingdidSelectRowAtIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)tableView:(UITableView *)tableView recyclingheightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)tableView:(UITableView *)tableView recyclingheightForHeaderInSection:(NSInteger)section;
- (UIView *)tableView:(UITableView *)tableView recyclingviewForHeaderInSection:(NSInteger)section;
@end
