//
//  JXSearchResultsViewController.m
//  JaneCargo
//
//  Created by 鹏 on 2017/8/23.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXSearchResultsViewController.h"
#import "JXOrderDetailViewController.h"
#import "JXBranchOrderTableViewCell.h"
#import "JXBranchGoodsTableViewCell.h"
#import "JXSettlementTableViewCell.h"
#import "JXBranchPayTableViewCell.h"
#import "JXCheckLogisticsViewController.h"
#import "JXEvaluationViewController.h"
#import "JXCourierNumberViewController.h"
@interface JXSearchResultsViewController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>


@property (nonatomic, strong) UITableView *resultTable;
/** 搜索框*/
@property(strong,nonatomic) UISearchBar *searchBar;
/** 占位文字*/
@property(copy,nonatomic) NSString *placeHolder;

@property (nonatomic, strong) NSMutableArray *dateArray;

@end

@implementation JXSearchResultsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dateArray = @[].mutableCopy;
    [self goodsNavigate];
    [self setupBasic];
    [self y_requestdate];
    // 接收消息
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(wxpayResultsAction:) name:@"WXpayResults" object:nil];
}

-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)wxpayResultsAction:(NSNotification *)objc {
    
    
    NSString *payresult = objc.object;
    if ([payresult isEqualToString:@"成功"]) {
        if ([_orderpaydelegte respondsToSelector:@selector(orderpaysuccess)]) {
            [_orderpaydelegte orderpaysuccess];
        }
        [self.navigationController popViewControllerAnimated:NO];
    }else {
        
        [self showHint:@"支付失败"];
    }
}


- (void)y_requestdate {

    [self processTheAllData:nil ordersn:self.orederStr datedic:^(NSDictionary *messagedic) {
        [self addedToTheModel:messagedic date:self.dateArray];
    } fail:^(NSError *error) {
        
    }];
}

- (void)setupBasic {
    
    self.resultTable = [[UITableView alloc] init];
    self.resultTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.resultTable setBackgroundColor:kUIColorFromRGB(0xf2f2f2)];
    self.resultTable.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    self.resultTable.dataSource = self;
    self.resultTable.delegate = self;
    [self.view addSubview:self.resultTable];
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
            [self.resultTable reloadData];
        }
    }else {
        [self showHint:@"提示无数据"];
    }
}

- (void)processTheAllData:(NSString *)status ordersn:(NSString *)ordersn datedic:(void(^)(NSDictionary *messagedic))datedic fail:(void(^)(NSError *error))fail{
    
    [JXNetworkRequest asyncuser_orderStatus:status ordersn:ordersn completed:^(NSDictionary *messagedic) {
        datedic(messagedic);
    } statisticsFail:^(NSDictionary *messagedic) {
        
    } fail:^(NSError *error) {
        
        fail(error);
    }];
    
    
}

- (void)goodsNavigate {
    
    
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
     self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.searchBar];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_back"] style:(UIBarButtonItemStylePlain) target:self action:@selector(leftAction:)];
}
- (void)leftAction:(UIBarButtonItem *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.dateArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    MKOrderListModel * tempModle = (MKOrderListModel*)self.dateArray[section];
    return 3+tempModle.cart.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    
    MKOrderListModel * tempModle = (MKOrderListModel*)self.dateArray[indexPath.section];
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
        if (self.dateArray.count >0) {
            cell.model = ((MKOrderListModel*)self.dateArray[indexPath.section]).cart[indexPath.row-1];
        }
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.dateArray.count>0) {
        MKOrderListModel * tempModle = (MKOrderListModel*)self.dateArray[indexPath.section];
        if (indexPath.row!=0&&indexPath.row!=3+tempModle.cart.count-2&&indexPath.row!=3+tempModle.cart.count-1) {
            [self orderMessageModel:tempModle];
        }
    }
}

#pragma mark --- 进入二级页面
- (void)orderMessageModel:(MKOrderListModel *)model {
    
    JXOrderDetailViewController *order = [JXOrderDetailViewController alloc];
    order.model = model;
    [self.navigationController pushViewController:order animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    MKOrderListModel * tempModle = (MKOrderListModel*)self.dateArray[indexPath.section];
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
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, NPWidth, 10)];
    return view;
    
}


- (void)jumpInterface:(MKOrderListModel *)model type:(NSInteger)type{
    
    
    [JXJudgeStrObjc distinguishTheCategory:model delivery:^{ // 待发货
        
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
        { // 删除
            [self cancelTheOrder:model];
        }
        else if (type == 1)
        { // 再次购买
//            [self onceAgaintoBuy:model];
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
        [self.dateArray removeAllObjects];
        [self y_requestdate];
        
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
        [self.dateArray removeAllObjects];
        [self y_requestdate];
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
        [self.dateArray removeAllObjects];
        [self y_requestdate];
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



#pragma mark --- 取消退款
- (void)cancelTheRefund:(MKOrderListModel *)model {
    
    [JXNetworkRequest asynccancelTheRefundOrder:[NSString stringWithFormat:@"%@",model.ordersn] completed:^(NSDictionary *messagedic) {
        [self.dateArray removeAllObjects];
        [self y_requestdate];
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
















- (NSString *)placeHolder {
    
    if (!_placeHolder) {
        _placeHolder = @"请输入商品名称";
    }
    return _placeHolder;
}

- (UISearchBar *)searchBar
{
    if (!_searchBar) { // 70 90
        
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width-70, 30)];
        _searchBar.delegate = self;
        _searchBar.placeholder = self.placeHolder;
        [self.searchBar setBarStyle:UIBarStyleBlackOpaque];// 搜索框样式
        [self.searchBar setSearchFieldBackgroundImage:[UIImage imageNamed:@"bg_sl"] forState:(UIControlStateNormal)];
    }
    return _searchBar;
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
