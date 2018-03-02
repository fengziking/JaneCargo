//
//  JXOrderDetailViewController+JXPayment.h
//  JaneCargo
//
//  Created by 鹏 on 2017/8/4.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXOrderDetailViewController.h"

@interface JXOrderDetailViewController (JXPayment)

- (NSInteger)paymentnumberOfSectionsInTableView:(UITableView *)tableView;
- (NSInteger)tableView:(UITableView *)tableView paymentnumberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *)tableView:(UITableView *)tableView paymentcellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)tableView paymentdidSelectRowAtIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)tableView:(UITableView *)tableView paymentheightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)tableView:(UITableView *)tableView paymentheightForHeaderInSection:(NSInteger)section;
- (UIView *)tableView:(UITableView *)tableView paymentviewForHeaderInSection:(NSInteger)section;
@end
