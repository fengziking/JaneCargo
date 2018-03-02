//
//  JXOrderDetailViewController+JXForGoods.h
//  JaneCargo
//
//  Created by 鹏 on 2017/8/4.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXOrderDetailViewController.h"

@interface JXOrderDetailViewController (JXForGoods)

- (NSInteger)forGoodsnumberOfSectionsInTableView:(UITableView *)tableView;
- (NSInteger)tableView:(UITableView *)tableView forGoodsnumberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *)tableView:(UITableView *)tableView forGoodscellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)tableView forGoodsdidSelectRowAtIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)tableView:(UITableView *)tableView forGoodsheightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)tableView:(UITableView *)tableView forGoodsheightForHeaderInSection:(NSInteger)section;
- (UIView *)tableView:(UITableView *)tableView forGoodsviewForHeaderInSection:(NSInteger)section;
@end
