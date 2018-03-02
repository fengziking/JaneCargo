//
//  JXOrderDetailViewController+JXForGoods.m
//  JaneCargo
//
//  Created by 鹏 on 2017/8/4.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXOrderDetailViewController+JXForGoods.h"

@implementation JXOrderDetailViewController (JXForGoods)

- (NSInteger)forGoodsnumberOfSectionsInTableView:(UITableView *)tableView {
    return 6;
}
- (NSInteger)tableView:(UITableView *)tableView forGoodsnumberOfRowsInSection:(NSInteger)section {
    if (section == 3)
    {
        return self.model.cart.count+2;
    }
    else if (section == 5)
    {
        return 4;
    }
    else
    {
        return 1;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView forGoodscellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0)
    {
        JXOrderdetailImageTableViewCell *cell = [JXOrderdetailImageTableViewCell cellWithTable];
        if ([self.model.is_return_good isEqualToString:@"1"]) { // 退款被拒
            [cell setStart_Image:@"订单状态-待收货"];
        }else {
            [cell setStart_Image:@"订单状态-待收货"];
        }
        return cell;
        
    }
    else if (indexPath.section == 1)
    {
        JXDeliveryinformationTableViewCell *cell = [JXDeliveryinformationTableViewCell cellWithTable];
        [cell setModel:self.model];
        return cell;
    }
    else if (indexPath.section == 2)
    { // 地址
        JXOrderdetailsAddressTableViewCell *cell = [JXOrderdetailsAddressTableViewCell cellWithTable];
        [cell setModel:self.model];
        return cell;
    }
    else if (indexPath.section == 3)
    {
        
        if (indexPath.row == 0)
        { // 店铺名称
            JXBranchOrderTableViewCell *cell = [JXBranchOrderTableViewCell cellWithTable];
            [cell setModel:self.model];
            [cell setHiddenStart:YES];
            return cell;
        }
        else if (indexPath.row == self.model.cart.count+2-1)
        { // 付费 快递
            JXOrderGoodsPriceTableViewCell *cell = [JXOrderGoodsPriceTableViewCell cellWithTable];
            cell.refunddelegate = self;
            [cell setModel:self.model];
            return cell;
        }
        else
        { // 商品
            JXBranchGoodsTableViewCell *cell = [JXBranchGoodsTableViewCell cellWithTable];
            cell.model = self.model.cart[indexPath.row-1];
            return cell;
        }
        
    }
    else if (indexPath.section == 4)
    {
        JXInvoiceTableViewCell *cell = [JXInvoiceTableViewCell cellWithTable];
        if ([self.model.is_bill integerValue] != 0) {
            [cell setModel:self.model];
        }
        return cell;
    }
    else
    {
        JXOrderInformationTableViewCell *cell = [JXOrderInformationTableViewCell cellWithTable];
        if (indexPath.row != 0)
        {
            [cell setHiddenCopy:YES];
        }
        cell.CopySuccess = ^{
            [self showHint:@"复制成功"];
        };
        self.model.typeIndex = indexPath.row;
        [cell setModel:self.model];
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView forGoodsdidSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}
- (CGFloat)tableView:(UITableView *)tableView forGoodsheightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0)
    {
        return 100;
    }
    else if(indexPath.section == 1)
    { // 无信息 高度44
        return 60;
    }
    else if (indexPath.section == 2)
    {
        return 90;
    }
    else if (indexPath.section == 3)
    {
        
        if (indexPath.row == 0)
        {
            return 40;
        }
        else if (indexPath.row == self.model.cart.count+2-1)
        {
            return 85+TableViewControllerCell_Height;
        }
        else
        {
            return 99;
        }
    }
    else if (indexPath.section == 4)
    {
        if ([self.model.is_bill integerValue] == 0) {
            return 0;
        }else {
            return 59;
        }
    }
    else
    {
        return TableViewControllerCell_Height;
    }
}
- (CGFloat)tableView:(UITableView *)tableView forGoodsheightForHeaderInSection:(NSInteger)section {
    if (section == 2 || section == 3 || section == 4 || section == 5)
    {
        if ([self.model.is_bill integerValue] == 0 && section == 4) {
            return 0;
        }else {
            return 10;
        }
    }
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView forGoodsviewForHeaderInSection:(NSInteger)section {
    
    CGFloat width;
    if (section == 2 || section == 3 || section == 4 || section == 5)
    {
        if ([self.model.is_bill integerValue] == 0 && section == 4) {
            width = 0;
        }else {
            width= 10;
        }
    }else {
        
        width =0;
    }
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, NPWidth, width)];
    return view;
}
@end
