//
//  JXOrderDetailViewController+JXSendGoods.h
//  JaneCargo
//
//  Created by 鹏 on 2017/8/4.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXOrderDetailViewController.h"

@interface JXOrderDetailViewController (JXSendGoods)

- (NSInteger)sendGoodsnumberOfSectionsInTableView:(UITableView *)tableView;
- (NSInteger)tableView:(UITableView *)tableView sendGoodsnumberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *)tableView:(UITableView *)tableView sendGoodscellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)tableView sendGoodsdidSelectRowAtIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)tableView:(UITableView *)tableView sendGoodsheightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)tableView:(UITableView *)tableView sendGoodsheightForHeaderInSection:(NSInteger)section;
- (UIView *)tableView:(UITableView *)tableView sendGoodsviewForHeaderInSection:(NSInteger)section ;

@end
