//
//  JXOrderDetailViewController+JXReturnGodds.m
//  JaneCargo
//
//  Created by 鹏 on 2017/8/4.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXOrderDetailViewController+JXReturnGodds.h"

@implementation JXOrderDetailViewController (JXReturnGodds)
- (NSInteger)returnGoddsnumberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView returnGoddsnumberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return self.model.cart.count+2;
    }else if (section == 2) {
        return 3;
    }else {
        
        if ([self.model.status isEqualToString:@"1"]&&[self.model.is_return isEqualToString:@"1"])
        { // 已申请退款，d等待商家确认（（退货中）
            return 1;
        }
        else if ([self.model.status isEqualToString:@"2"]&&[self.model.is_return isEqualToString:@"1"]) {
            // 已申请退款
            return 1;
        }
        else if ([self.model.status isEqualToString:@"10"]&&[self.model.is_return isEqualToString:@"1"])
        { // 退款成功 货款已到账
            return 2;
        }
        else if ([self.model.status isEqualToString:@"12"]&&[self.model.is_return isEqualToString:@"1"])
        { // 商家已经同意退货
            return 3;
        }
        else {
            
            return 0;
        }
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView returnGoddscellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {
        JXRefundTableViewCell *cell = [JXRefundTableViewCell cellWithTable];
        [cell setModel:self.model];
        return cell;
    }else if (indexPath.section == 1) {
        if (indexPath.row == 0)
        { 
            JXOrderInformationTableViewCell *cell = [JXOrderInformationTableViewCell cellWithTable];
            cell.CopySuccess = ^{
                [self showHint:@"复制成功"];
            };
            self.model.typeIndex = indexPath.row;
            [cell setModel:self.model];
            return cell;
        }
        else if (indexPath.row == self.model.cart.count+2-1)
        { // 付费 快递
            JXOrderGoodsPriceTableViewCell *cell = [JXOrderGoodsPriceTableViewCell cellWithTable];
            [cell setHiddenbt:YES];
            [cell setModel:self.model];
            return cell;
        }
        else
        { // 商品
            JXBranchGoodsTableViewCell *cell = [JXBranchGoodsTableViewCell cellWithTable];
            cell.model = self.model.cart[indexPath.row-1];
            return cell;
        }
    }else if (indexPath.section == 2) { // 原因 金额 说明
        JXReturnRefundTableViewCell *cell = [JXReturnRefundTableViewCell cellWithTable];
        self.model.typeIndex = indexPath.row;
        [cell setModel:self.model];
        return cell;
    }else {
        JXReturnRefundTableViewCell *cell = [JXReturnRefundTableViewCell cellWithTable];
        self.model.typeIndex = indexPath.row;
        [cell setModelTime:self.model];
        return cell;
    }
    
    
}
- (void)tableView:(UITableView *)tableView returnGoddsdidSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}
- (CGFloat)tableView:(UITableView *)tableView returnGoddsheightForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {
        return 100;
    }else if (indexPath.section == 1) {
        if (indexPath.row == 0)
        {
            return TableViewControllerCell_Height;
        }
        else if (indexPath.row == self.model.cart.count+2-1)
        {
            return 85;
        }
        else
        {
            return 99;
        }
    }else {
        
        KDLOG(@"高度多少----- %f",self.model.cellHeight);
        if (indexPath.row == 0 || indexPath.row == 1) {
            return TableViewControllerCell_Height;
        }else {
            return self.model.cellHeight;
//            return 100;
        }
        
    }
    
    
}
- (CGFloat)tableView:(UITableView *)tableView returnGoddsheightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    }
    return 10;
}
- (UIView *)tableView:(UITableView *)tableView returnGoddsviewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, NPWidth, 10)];
    return view;
    
}


@end
