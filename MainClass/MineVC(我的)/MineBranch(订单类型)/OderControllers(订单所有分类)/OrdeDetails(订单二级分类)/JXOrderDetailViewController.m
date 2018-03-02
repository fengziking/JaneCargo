//
//  JXOrderDetailViewController.m
//  JaneCargo
//
//  Created by 鹏 on 2017/7/10.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXOrderDetailViewController.h"
#import "JXCancelOrPayView.h"

#import "JXOrderDetailViewController+JXSendGoods.h"
#import "JXOrderDetailViewController+JXForGoods.h"
#import "JXOrderDetailViewController+JXOrderFinished.h"
#import "JXOrderDetailViewController+JXReturnGodds.h"
#import "JXOrderDetailViewController+JXPayment.h"
#import "JXOrderDetailViewController+JXRecycling.h"
#import "JXOrderDetailViewController+JXHaveEvaluation.h"
// 退款
#import "JXRefundViewController.h"
#import "JXCheckLogisticsViewController.h"
#import "JXEvaluationViewController.h"
#import "JXCourierNumberViewController.h"


@interface JXOrderDetailViewController ()<UITableViewDelegate,UITableViewDataSource,UserOrderClickDelegate> {
    
    UITableView *OrderDetailsTable;
}

@property (nonatomic, strong) JXCancelOrPayView *cancelPay;

@end

@implementation JXOrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel * titleLabel =[[UILabel alloc]init];
    titleLabel.text = @"订单详情";
    [titleLabel sizeToFit];
    titleLabel.textColor = [UIColor blackColor];
    self.navigationItem.titleView = titleLabel;
    
    [self.view setBackgroundColor:kUIColorFromRGB(0xf2f2f2)];
    [self layoutTempTable];
    [self bottomView];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_back"] style:(UIBarButtonItemStylePlain) target:self action:@selector(leftAction:)];
    // 接收消息
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(wxpayResultsAction:) name:@"WXpayResults" object:nil];
}

-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


- (void)wxpayResultsAction:(NSNotification *)objc {
    
    
    NSString *payresult = objc.object;
    if ([payresult isEqualToString:@"成功"]) {
        [self showHint:@"支付成功"];
        if ([_paySuccessdelegate respondsToSelector:@selector(paySuccess)]) {
            [_paySuccessdelegate paySuccess];
        }
        [self.navigationController popViewControllerAnimated:YES];
    }else {
        KDLOG(@"");
        [self showHint:@"支付失败"];
    }
    
}


- (void)bottomView {

    NSArray *nibContents = [[NSBundle mainBundle] loadNibNamed:@"JXCancelOrPayView" owner:nil options:nil];
    _cancelPay = [nibContents lastObject];
    _cancelPay.frame = CGRectMake(0, NPHeight-44-64, [[UIScreen mainScreen] bounds].size.width, 44);
    _cancelPay.backgroundColor = [UIColor whiteColor];
    _cancelPay.userorderdelegate = self;
    [self.view addSubview:_cancelPay];
    
    [JXJudgeStrObjc distinguishTheCategory:_model delivery:^{ // 待发货
        
        if ([_model.is_return isEqualToString:@"1"]) {
            [_cancelPay.ordercancelbt setHidden:YES];
            [_cancelPay.orderpaybt setTitle:@"联系商家" forState:(UIControlStateNormal)];
        }else {
            [_cancelPay.ordercancelbt setHidden:YES];
            [_cancelPay.orderpaybt setTitle:@"提醒发货" forState:(UIControlStateNormal)];
        }
        
    } goods:^{  // 待收货
        
        if ([_model.is_return isEqualToString:@"1"]) {
            [_cancelPay.ordercancelbt setHidden:YES];
            [_cancelPay.orderpaybt setTitle:@"联系商家" forState:(UIControlStateNormal)];
        }else {
            
            [_cancelPay.ordercancelbt setTitle:@"查看物流" forState:(UIControlStateNormal)];
            [_cancelPay.orderpaybt setTitle:@"确定收货" forState:(UIControlStateNormal)];
        }
        
    } orderfinished:^{ // 订单完成
        [_cancelPay.ordercancelbt setTitle:@"删除订单" forState:(UIControlStateNormal)];
        [_cancelPay.orderpaybt setTitle:@"去评论" forState:(UIControlStateNormal)];
        
    } returngoods:^{ // 退货中
        [_cancelPay.ordercancelbt setTitle:@"联系商家" forState:(UIControlStateNormal)];
        [_cancelPay.orderpaybt setTitle:@"取消退款" forState:(UIControlStateNormal)];
        
    } payment:^{  // 待付款
        [_cancelPay.ordercancelbt setTitle:@"取消订单" forState:(UIControlStateNormal)];
        [_cancelPay.orderpaybt setTitle:@"去支付" forState:(UIControlStateNormal)];
        
    } recycling:^{ // 已关闭/已删除
        [_cancelPay.ordercancelbt setHidden:YES];
        [_cancelPay.orderpaybt setHidden:YES];
//        [_cancelPay.orderpaybt setTitle:@"再次购买" forState:(UIControlStateNormal)];
        
    }evaluation:^{ // 已评价
        [_cancelPay.orderpaybt setTitle:@"删除订单" forState:(UIControlStateNormal)];
        [_cancelPay.ordercancelbt setHidden:YES];
//        [_cancelPay.orderpaybt setTitle:@"再次购买" forState:(UIControlStateNormal)];
    } refund:^{    // 申请退款
        [_cancelPay.ordercancelbt setTitle:@"联系商家" forState:(UIControlStateNormal)];
        [_cancelPay.orderpaybt setTitle:@"取消退款" forState:(UIControlStateNormal)];
    } rejected:^{ // 7申请被拒
        
    } complete:^{ // 退款完成
        [_cancelPay.orderpaybt setTitle:@"删除订单" forState:(UIControlStateNormal)];
        [_cancelPay.ordercancelbt setHidden:YES];
//        [_cancelPay.orderpaybt setTitle:@"再次购买" forState:(UIControlStateNormal)];
    } refundon:^{ // 退款进行中
//        [_cancelPay.ordercancelbt setHidden:YES];
//        [_cancelPay.orderpaybt setTitle:@"联系商家" forState:(UIControlStateNormal)];
        [_cancelPay.ordercancelbt setTitle:@"联系商家" forState:(UIControlStateNormal)];
        [_cancelPay.orderpaybt setTitle:@"填写快递单号" forState:(UIControlStateNormal)];
    } agreerefund:^{ // 同意退款
        
        [_cancelPay.ordercancelbt setTitle:@"联系商家" forState:(UIControlStateNormal)];
        [_cancelPay.orderpaybt setTitle:@"填写快递单号" forState:(UIControlStateNormal)];
        
    }];
    
}

#pragma mark -- 点击底部View代理
- (void)infrontbt:(NSString*)str {
    
    if ([_model.status isEqualToString:@"1"]&&[_model.is_return isEqualToString:@"0"])
    { // 待发货
        if ([str isEqualToString:@"0"]) {
            
        }else if ([str isEqualToString:@"1"]) {
            [self remindthedeliveryOrder:_model];
        }
    }
    else if ([_model.status isEqualToString:@"2"]&&[_model.is_return isEqualToString:@"0"])
    { // 待收货
        if ([str isEqualToString:@"0"]) {
            [self checkLogistics:_model];
        }else if ([str isEqualToString:@"1"]) {
            [self confirmtheGoodsOrder:_model];
        }
    }
    else if ([_model.status isEqualToString:@"3"]&&[_model.is_return isEqualToString:@"0"])
    { // 订单完成
        if ([str isEqualToString:@"0"]) {
            [self deleteOrder:_model];
        }else if ([str isEqualToString:@"1"]) {
            [self evaluationOrder:_model];
        }
    }
    else if ([_model.status isEqualToString:@"4"]&&[_model.is_return isEqualToString:@"1"])
    { // 退货中
        if ([str isEqualToString:@"0"]) {// 联系商家
            [self contactthemerchantModel:_model];
        }else if ([str isEqualToString:@"1"]) {// 取消退款
            [self cancelTheRefund:_model];
        }
    }
    else if ([_model.status isEqualToString:@"8"]&&[_model.is_return isEqualToString:@"0"])
    { // 待付款
        if ([str isEqualToString:@"0"]) {
            [self cancelTheOrder:_model];
        }else if ([str isEqualToString:@"1"]) {
            [self continueToPay:_model];
        }
    }
    else if ([_model.status isEqualToString:@"9"]&&[_model.is_return isEqualToString:@"0"])
    { // 已关闭/已删除
        if ([str isEqualToString:@"0"]) {
            
        }else if ([str isEqualToString:@"1"]) {
            //            [self onceAgaintoBuy:_model];
        }
    }else if ([_model.status isEqualToString:@"5"]&&[_model.is_return isEqualToString:@"0"])
    { // 已评价
        if ([str isEqualToString:@"0"]) { //
            //            [self onceAgaintoBuy:_model];
        }else if ([str isEqualToString:@"1"]) { // 删除订单
            [self cancelTheOrder:_model];
        }
    }
    else if ([_model.status isEqualToString:@"1"]&&[_model.is_return isEqualToString:@"1"])
    { // 申请退款
        if ([str isEqualToString:@"0"]) {
            // 联系商家
            [self contactthemerchantModel:_model];
        }else if ([str isEqualToString:@"1"]) { // 取消退款
            [self cancelTheRefund:_model];
        }
    }
    else if ([_model.status isEqualToString:@"2"]&&[_model.is_return isEqualToString:@"1"])
    { // 申请退款
        if ([str isEqualToString:@"0"]) {
            // 联系商家
            [self contactthemerchantModel:_model];
        }else if ([str isEqualToString:@"1"]) { // 取消退款
            [self cancelTheRefund:_model];
        }
    }
    else if ([_model.status isEqualToString:@"1"]&&[_model.is_return isEqualToString:@"0"]&&[_model.is_return_good isEqualToString:@"1"])
    { // 申请被拒
        
    }
    else if ([_model.status isEqualToString:@"2"]&&[_model.is_return isEqualToString:@"0"]&&[_model.is_return_good isEqualToString:@"1"])
    { // 申请被拒
        
    }
    else if ([_model.status isEqualToString:@"10"]&&[_model.is_return isEqualToString:@"1"])
    { // 退款完成
        if ([str isEqualToString:@"0"]) { // 再次购买
            //            [self onceAgaintoBuy:_model];
        }else if ([str isEqualToString:@"1"]) {//删除订单
            
            [self cancelTheOrder:_model];
        }
        
    }
    else if ([_model.status isEqualToString:@"12"]&&[_model.is_return isEqualToString:@"1"])
    { // 退款进行中
        if ([str isEqualToString:@"0"]) {
            
        }else if ([str isEqualToString:@"1"]) {
            // 联系商家
            [self contactthemerchantModel:_model];
        }
        
    }
    else if ([_model.status isEqualToString:@"12"]&&[_model.is_return isEqualToString:@"1"])
    { // 同意退款
        if ([str isEqualToString:@"0"]) {
            // 联系商家
            [self contactthemerchantModel:_model];
        }else if ([str isEqualToString:@"1"]) { // 填写快递单号
            [self fillintheCourier:_model];
        }
        
    }
    
    
}

// 填写快递单
- (void)fillintheCourier:(MKOrderListModel *)model {
    
    JXCourierNumberViewController *courier = [[JXCourierNumberViewController alloc] init];
    courier.model = model;
    [self.navigationController pushViewController:courier animated:YES];
}


- (void)leftAction:(UIBarButtonItem *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)layoutTempTable {
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    OrderDetailsTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, NPWidth, NPHeight-64-44)];
    OrderDetailsTable.separatorStyle = UITableViewCellEditingStyleNone;
    OrderDetailsTable.delegate = self;
    OrderDetailsTable.dataSource = self;
    OrderDetailsTable.backgroundColor = kUIColorFromRGB(0xf2f2f2);
    [OrderDetailsTable setShowsVerticalScrollIndicator:NO];
    [self.view addSubview:OrderDetailsTable];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {// 5 已评价
    
    if ([_model.status isEqualToString:@"1"])
    { // 待发货
        if ([_model.is_return isEqualToString:@"1"]) { // 申请退货
             return [self returnGoddsnumberOfSectionsInTableView:tableView];
        }else {
            
            return [self sendGoodsnumberOfSectionsInTableView:tableView];
        }
        
    }
    else if ([_model.status isEqualToString:@"2"])
    { // 待收货
        if ([_model.is_return isEqualToString:@"1"]) {
             return [self returnGoddsnumberOfSectionsInTableView:tableView];
        }else {
            
            return [self forGoodsnumberOfSectionsInTableView:tableView];
        }
    }
    else if ([_model.status isEqualToString:@"3"]&&[_model.is_return isEqualToString:@"0"])
    { // 订单完成
        return [self orderFinishednumberOfSectionsInTableView:tableView];
    }
    else if ([_model.status isEqualToString:@"4"]||[_model.status isEqualToString:@"10"]||[_model.status isEqualToString:@"11"]||[_model.status isEqualToString:@"12"])
    { // 退货中
        return [self returnGoddsnumberOfSectionsInTableView:tableView];
    }
    else if ([_model.status isEqualToString:@"8"]&&[_model.is_return isEqualToString:@"0"])
    { // 待付款
        return [self paymentnumberOfSectionsInTableView:tableView];
    }
    else if ([_model.status isEqualToString:@"5"]&&[_model.is_return isEqualToString:@"0"])
    { // 去评论
        return [self evaluationGoodsnumberOfSectionsInTableView:tableView];
    }
    else
    { // 已关闭/已删除
        return [self recyclingnumberOfSectionsInTableView:tableView];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if ([_model.status isEqualToString:@"1"])
    { // 待发货
        if ([_model.is_return isEqualToString:@"1"]) {
            return [self tableView:tableView returnGoddsnumberOfRowsInSection:section];
        }else {
            return [self tableView:tableView sendGoodsnumberOfRowsInSection:section];
        }
    }
    else if ([_model.status isEqualToString:@"2"])
    { // 待收货
        if ([_model.is_return isEqualToString:@"1"]) {
            return [self tableView:tableView returnGoddsnumberOfRowsInSection:section];
        }else {
            return [self tableView:tableView forGoodsnumberOfRowsInSection:section];
        }
        
    }
    else if ([_model.status isEqualToString:@"3"]&&[_model.is_return isEqualToString:@"0"])
    { // 订单完成
        return [self tableView:tableView orderFinishednumberOfRowsInSection:section];
    }
    else if ([_model.status isEqualToString:@"4"]||[_model.status isEqualToString:@"10"]||[_model.status isEqualToString:@"12"])
    { // 退货中
        return [self tableView:tableView returnGoddsnumberOfRowsInSection:section];
    }
    else if ([_model.status isEqualToString:@"8"]&&[_model.is_return isEqualToString:@"0"])
    { // 待付款
        return [self tableView:tableView paymentnumberOfRowsInSection:section];
    }
    else if ([_model.status isEqualToString:@"5"]&&[_model.is_return isEqualToString:@"0"])
    {
        return [self tableView:tableView evaluationGoodsnumberOfRowsInSection:section];
    }
    else
    { // 已关闭/已删除
        return [self tableView:tableView recyclingnumberOfRowsInSection:section];
    }
    
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([_model.status isEqualToString:@"1"])
    { // 待发货
        if ([_model.is_return isEqualToString:@"1"]) {
             return [self tableView:tableView returnGoddscellForRowAtIndexPath:indexPath];
        }else {
            return [self tableView:tableView sendGoodscellForRowAtIndexPath:indexPath];
            
        }
        
    }
    else if ([_model.status isEqualToString:@"2"])
    { // 待收货
        if ([_model.is_return isEqualToString:@"1"]) {
             return [self tableView:tableView returnGoddscellForRowAtIndexPath:indexPath];
        }else {
            
            return [self tableView:tableView forGoodscellForRowAtIndexPath:indexPath];
        }
        
    }
    else if ([_model.status isEqualToString:@"3"]&&[_model.is_return isEqualToString:@"0"])
    { // 订单完成
        return [self tableView:tableView orderFinishedcellForRowAtIndexPath:indexPath];
    }
    else if ([_model.status isEqualToString:@"4"]||[_model.status isEqualToString:@"10"]||[_model.status isEqualToString:@"12"])
    { // 退货中
        return [self tableView:tableView returnGoddscellForRowAtIndexPath:indexPath];
    }
    else if ([_model.status isEqualToString:@"8"]&&[_model.is_return isEqualToString:@"0"])
    { // 待付款
        return [self tableView:tableView paymentcellForRowAtIndexPath:indexPath];
    }
    else if ([_model.status isEqualToString:@"5"]&&[_model.is_return isEqualToString:@"0"])
    {
        return [self tableView:tableView evaluationGoodscellForRowAtIndexPath:indexPath];
    }
    else
    { // 已关闭/已删除
        return [self tableView:tableView recyclingcellForRowAtIndexPath:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([_model.status isEqualToString:@"1"])
    { // 待发货
        if ([_model.is_return isEqualToString:@"1"]) {
            [self tableView:tableView returnGoddsdidSelectRowAtIndexPath:indexPath];
        }else {
            
            [self tableView:tableView sendGoodsdidSelectRowAtIndexPath:indexPath];
        }
        
    }
    else if ([_model.status isEqualToString:@"2"])
    { // 待收货
        if ([_model.is_return isEqualToString:@"1"]) {
            [self tableView:tableView returnGoddsdidSelectRowAtIndexPath:indexPath];
        }else {
             [self tableView:tableView forGoodsdidSelectRowAtIndexPath:indexPath];
        }
       
    }
    else if ([_model.status isEqualToString:@"3"]&&[_model.is_return isEqualToString:@"0"])
    { // 订单完成
        [self tableView:tableView orderFinisheddidSelectRowAtIndexPath:indexPath];
    }
    else if ([_model.status isEqualToString:@"4"]||[_model.status isEqualToString:@"10"]||[_model.status isEqualToString:@"12"])
    { // 退货中
        [self tableView:tableView returnGoddsdidSelectRowAtIndexPath:indexPath];
    }
    else if ([_model.status isEqualToString:@"8"]&&[_model.is_return isEqualToString:@"0"])
    { // 待付款
        [self tableView:tableView paymentdidSelectRowAtIndexPath:indexPath];
    }
    else if ([_model.status isEqualToString:@"5"]&&[_model.is_return isEqualToString:@"0"])
    {
        [self tableView:tableView evaluationGoodsdidSelectRowAtIndexPath:indexPath];
    }
    else
    { // 已关闭/已删除
        [self tableView:tableView recyclingdidSelectRowAtIndexPath:indexPath];
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([_model.status isEqualToString:@"1"])
    { // 待发货
        if ([_model.is_return isEqualToString:@"1"]) {
            return [self tableView:tableView returnGoddsheightForRowAtIndexPath:indexPath];
        }else {
            return [self tableView:tableView sendGoodsheightForRowAtIndexPath:indexPath];
            
        }
        
    }
    else if ([_model.status isEqualToString:@"2"])
    { // 待收货
        if ([_model.is_return isEqualToString:@"1"]) {
            return [self tableView:tableView returnGoddsheightForRowAtIndexPath:indexPath];
        }else {
             return [self tableView:tableView forGoodsheightForRowAtIndexPath:indexPath];
            
        }
       
    }
    else if ([_model.status isEqualToString:@"3"]&&[_model.is_return isEqualToString:@"0"])
    { // 订单完成
        return [self tableView:tableView orderFinishedheightForRowAtIndexPath:indexPath];
    }
    else if ([_model.status isEqualToString:@"4"]||[_model.status isEqualToString:@"10"]||[_model.status isEqualToString:@"12"])
    { // 退货中
        return [self tableView:tableView returnGoddsheightForRowAtIndexPath:indexPath];
    }
    else if ([_model.status isEqualToString:@"8"]&&[_model.is_return isEqualToString:@"0"])
    { // 待付款
        return [self tableView:tableView paymentheightForRowAtIndexPath:indexPath];
    }
    else if ([_model.status isEqualToString:@"5"]&&[_model.is_return isEqualToString:@"0"])
    {
        return [self tableView:tableView evaluationGoodsheightForRowAtIndexPath:indexPath];
    }
    else
    { // 已关闭/已删除
        return [self tableView:tableView recyclingheightForRowAtIndexPath:indexPath];
    }
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if ([_model.status isEqualToString:@"1"])
    { // 待发货
        if ([_model.is_return isEqualToString:@"1"]) {
            return [self tableView:tableView returnGoddsheightForHeaderInSection:section];
        }else {
            return [self tableView:tableView sendGoodsheightForHeaderInSection:section];
        }
        
    }
    else if ([_model.status isEqualToString:@"2"])
    { // 待收货
        if ([_model.is_return isEqualToString:@"1"]) {
            return [self tableView:tableView returnGoddsheightForHeaderInSection:section];
        }else {
            return [self tableView:tableView forGoodsheightForHeaderInSection:section];
        }
    }
    else if ([_model.status isEqualToString:@"3"]&&[_model.is_return isEqualToString:@"0"])
    { // 订单完成
        return [self tableView:tableView orderFinishedheightForHeaderInSection:section];
    }
    else if ([_model.status isEqualToString:@"4"]||[_model.status isEqualToString:@"10"]||[_model.status isEqualToString:@"12"])
    { // 退货中
        return [self tableView:tableView returnGoddsheightForHeaderInSection:section];
    }
    else if ([_model.status isEqualToString:@"8"]&&[_model.is_return isEqualToString:@"0"])
    { // 待付款
        return [self tableView:tableView paymentheightForHeaderInSection:section];
    }
    else if ([_model.status isEqualToString:@"5"]&&[_model.is_return isEqualToString:@"0"])
    {
        return [self tableView:tableView evaluationGoodsheightForHeaderInSection:section];
    }
    else
    { // 已关闭/已删除
        return [self tableView:tableView recyclingheightForHeaderInSection:section];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if ([_model.status isEqualToString:@"1"])
    { // 待发货
        if ([_model.is_return isEqualToString:@"1"]) {
            return [self tableView:tableView returnGoddsviewForHeaderInSection:section];
        }else {
            return [self tableView:tableView sendGoodsviewForHeaderInSection:section];
        }
        
    }
    else if ([_model.status isEqualToString:@"2"])
    { // 待收货
        if ([_model.is_return isEqualToString:@"1"]) {
            return [self tableView:tableView returnGoddsviewForHeaderInSection:section];
        }else {
            return [self tableView:tableView forGoodsviewForHeaderInSection:section];
        }
    }
    else if ([_model.status isEqualToString:@"3"]&&[_model.is_return isEqualToString:@"0"])
    { // 订单完成
        return [self tableView:tableView orderFinisviewForHeaderInSection:section];
    }
    else if ([_model.status isEqualToString:@"4"]||[_model.status isEqualToString:@"10"]||[_model.status isEqualToString:@"12"])
    { // 退货中
        return [self tableView:tableView returnGoddsviewForHeaderInSection:section];
    }
    else if ([_model.status isEqualToString:@"8"]&&[_model.is_return isEqualToString:@"0"])
    { // 待付款
        return [self tableView:tableView paymentviewForHeaderInSection:section];
    }
    else if ([_model.status isEqualToString:@"5"]&&[_model.is_return isEqualToString:@"0"])
    {
        return [self tableView:tableView evaluationGoodsviewForHeaderInSection:section];
    }
    else
    { // 已关闭/已删除
        return [self tableView:tableView recyclingviewForHeaderInSection:section];
    }
    
}




#pragma mark --- 退款
- (void)refundgoos_money:(MKOrderListModel *)model {

    JXRefundViewController *refund = [[JXRefundViewController alloc] init];
    refund.model = model;
    [self.navigationController pushViewController:refund animated:YES];
}


#pragma mark --- 取消订单
- (void)cancelTheOrder:(MKOrderListModel *)model {
    
    [JXNetworkRequest asyncCanceltheOrder:[NSString stringWithFormat:@"%@",model.ordersn] completed:^(NSDictionary *messagedic) {
        [self showHint:messagedic[@"msg"]];
        
    } statisticsFail:^(NSDictionary *messagedic) {
        [self showHint:messagedic[@"msg"]];
    } fail:^(NSError *error) {
        
    }];
}

#pragma mark --- 提醒发货
- (void)remindthedeliveryOrder:(MKOrderListModel *)model {
    
    // if ([_funcdelegate respondsToSelector:@selector(scrollectiongIndex:)]) {
    //     [_funcdelegate scrollectiongIndex:_typesl+2];
    // }
    
    [JXNetworkRequest asyncRemindthedeliveryOrder:[NSString stringWithFormat:@"%@",model.ordersn] completed:^(NSDictionary *messagedic) {
        [self showHint:messagedic[@"msg"]];
    } statisticsFail:^(NSDictionary *messagedic) {
        [self showHint:messagedic[@"msg"]];
    } fail:^(NSError *error) {
        
    }];
}


#pragma mark --- 查看物流
- (void)checkLogistics:(MKOrderListModel *)model {
    
    JXCheckLogisticsViewController *check = [[JXCheckLogisticsViewController alloc] init];
    check.model = model;
    [self.navigationController pushViewController:check animated:YES];
}


#pragma mark --- 确认收货
- (void)confirmtheGoodsOrder:(MKOrderListModel *)model {
    
    [JXNetworkRequest asyncConfirmtheGoodsOrder:[NSString stringWithFormat:@"%@",model.ordersn] completed:^(NSDictionary *messagedic) {
        
        JXEvaluationViewController *ecalua = [[JXEvaluationViewController alloc] init];
        ecalua.model = model;
        [self.navigationController pushViewController:ecalua animated:YES];
    } statisticsFail:^(NSDictionary *messagedic) {
        [self showHint:messagedic[@"msg"]];
    } fail:^(NSError *error) {
        
    }];
}
#pragma mark --- 删除订单 刷新
- (void)deleteOrder:(MKOrderListModel *)model {
    
    [JXNetworkRequest asyncDeleteOrder:[NSString stringWithFormat:@"%@",model.ordersn] completed:^(NSDictionary *messagedic) {
        [self showHint:messagedic[@"msg"]];
        
    } statisticsFail:^(NSDictionary *messagedic) {
        [self showHint:messagedic[@"msg"]];
    } fail:^(NSError *error) {
        
    }];
}

#pragma mark --- 评价订单
- (void)evaluationOrder:(MKOrderListModel *)model{
    
    JXEvaluationViewController *ecalua = [[JXEvaluationViewController alloc] init];
    ecalua.model = model;
    [self.navigationController pushViewController:ecalua animated:YES];
    
}

#pragma mark --- 联系商家
- (void)contactthemerchantModel:(MKOrderListModel *)model {
    
    [JXNetworkRequest asyncOrdersn:model.ordersn completed:^(NSDictionary *messagedic) {
        NSString *photonum = messagedic[@"info"];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",photonum]]];
    } statisticsFail:^(NSDictionary *messagedic) {
        
    } fail:^(NSError *error) {
        
    }];
}

#pragma mark --- 取消退款
- (void)cancelTheRefund:(MKOrderListModel *)model {
    
    [JXNetworkRequest asynccancelTheRefundOrder:[NSString stringWithFormat:@"%@",model.ordersn] completed:^(NSDictionary *messagedic) {
        
        [self showHint:messagedic[@"msg"]];
    } statisticsFail:^(NSDictionary *messagedic) {
        [self showHint:messagedic[@"msg"]];
    } fail:^(NSError *error) {
        
    }];
    
}

#pragma mark --- 再次购买
- (void)onceAgaintoBuy:(MKOrderListModel *)model {
    // 先上传商品 （
    
    JXInvoicingViewController *invoicing = [[JXInvoicingViewController alloc] init];
    invoicing.hidesBottomBarWhenPushed = true;
    invoicing.goodsNumber = model.cart.count;
    invoicing.is_model = model;
    invoicing.retweetType = 1;
    [self.navigationController pushViewController:invoicing animated:YES];
}


#pragma mark --- 去支付
- (void)continueToPay:(MKOrderListModel *)model {
    
    // 支付宝
    [JXNetworkRequest asyncPayOrdersn:model.ordersn completed:^(NSDictionary *messagedic) {
        
        NSString *payid = [NSString stringWithFormat:@"%@",messagedic[@"info"][@"pay_id"]];
        if ( [payid isEqualToString:@"1"]) {
            [self zfPay:messagedic[@"info"][@"info"]];
        }else if ([payid isEqualToString:@"2"]){
            NSDictionary *wxpaydic = [self parseJSONStringToNSDictionary:messagedic[@"info"][@"info"]];
            [self wxPay:wxpaydic];
        }else {
            [self showHint:messagedic[@"msg"]];
        }
    } statisticsFail:^(NSDictionary *messagedic) {
        
    } fail:^(NSError *error) {
        
    }];
}
-(NSDictionary *)parseJSONStringToNSDictionary:(NSString *)JSONString {
    NSData *JSONData = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableLeaves error:nil];
    return responseJSON;
}

// 支付宝
- (void)zfPay:(NSString *)orderString {
    
    NSString *appScheme = @"alisdkdemo";
    // NOTE: 调用支付结果开始支付
    [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
        
        switch ([resultDic[@"resultStatus"] intValue]) {
            case 9000:
            {
                [self showHint:@"支付成功"];
            }
                break;
            case 8000:
            {
                [self showHint:@"正在处理中"];
            }
                break;
            case 4000:
            {
                [self showHint:@"支付失败"];
            }
                break;
            case 6001:
            {
                
                [self showHint:@"取消支付"];
            }
                break;
            case 6002:
            {
                
                [self showHint:@"网络连接错误"];
                
            }
                break;
            default:
                break;
        }
    }];
    
}

- (void)wxPay:(NSDictionary *)response {
    
    
    if (![WXApi isWXAppInstalled]) { // 检测用户是否安装微dateArray信
        [self showHint:@"未安装微信"];
    }else {
        PayReq *req  = [[PayReq alloc] init];
        req.partnerId = [response objectForKey:@"partnerid"];
        req.prepayId = [response objectForKey:@"prepayid"];
        req.package = [response objectForKey:@"package"];
        req.nonceStr = [response objectForKey:@"noncestr"];
        req.timeStamp = [[response objectForKey:@"timestamp"]intValue];
        req.sign = [response objectForKey:@"sign"];
        //调起微信支付
        [WXApi sendReq:req];
    }
}














































- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat sectionHeaderHeight = 10;
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0)
    {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    }
    else if(scrollView.contentOffset.y>=sectionHeaderHeight)
    {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
