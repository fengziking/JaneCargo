//
//  JXOrderDetailViewController+JXOrderFinished.h
//  JaneCargo
//
//  Created by 鹏 on 2017/8/4.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXOrderDetailViewController.h"

@interface JXOrderDetailViewController (JXOrderFinished)

- (NSInteger)orderFinishednumberOfSectionsInTableView:(UITableView *)tableView;
- (NSInteger)tableView:(UITableView *)tableView orderFinishednumberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *)tableView:(UITableView *)tableView orderFinishedcellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)tableView orderFinisheddidSelectRowAtIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)tableView:(UITableView *)tableView orderFinishedheightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)tableView:(UITableView *)tableView orderFinishedheightForHeaderInSection:(NSInteger)section;
- (UIView *)tableView:(UITableView *)tableView orderFinisviewForHeaderInSection:(NSInteger)section;
@end
