//
//  JXBranchOrderViewController+JXPaymentController.m
//  JaneCargo
//
//  Created by 鹏 on 2017/7/10.
//  Copyright © 2017年 鹏. All rights reserved.
//  待付款

#import "JXBranchOrderViewController+JXPaymentController.h"

@implementation JXBranchOrderViewController (JXPaymentController)

- (NSInteger)payNumberOfSectionsInTableView:(UITableView *)tableView {
    if (self.paymentArray.count == 0 ) {
        return 1;
    }else {
        return self.paymentArray.count;
    }
    
}
- (NSInteger)tableView:(UITableView *)tableView payNumberOfRowsInSection:(NSInteger)section {
    if (self.paymentArray.count == 0 ) {
        return 3;
    }else {
        MKOrderListModel * tempModle = (MKOrderListModel*)self.paymentArray[section];
        return 3+tempModle.cart.count;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView payCellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (self.paymentArray.count == 0 ) {
        if (indexPath.row == 0) {
            JXNoOrderTableViewCell *cell = [JXNoOrderTableViewCell cellWithTable];
            cell.Goshoppingblock = ^{
                
            };
            return cell;
        }else if (indexPath.row == 1) {
            JXPromotionTitleCell *cell = [JXPromotionTitleCell cellWithTable];
            [cell setSelectionStyle:(UITableViewCellSelectionStyleNone)];
            [cell setBackgroundColor:kUIColorFromRGB(0xf2f2f2)];
            cell.gradientLabel.text = @"推荐产品";
            return cell;
        }else {
            JXPromotionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"pros" forIndexPath:indexPath];
            [JXEncapSulationObjc selectViewAbout:cell];
            [self showPromotion:cell];
            [cell setSelectionStyle:(UITableViewCellSelectionStyleNone)];
            return cell;
        }
        
    }else {
        MKOrderListModel * tempModle = (MKOrderListModel*)self.paymentArray[indexPath.section];
        if (indexPath.row == 0)
        { // 商店名称
            JXBranchOrderTableViewCell *cell = [JXBranchOrderTableViewCell cellWithTable];
            [cell setSelectionStyle:(UITableViewCellSelectionStyleNone)];
            [cell setModel:tempModle];
            return cell;
        }
        else if (indexPath.row == 3+tempModle.cart.count-2)
        { // 商品付款数
            JXSettlementTableViewCell *cell = [JXSettlementTableViewCell cellWithTable];
            [cell setSelectionStyle:(UITableViewCellSelectionStyleNone)];
            [cell setModel:tempModle];
            return cell;
        }
        else if (indexPath.row == 3+tempModle.cart.count-1)
        { // 取消订单。。。
            JXBranchPayTableViewCell *cell = [JXBranchPayTableViewCell cellWithTable];
            [cell setSelectionStyle:(UITableViewCellSelectionStyleNone)];
            [cell setModel:tempModle];
            cell.click = ^(MKOrderListModel *model, NSInteger type) {
                [self jumpInterface:model type:type];
            };
            return cell;
        }
        else
        {   // 商品内容
            
            JXBranchGoodsTableViewCell *cell = [JXBranchGoodsTableViewCell cellWithTable];
            [cell setSelectionStyle:(UITableViewCellSelectionStyleNone)];
            if (self.paymentArray.count >0) {
                cell.model = ((MKOrderListModel*)self.paymentArray[indexPath.section]).cart[indexPath.row-1];
            }
            
            return cell;
        }
    }
    
}
- (void)tableView:(UITableView *)tableView didpaySelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.paymentArray.count >0) {
        MKOrderListModel * tempModle = (MKOrderListModel*)self.paymentArray[indexPath.section];
        if (indexPath.row!=0&&indexPath.row!=3+tempModle.cart.count-2&&indexPath.row!=3+tempModle.cart.count-1) {
            [self orderMessageModel:tempModle];
        }
    }
    
    
}
- (CGFloat)tableView:(UITableView *)tableView payHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.paymentArray.count == 0) {
        NSInteger line = [JXEncapSulationObjc s_calculateNumberArrayNum:self.recommendedArray.count singleNumber:2];
        if (indexPath.row == 0) {
            return 271;
        }else if (indexPath.row == 1){
            return TableViewControllerCell_Height;
        }else {
            
            return line * BranchOrder_Collection_Height;
        }
    }else {
        MKOrderListModel * tempModle = (MKOrderListModel*)self.paymentArray[indexPath.section];
        if (indexPath.row == 0) { // 商店名称
            return 40;
        }else if (indexPath.row == 3+tempModle.cart.count-2){ // 商品付款数
            return TableViewControllerCell_Height;
        }else if (indexPath.row == 3+tempModle.cart.count-1) { // 取消订单。。。
            return TableViewControllerCell_Height;
        }else {   // 商品内容
            
            return 95;
        }
    }
    
    
}
- (CGFloat)tableView:(UITableView *)tableView payHeightForHeaderInSection:(NSInteger)section {

    if (self.paymentArray.count == 0) {
        return 0;
    }else {
        return 10;
    }
}
- (CGFloat)tableView:(UITableView *)tableView payheightForFooterInSection:(NSInteger)section {
    if (self.paymentArray.count == 0) {
        return 64;
    }else {
        if (section == self.paymentArray.count-1) {
            return 64+50;
        }else {
            return 0;
        }
    }
    
}

@end
