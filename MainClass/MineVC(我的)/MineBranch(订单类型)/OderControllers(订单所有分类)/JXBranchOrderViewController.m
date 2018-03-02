//
//  JXBranchOrderViewController.m
//  JaneCargo
//
//  Created by cxy on 2017/7/7.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXBranchOrderViewController.h"

// 全部
#import "JXBranchOrderViewController+JXAllBranch.h"
// 待付款
#import "JXBranchOrderViewController+JXPaymentController.h"
// 待发货
#import "JXBranchOrderViewController+JXsendGoods.h"
// 待收货
#import "JXBranchOrderViewController+JXForGoods.h"
// 去评论
#import "JXBranchOrderViewController+JXComment.h"
// 退换货
#import "JXBranchOrderViewController+JXReturnGoods.h"
// 回收站
#import "JXBranchOrderViewController+JXRecycle.h"
#import "JXCheckLogisticsViewController.h"
#import "JXEvaluationViewController.h"
#import "JXShopCartViewController.h"
#import "JXCourierNumberViewController.h"

@interface JXBranchOrderViewController ()<WXpaySuccessdelegate,EvaluationGoodDelegate> {

    BOOL is_dropdown;
}

@property (nonatomic, assign) NSInteger typesl;

// 推荐产品控制器
@property (nonatomic, strong) JXHomePageCollectionViewController *collecotiongy;
//@property (nonatomic, strong) UIView *loading;
@property (nonatomic, strong) JXRotating *loading;
@end

@implementation JXBranchOrderViewController

static const CGFloat MJDuration = 0.5;

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.separatorStyle = UITableViewCellEditingStyleNone;
    [self.tableView setBackgroundColor:kUIColorFromRGB(0xf2f2f2)];
    [self.tableView registerClass:[JXPromotionTableViewCell class] forCellReuseIdentifier:@"pros"];
    [self removedata];
    // 接收消息
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(wxpayResultsAction:) name:@"WXpayResults" object:nil];
}

-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
#pragma mark --- 微信支付成功代理
- (void)paySuccess {
    
//    if ([_funcdelegate respondsToSelector:@selector(wxPayscrollectiongIndex:)]) {
        [_funcdelegate wxPayscrollectiongIndex:2];
//    }
}

- (void)wxpayResultsAction:(NSNotification *)objc {
    
    
    
    NSString *payresult = objc.object;
    if ([payresult isEqualToString:@"成功"]) {
//        if ([_funcdelegate respondsToSelector:@selector(wxPayscrollectiongIndex:)]) {
//            [_funcdelegate wxPayscrollectiongIndex:2];
//        }
    }else {
        
        [self showHint:@"支付失败"];
    }
    
}

- (void)removedata {
    

    self.recommendedArray = @[].mutableCopy;
    self.dateArray = @[].mutableCopy;
    // 待付款
    self.paymentArray = @[].mutableCopy;
    // 待发货
    self.deliveryArray = @[].mutableCopy;
    // 待收货
    self.goodsArray = @[].mutableCopy;
    // 去评论
    self.commentsArray = @[].mutableCopy;
    // 退换货
    self.returnArray = @[].mutableCopy;
    // 回收站
    self.stationArray = @[].mutableCopy;
    
    [self processTheDataRequest];
    [self y_dateRequest];
}
#pragma mark - 推荐商品
- (void)y_dateRequest {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [JXNetworkRequest asyncRecommendedcompleted:^(NSDictionary *messagedic) {
            NSArray *infoArray = messagedic[@"info"];
            for (NSDictionary *infodic in infoArray) {
                JXHomepagModel *model = [[JXHomepagModel alloc] init];
                [model setValuesForKeysWithDictionary:infodic];
                [self.recommendedArray addObject:model];
            }
            [self.tableView reloadData];
        } statisticsFail:^(NSDictionary *messagedic) {
            
        } fail:^(NSError *error) {
            
        }];
    });
}

- (void)processTheDataRequest {

    if ([self.title isEqualToString:@"全部"])
    {
        [self processTheAllData:nil ordersn:@"" datedic:^(NSDictionary *messagedic) {
            [self addedToTheModel:messagedic date:self.dateArray];
        } fail:^(NSError *error) {
            
        }];
    }
    else if ([self.title isEqualToString:@"待付款"])
    {
        self.typesl = 1;
        [self processTheAllData:@"8" ordersn:@"" datedic:^(NSDictionary *messagedic) {
            [self addedToTheModel:messagedic date:self.paymentArray];
        } fail:^(NSError *error) {
            
        }];

    }
    else if ([self.title isEqualToString:@"待发货"])
    {
        self.typesl = 2;
        [self processTheAllData:@"1" ordersn:@"" datedic:^(NSDictionary *messagedic) {
            [self addedToTheModel:messagedic date:self.deliveryArray];
        } fail:^(NSError *error) {
            
        }];

    }
    else if ([self.title isEqualToString:@"待收货"])
    {
        self.typesl = 3;
        [self processTheAllData:@"2" ordersn:@"" datedic:^(NSDictionary *messagedic) {
            [self addedToTheModel:messagedic date:self.goodsArray];
        } fail:^(NSError *error) {
            
        }];
    }
    else if ([self.title isEqualToString:@"去评论"])
    {
        self.typesl = 4;
        [self processTheAllData:@"3" ordersn:@"" datedic:^(NSDictionary *messagedic) {
            [self addedToTheModel:messagedic date:self.commentsArray];
        } fail:^(NSError *error) {
            
        }];

    }
    else if ([self.title isEqualToString:@"退换货"])
    {
        self.typesl = 5;
        [self processTheAllData:@"4" ordersn:@"" datedic:^(NSDictionary *messagedic) {
            [self addedToTheModel:messagedic date:self.returnArray];
        } fail:^(NSError *error) {
            
        }];

    }
    else if ([self.title isEqualToString:@"回收站"])
    {
        self.typesl = 6;
        [self processTheAllData:@"9" ordersn:@"" datedic:^(NSDictionary *messagedic) {
            [self addedToTheModel:messagedic date:self.stationArray];
        } fail:^(NSError *error) {
            
        }];

    }
}

- (void)addedToTheModel:(NSDictionary *)messagedic date:(NSMutableArray *)date{

    if ([messagedic[@"status"] integerValue] == 200) {
        NSArray *messageArray =messagedic[@"info"];
        if (!kArrayIsEmpty(messageArray)) {
            for (NSDictionary* list in messageArray)
            {
                MKOrderListModel* obj = [MKOrderListModel mj_objectWithKeyValues:list];
                [date addObject:obj];
            }
            //通知主线程刷新
            dispatch_async(dispatch_get_main_queue(), ^{
                //回调或者说是通知主线程刷新，
                 [self.tableView reloadData];
            });
        }
    }else {
        [self showHint:@"没有订单"];
    }
  
}
// 展示促销产品
- (void)showPromotion:(UITableViewCell *)cell {
    
    [self.collecotiongy willMoveToParentViewController:nil];
    [self.collecotiongy.view removeFromSuperview];
    [self.collecotiongy removeFromParentViewController];
    
    NSInteger line = [JXEncapSulationObjc s_calculateNumberArrayNum:self.recommendedArray.count singleNumber:2];
    JXHomePageLayOut *gylay = [[JXHomePageLayOut alloc] init];
    self.collecotiongy = [[JXHomePageCollectionViewController alloc] initWithCollectionViewLayout:gylay];
    [self.collecotiongy.view setFrame:CGRectMake(0, 0, NPWidth, line * BranchOrder_Collection_Height)];
    self.collecotiongy.recommendedArray = self.recommendedArray;
    [self addChildViewController:self.collecotiongy];
    [cell addSubview:self.collecotiongy.view];
    [self.collecotiongy didMoveToParentViewController:self];
    
}
#pragma mark -- 请求数据
- (void)processTheAllData:(NSString *)status ordersn:(NSString *)ordersn datedic:(void(^)(NSDictionary *messagedic))datedic fail:(void(^)(NSError *error))fail{

    self.loading = [JXRotating initWithRotaing];
    [self.view addSubview:self.loading];
    [self.view bringSubviewToFront:self.loading];
    // 全部
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // 处理耗时操作的代码块...
        
        [JXNetworkRequest asyncuser_orderStatus:status ordersn:ordersn completed:^(NSDictionary *messagedic) {
            datedic(messagedic);
            [self endofthedropdown];
            
        } statisticsFail:^(NSDictionary *messagedic) {
            [self endofthedropdown];
        } fail:^(NSError *error) {
            [self endofthedropdown];
            fail(error);
        }];
        
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    if (_typesl == 0) {
        return [self allNumberOfSectionsInTableView:tableView];
    }else if (_typesl == 1) {
        return [self payNumberOfSectionsInTableView:tableView];
    }else if (_typesl == 2) {
        return [self sendNumberOfSectionsInTableView:tableView];
    }else if (_typesl ==3) {
        return [self goodsNumberOfSectionsInTableView:tableView];
    }else if (_typesl == 4) {
        return [self orderNumberOfSectionsInTableView:tableView];
    }else {
        return [self recycleNumberOfSectionsInTableView:tableView];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (_typesl == 0) {
        return [self tableView:tableView allNumberOfRowsInSection:section];
    }else if (_typesl == 1) {
        return [self tableView:tableView payNumberOfRowsInSection:section];
    }else if (_typesl == 2) {
        return [self tableView:tableView sendNumberOfRowsInSection:section];
    }else if (_typesl ==3) {
        return [self tableView:tableView goodsNumberOfRowsInSection:section];
    }else if (_typesl == 4) {
        return [self tableView:tableView orderNumberOfRowsInSection:section];
    }else {
        return [self tableView:tableView recycleNumberOfRowsInSection:section];
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_typesl == 0) {
        return [self tableView:tableView allCellForRowAtIndexPath:indexPath];
    }else if (_typesl == 1) {
        return [self tableView:tableView payCellForRowAtIndexPath:indexPath];
    }else if (_typesl == 2) {
        return [self tableView:tableView sendCellForRowAtIndexPath:indexPath];
    }else if (_typesl ==3) {
        return [self tableView:tableView goodsCellForRowAtIndexPath:indexPath];
    }else if (_typesl == 4) {
        return [self tableView:tableView orderCellForRowAtIndexPath:indexPath];
    }else {
        return [self tableView:tableView recycleCellForRowAtIndexPath:indexPath];
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (_typesl == 0) {
        return [self tableView:tableView didAllSelectRowAtIndexPath:indexPath];
    }else if (_typesl == 1) {
        return [self tableView:tableView didpaySelectRowAtIndexPath:indexPath];
    }else if (_typesl == 2) {
        return [self tableView:tableView didsendSelectRowAtIndexPath:indexPath];
    }else if (_typesl ==3) {
        return [self tableView:tableView didgoodsSelectRowAtIndexPath:indexPath];
    }else if (_typesl == 4) {
        return [self tableView:tableView didorderSelectRowAtIndexPath:indexPath];
    }else {
        return [self tableView:tableView didrecycleSelectRowAtIndexPath:indexPath];
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (_typesl == 0) {
        return [self tableView:tableView allHeightForRowAtIndexPath:indexPath];
    }else if (_typesl == 1) {
        return [self tableView:tableView payHeightForRowAtIndexPath:indexPath];
    }else if (_typesl == 2) {
        return [self tableView:tableView sendHeightForRowAtIndexPath:indexPath];
    }else if (_typesl ==3) {
        return [self tableView:tableView goodsHeightForRowAtIndexPath:indexPath];
    }else if (_typesl == 4) {
        return [self tableView:tableView orderHeightForRowAtIndexPath:indexPath];
    }else {
        return [self tableView:tableView recycleHeightForRowAtIndexPath:indexPath];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (_typesl == 0) {
        return [self tableView:tableView allHeightForHeaderInSection:section];
    }else if (_typesl == 1) {
        return [self tableView:tableView payHeightForHeaderInSection:section];
    }else if (_typesl == 2) {
        return [self tableView:tableView sendHeightForHeaderInSection:section];
    }else if (_typesl ==3) {
        return [self tableView:tableView goodsHeightForHeaderInSection:section];
    }else if (_typesl == 4) {
        return [self tableView:tableView orderHeightForHeaderInSection:section];
    }else {
        return [self tableView:tableView recycleHeightForHeaderInSection:section];
    }
}




- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    if (_typesl == 0) {
        return [self tableView:tableView allheightForFooterInSection:section];
    }else if (_typesl == 1) {
        return [self tableView:tableView payheightForFooterInSection:section];
    }else if (_typesl == 2) {
        return [self tableView:tableView sendheightForFooterInSection:section];
    }else if (_typesl ==3) {
        return [self tableView:tableView goodsheightForFooterInSection:section];
    }else if (_typesl == 4) {
        return [self tableView:tableView orderheightForFooterInSection:section];
    }else {
        return [self tableView:tableView recycleheightForFooterInSection:section];
    }
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 64)];
    [view setBackgroundColor:kUIColorFromRGB(0xf2f2f2)];
    return view;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 10)];
    [view setBackgroundColor:kUIColorFromRGB(0xf2f2f2)];
    return view;
}

- (void)jumpInterface:(MKOrderListModel *)model type:(NSInteger)type{
    
    
    [JXJudgeStrObjc distinguishTheCategory:model delivery:^{ // 待发货
        
//        _indexType = 0;
        if ([model.is_return isEqualToString:@"1"]) {
            if (type == 0)
            { //
                NSLog(@"no");
            }
            else if (type == 1)
            { // 联系商家
                [self contactthemerchantModel:model];
            }
        }else {
            if (type == 0)
            { //
                NSLog(@"no");
            }
            else if (type == 1)
            { // 提醒发货
                [self remindthedeliveryOrder:model];
            }
            
        }
        
    } goods:^{  // 待收货
        if (type == 0)
        { // 查看物流
            [self checkLogistics:model];
        }
        else if (type == 1)
        { // 确定收货
            [self confirmtheGoodsOrder:model];
        }
    } orderfinished:^{ // 订单完成
        if (type == 0)
        { // 删除订单
            [self deleteOrder:model];
        }
        else if (type == 1)
        { // 去评价
            [self evaluationOrder:model];
        }
    } returngoods:^{ // 退货中
        if (type == 0)
        { // 联系商家
            [self contactthemerchantModel:model];
        }
        else if (type == 1)
        { // 取消退款
            [self cancelTheRefund:model];
        }
    } payment:^{ // 待付款
        if (type == 0)
        { // 取消订单
            [self cancelTheOrder:model];
        }
        else if (type == 1)
        { // 去支付
            [self continueToPay:model];
        }
    } recycling:^{ // 已关闭/已删除
        if (type == 0)
        { //
            
        }
        else if (type == 1)
        { // 再次购买
//            [self onceAgaintoBuy:model];
        }
    } evaluation:^{ // 已评价
        if (type == 0)
        {// 再次购买
            [self onceAgaintoBuy:model];
        }
        else if (type == 1)
        { 
            // 删除
            [self cancelTheOrder:model];
        }
    } refund:^{ // 退款
        if (type == 0)
        { // 取消退款
            [self cancelTheRefund:model];
        }
        else if (type == 1)
        { // 联系商家
            [self contactthemerchantModel:model];
        }
    } rejected:^{ // 申请被拒
        
    } complete:^{ // 退款完成
        if (type == 0)
        { // 删除订单
            [self cancelTheOrder:model];
        }
        else if (type == 1)
        { // 再次购买
//            [self onceAgaintoBuy:model];
        }
    } refundon:^{ // 退款进行中
        if (type == 0)
        { // no
            
        }
        else if (type == 1)
        { // 联系商家
            [self contactthemerchantModel:model];
        }
    } agreerefund:^{ // 同意退款
        if (type == 0)
        { // 联系商家
            [self contactthemerchantModel:model];
        }
        else if (type == 1)
        { // 填写快递单号
            [self fillintheCourier:model];
        }
    }];
}
// 填写快递单
- (void)fillintheCourier:(MKOrderListModel *)model {
    
    JXCourierNumberViewController *courier = [[JXCourierNumberViewController alloc] init];
    courier.model = model;
    [self.navigationController pushViewController:courier animated:YES];
}

#pragma mark --- 进入二级页面
- (void)orderMessageModel:(MKOrderListModel *)model {

    JXOrderDetailViewController *order = [JXOrderDetailViewController alloc];
    order.paySuccessdelegate = self;
    order.model = model;
    [self.navigationController pushViewController:order animated:YES];
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

#pragma mark --- 取消订单
- (void)cancelTheOrder:(MKOrderListModel *)model {
    
    [JXNetworkRequest asyncCanceltheOrder:[NSString stringWithFormat:@"%@",model.ordersn] completed:^(NSDictionary *messagedic) {
        [self showHint:messagedic[@"msg"]];
        [self removedata];
        
    } statisticsFail:^(NSDictionary *messagedic) {
        [self showHint:messagedic[@"msg"]];
    } fail:^(NSError *error) {
        
    }];
}

#pragma mark --- 提醒发货
- (void)remindthedeliveryOrder:(MKOrderListModel *)model {

   
    
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
        [self removedata];
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
        [self removedata];
    } statisticsFail:^(NSDictionary *messagedic) {
        [self showHint:messagedic[@"msg"]];
    } fail:^(NSError *error) {
        
    }];
}

#pragma mark --- 评价订单
- (void)evaluationOrder:(MKOrderListModel *)model{

    JXEvaluationViewController *ecalua = [[JXEvaluationViewController alloc] init];
    ecalua.model = model;
    ecalua.evaluatdelegate = self;
    [self.navigationController pushViewController:ecalua animated:YES];
    
}
// 评论代理
- (void)evaluationGoodStart {
     [self removedata];
}
#pragma mark --- 联系商家


#pragma mark --- 取消退款
- (void)cancelTheRefund:(MKOrderListModel *)model {

    [JXNetworkRequest asynccancelTheRefundOrder:[NSString stringWithFormat:@"%@",model.ordersn] completed:^(NSDictionary *messagedic) {
        [self removedata];
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



#pragma mark -- headerView是否悬浮
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
    CGFloat contentOffset = scrollView.contentOffset.y;
    if (!is_dropdown && contentOffset < -60) {
        is_dropdown = YES;
        [self s_dropdownMJRefresh];
    }
}




#pragma mark UITableView + 下拉刷新 默认
- (void)s_dropdownMJRefresh { // dropdown
    __unsafe_unretained __typeof(self) weakSelf = self;
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadNewData];
        
    }];
    // 马上进入刷新状态
    [self.tableView.mj_header beginRefreshing];
}
- (void)loadNewData {
    
//    [self.dateArray removeAllObjects];
    // 刷新过程中停止交互
    //    self.browseTable.scrollEnabled = NO;
    // 刷新表格
    
    // 直接控制下拉时间避免等待时间过长
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(MJDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self removedata];
        
        
    });
}
#pragma mark -- 下拉结束
- (void)endofthedropdown {
    // 拿到当前的下拉刷新控件，结束刷新状态
    [self.tableView.mj_header endRefreshing];
    self.tableView.scrollEnabled = YES;
}








@end
