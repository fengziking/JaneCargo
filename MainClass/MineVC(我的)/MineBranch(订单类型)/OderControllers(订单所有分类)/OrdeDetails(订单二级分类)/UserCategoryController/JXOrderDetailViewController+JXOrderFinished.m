//
//  JXOrderDetailViewController+JXOrderFinished.m
//  JaneCargo
//
//  Created by 鹏 on 2017/8/4.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXOrderDetailViewController+JXOrderFinished.h"

@implementation JXOrderDetailViewController (JXOrderFinished)

- (NSInteger)orderFinishednumberOfSectionsInTableView:(UITableView *)tableView {
    return 6;
}
- (NSInteger)tableView:(UITableView *)tableView orderFinishednumberOfRowsInSection:(NSInteger)section {
    if (section == 3) {
        return self.model.cart.count+2;
    }else if (section == 5) {
        return 5;
    }else {
        return 1;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView orderFinishedcellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0)
    {
        JXOrderdetailImageTableViewCell *cell = [JXOrderdetailImageTableViewCell cellWithTable];
        [cell setStart_Image:@"订单状态-订单完成"];
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
- (void)tableView:(UITableView *)tableView orderFinisheddidSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}
- (CGFloat)tableView:(UITableView *)tableView orderFinishedheightForRowAtIndexPath:(NSIndexPath *)indexPath {
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
            return 85;
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
- (CGFloat)tableView:(UITableView *)tableView orderFinishedheightForHeaderInSection:(NSInteger)section {
    
    
//    if (section == 2 || section == 3 || section == 4 || section == 5)
//    {
//        if ([self.model.is_bill integerValue] == 0) { // 是否开票
//            return 10;
//        }else {
//            return 59;
//        }
//    }
//    return 0;
    
    if (section == 0)
    {
        return 0;
    }
    else if (section == 1) {
        
        return 0;
    }
    else if (section == 2) {
        
        return 10;
    }
    else if (section == 3) {
        
        return 10;
    }else if (section == 4) {
        
        return 10;
    }else {
        
        return 10;
    }
    
    
    
}

- (UIView *)tableView:(UITableView *)tableView orderFinisviewForHeaderInSection:(NSInteger)section {
    CGFloat width;
//    if (section == 2 || section == 3 || section == 4 || section == 5)
//    {
//        if ([self.model.is_bill integerValue] == 0 ) {
//            width = 10;
//        }else {
//            width= 59;
//        }
//    }else {
//
//        width = 0;
//    }
    if (section == 0)
    {
       width =  0;
    }
    else if (section == 1) {
        
        width =  0;
    }
    else if (section == 2) {
        
        width =  10;
    }
    else if (section == 3) {
        
        width =  10;
    }else if (section == 4) {
        
        width = 10;
    }else {
        
        width =  10;
    }
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, NPWidth, width)];
    return view;
    
}








@end
