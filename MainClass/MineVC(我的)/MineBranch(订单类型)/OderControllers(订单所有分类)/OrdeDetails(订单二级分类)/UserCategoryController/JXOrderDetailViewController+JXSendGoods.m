//
//  JXOrderDetailViewController+JXSendGoods.m
//  JaneCargo
//
//  Created by 鹏 on 2017/8/4.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXOrderDetailViewController+JXSendGoods.h"

@implementation JXOrderDetailViewController (JXSendGoods)

- (NSInteger)sendGoodsnumberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}
- (NSInteger)tableView:(UITableView *)tableView sendGoodsnumberOfRowsInSection:(NSInteger)section {
    if (section == 2)
    {
        return self.model.cart.count+2;
    }
    else if (section == 4)
    {
        return 3;
    }
    else
    {
        return 1;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView sendGoodscellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0)
    {
        JXOrderdetailImageTableViewCell *cell = [JXOrderdetailImageTableViewCell cellWithTable];
        if ([self.model.is_return_good isEqualToString:@"1"]) { // 退款被拒
            [cell setStart_Image:@"订单状态-待发货"];
        }else {
           [cell setStart_Image:@"订单状态-待发货"];
        }
        
        return cell;
        
    }
   // else if (indexPath.section == 1)
   // {
   //     JXDeliveryinformationTableViewCell *cell = [JXDeliveryinformationTableViewCell cellWithTable];
   //     [cell setModel:self.model];
   //     return cell;
   // }
    else if (indexPath.section == 1)
    { // 地址
        JXOrderdetailsAddressTableViewCell *cell = [JXOrderdetailsAddressTableViewCell cellWithTable];
        [cell setModel:self.model];
        return cell;
    }
    else if (indexPath.section == 2)
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
    else if (indexPath.section == 3)
    { // 发票抬头
        JXInvoiceTableViewCell *cell = [JXInvoiceTableViewCell cellWithTable];
        if ([self.model.is_bill integerValue] != 0) {
            [cell setModel:self.model];
        }
        return cell;
    }
    else
    { // 订单
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
- (void)tableView:(UITableView *)tableView sendGoodsdidSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}
- (CGFloat)tableView:(UITableView *)tableView sendGoodsheightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0)
    {
        return 100;
    }
   // else if(indexPath.section == 1)
   // { // 无信息 高度44
   //     return 44;
   // }
    else if (indexPath.section == 1)
    {
        return 90;
    }
    else if (indexPath.section == 2)
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
    else if (indexPath.section == 3)
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
- (CGFloat)tableView:(UITableView *)tableView sendGoodsheightForHeaderInSection:(NSInteger)section {
    if (section == 1 || section == 2 || section == 3 || section == 4)
    {
        if ([self.model.is_bill integerValue] == 0 && section == 3) {
            return 0;
        }else {
            return 10;
        }
    }
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView sendGoodsviewForHeaderInSection:(NSInteger)section {
   
    CGFloat width;
    if (section == 1 || section == 2 || section == 3 || section == 4)
    {
        if ([self.model.is_bill integerValue] == 0 && section == 3) {
            width = 0;
        }else {
            width= 10;
        }
    }else {
        
        width = 0;
    }
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, NPWidth, width)];
    return view;
    
}



@end
