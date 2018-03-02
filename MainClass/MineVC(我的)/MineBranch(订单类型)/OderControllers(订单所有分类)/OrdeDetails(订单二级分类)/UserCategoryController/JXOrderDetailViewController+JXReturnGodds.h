//
//  JXOrderDetailViewController+JXReturnGodds.h
//  JaneCargo
//
//  Created by 鹏 on 2017/8/4.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXOrderDetailViewController.h"

@interface JXOrderDetailViewController (JXReturnGodds)

- (NSInteger)returnGoddsnumberOfSectionsInTableView:(UITableView *)tableView;
- (NSInteger)tableView:(UITableView *)tableView returnGoddsnumberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *)tableView:(UITableView *)tableView returnGoddscellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)tableView returnGoddsdidSelectRowAtIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)tableView:(UITableView *)tableView returnGoddsheightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)tableView:(UITableView *)tableView returnGoddsheightForHeaderInSection:(NSInteger)section;
- (UIView *)tableView:(UITableView *)tableView returnGoddsviewForHeaderInSection:(NSInteger)section;
@end
