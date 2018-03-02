//
//  JXBranchOrderViewController+JXForGoods.m
//  JaneCargo
//
//  Created by 鹏 on 2017/7/10.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXBranchOrderViewController+JXForGoods.h"

@implementation JXBranchOrderViewController (JXForGoods)

- (NSInteger)goodsNumberOfSectionsInTableView:(UITableView *)tableView {
    if (self.goodsArray.count == 0 ) {
        return 1;
    }else {
        return self.goodsArray.count;
    }
    
}
- (NSInteger)tableView:(UITableView *)tableView goodsNumberOfRowsInSection:(NSInteger)section {
    if (self.goodsArray.count == 0 ) {
        return 3;
    }else {
        MKOrderListModel * tempModle = (MKOrderListModel*)self.goodsArray[section];
        return 3+tempModle.cart.count;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView goodsCellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.goodsArray.count == 0 ) {
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
        MKOrderListModel * tempModle = (MKOrderListModel*)self.goodsArray[indexPath.section];
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
            if (self.goodsArray.count >0) {
                cell.model = ((MKOrderListModel*)self.goodsArray[indexPath.section]).cart[indexPath.row-1];
            }
            
            return cell;
        }
    }
    
}
- (void)tableView:(UITableView *)tableView didgoodsSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.goodsArray.count) {
        MKOrderListModel * tempModle = (MKOrderListModel*)self.goodsArray[indexPath.section];
        if (indexPath.row!=0&&indexPath.row!=3+tempModle.cart.count-2&&indexPath.row!=3+tempModle.cart.count-1) {
            [self orderMessageModel:tempModle];
        }
    }
    
    
}
- (CGFloat)tableView:(UITableView *)tableView goodsHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.goodsArray.count == 0) {
        NSInteger line = [JXEncapSulationObjc s_calculateNumberArrayNum:self.recommendedArray.count singleNumber:2];
        if (indexPath.row == 0) {
            return 271;
        }else if (indexPath.row == 1){
            return TableViewControllerCell_Height;
        }else {
            
            return line * BranchOrder_Collection_Height;
        }
    }else {
        MKOrderListModel * tempModle = (MKOrderListModel*)self.goodsArray[indexPath.section];
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
- (CGFloat)tableView:(UITableView *)tableView goodsHeightForHeaderInSection:(NSInteger)section {
    if (self.goodsArray.count == 0) {
        return 0;
    }else {
        return 10;
    }
}

- (CGFloat)tableView:(UITableView *)tableView goodsheightForFooterInSection:(NSInteger)section {
    if (self.goodsArray.count == 0) {
        return 64;
    }else {
        if (section == self.goodsArray.count-1) {
            return 64+50;
        }else {
            return 0;
        }
    }
    
}



@end
