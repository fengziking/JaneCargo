//
//  JXOrderDetailViewController+JXHaveEvaluation.h
//  JaneCargo
//
//  Created by 鹏 on 2017/10/10.
//  Copyright © 2017年 鹏. All rights reserved.
// 评价

#import "JXOrderDetailViewController.h"

@interface JXOrderDetailViewController (JXHaveEvaluation)

- (NSInteger)evaluationGoodsnumberOfSectionsInTableView:(UITableView *)tableView;
- (NSInteger)tableView:(UITableView *)tableView evaluationGoodsnumberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *)tableView:(UITableView *)tableView evaluationGoodscellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)tableView evaluationGoodsdidSelectRowAtIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)tableView:(UITableView *)tableView evaluationGoodsheightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)tableView:(UITableView *)tableView evaluationGoodsheightForHeaderInSection:(NSInteger)section;
- (UIView *)tableView:(UITableView *)tableView evaluationGoodsviewForHeaderInSection:(NSInteger)section ;

@end
