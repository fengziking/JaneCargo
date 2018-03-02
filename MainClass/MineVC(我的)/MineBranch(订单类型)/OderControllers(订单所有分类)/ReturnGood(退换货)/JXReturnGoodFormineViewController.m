//
//  JXReturnGoodFormineViewController.m
//  JaneCargo
//
//  Created by 鹏 on 2017/9/7.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXReturnGoodFormineViewController.h"
#import "JXBranchOrderTableViewCell.h"
#import "JXBranchGoodsTableViewCell.h"
#import "JXSettlementTableViewCell.h"
#import "JXBranchPayTableViewCell.h"
// 没有订单
#import "JXNoOrderTableViewCell.h"

#import "JXOrderDetailViewController.h"
#import "JXCourierNumberViewController.h"

@interface JXReturnGoodFormineViewController () {

    BOOL is_dropdown;
    NSInteger is_regat;
}
// 退换货
@property (nonatomic,strong) NSMutableArray *returnArray;
@property (nonatomic,strong) NSMutableArray *recommendedArray;
//@property (nonatomic, strong) UIView *loading;
@property (nonatomic, strong) JXRotating *loading;
// 推荐产品控制器
@property (nonatomic, strong) JXHomePageCollectionViewController *collecotiongy;

@end

@implementation JXReturnGoodFormineViewController

static const CGFloat MJDuration = 0.5;


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [JXEncapSulationObjc blackNavigation:self color:[UIColor whiteColor]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel * titleLabel =[[UILabel alloc]init];
    titleLabel.text = @"退换货";
    [titleLabel sizeToFit];
    titleLabel.textColor = [UIColor blackColor];
    self.navigationItem.titleView = titleLabel;
    // 退换货
    self.returnArray = @[].mutableCopy;
    self.recommendedArray = @[].mutableCopy;
    [self y_navigation];
    [self y_dateRequest];
    //[self processTheAllData:@"4" ordersn:@"" datedic:^(NSDictionary *messagedic) {
    //    [self addedToTheModel:messagedic date:self.returnArray];
   // } fail:^(NSError *error) {
        
   // }];
    [self requestrefund];
}



- (void)requestrefund {

    [JXNetworkRequest asyncrefundorderCompleted:^(NSDictionary *messagedic) {
        [self addedToTheModel:messagedic date:self.returnArray];
        [self endofthedropdown];
    } statisticsFail:^(NSDictionary *messagedic) {
        [self endofthedropdown];
    } fail:^(NSError *error) {
        [self endofthedropdown];
    }];
}





- (void)y_navigation {

    self.automaticallyAdjustsScrollViewInsets = YES;
    self.tableView.separatorStyle = UITableViewCellEditingStyleNone;
    [self.tableView setBackgroundColor:kUIColorFromRGB(0xf2f2f2)];
    [self.tableView registerClass:[JXPromotionTableViewCell class] forCellReuseIdentifier:@"pros"];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_back"] style:(UIBarButtonItemStylePlain) target:self action:@selector(leftAction:)];
    
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior =UIScrollViewContentInsetAdjustmentNever;
        self.tableView.contentInset =UIEdgeInsetsMake(64,0,0,0);//64和49自己看效果，是否应该改成0
        self.tableView.scrollIndicatorInsets =self.tableView.contentInset;
    }
    
}
- (void)leftAction:(UIBarButtonItem *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -- 请求数据
- (void)processTheAllData:(NSString *)status ordersn:(NSString *)ordersn datedic:(void(^)(NSDictionary *messagedic))datedic fail:(void(^)(NSError *error))fail{
//    // 全部

    self.loading = [JXRotating initWithRotaing];
    [self.view addSubview:self.loading];
    [JXNetworkRequest asyncuser_orderStatus:status ordersn:ordersn completed:^(NSDictionary *messagedic) {
        datedic(messagedic);

    } statisticsFail:^(NSDictionary *messagedic) {

    } fail:^(NSError *error) {

        fail(error);
    }];
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
            [self.tableView reloadData];
        }
    }else {
        [self showHint:@"没有订单"];
    }
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    if (self.returnArray.count == 0 && is_regat != 1) {
        return 1;
    }else {
        return self.returnArray.count;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (self.returnArray.count == 0 && is_regat != 1) {
        return 3;
    }else {
        MKOrderListModel * tempModle = (MKOrderListModel*)self.returnArray[section];
        return 3+tempModle.cart.count;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.returnArray.count == 0 && is_regat != 1) {
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
        MKOrderListModel * tempModle;;
        if (self.returnArray.count>0) {
            tempModle = (MKOrderListModel*)self.returnArray[indexPath.section];
        }
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
            if (self.returnArray.count >0) {
                cell.model = ((MKOrderListModel*)self.returnArray[indexPath.section]).cart[indexPath.row-1];
            }
            return cell;
        }
    }
}


- (void)jumpInterface:(MKOrderListModel *)model type:(NSInteger)type {
    
    
    [JXJudgeStrObjc distinguishTheCategory:model delivery:^{ // 待发货
        
        if ([model.is_return isEqualToString:@"1"]) {
            if (type == 0)
            {
                // 联系商家
                [self contactthemerchantModel:model];
            }
            else if (type == 1)
            {
                //
                [self cancelTheRefund:model];
            }
        }else {
            
            if (type == 0)
            { //
                NSLog(@"no");
            }
            else if (type == 1)
            { // 提醒发货
                
            }
            
        }
        
    } goods:^{  // 待收货
        if (type == 0)
        { // 查看物流
            
        }
        else if (type == 1)
        { // 确定收货
            
        }
    } orderfinished:^{ // 订单完成
        
    } returngoods:^{ // 退货中
        if (type == 0)
        {
//            // 联系商家
//            [self contactthemerchantModel:model];
        }
        else if (type == 1)
        {
//            // 取消退款
//            [self cancelTheRefund:model];
            // 联系商家
            [self contactthemerchantModel:model];
        }
    } payment:^{ // 待付款
        
    } recycling:^{ // 已关闭/已删除
        
    } evaluation:^{ // 已评价
        
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
        {
            // 再次购买
            //            [self onceAgaintoBuy:model];
        }
        else if (type == 1)
        {
            // 删除订单
            [self cancelTheOrder:model];
        }
    } refundon:^{ // 退款进行中
        if (type == 0)
        { // 联系商家
            [self contactthemerchantModel:model];
        }
        else if (type == 1)
        { // 填写快递单号
            [self fillintheCourier:model];
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

#pragma mark ---  填写快递单
- (void)fillintheCourier:(MKOrderListModel *)model {
    
    JXCourierNumberViewController *courier = [[JXCourierNumberViewController alloc] init];
    courier.model = model;
    [self.navigationController pushViewController:courier animated:YES];
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
#pragma mark --- 取消订单
- (void)cancelTheOrder:(MKOrderListModel *)model {
    
    [JXNetworkRequest asyncCanceltheOrder:[NSString stringWithFormat:@"%@",model.ordersn] completed:^(NSDictionary *messagedic) {
        [self showHint:messagedic[@"msg"]];
        //[self removedata];
        
    } statisticsFail:^(NSDictionary *messagedic) {
        [self showHint:messagedic[@"msg"]];
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
#pragma mark --- 联系商家
- (void)contactthemerchantModel:(MKOrderListModel *)model {
    
    [JXNetworkRequest asyncOrdersn:model.ordersn completed:^(NSDictionary *messagedic) {
        NSString *photonum = messagedic[@"info"];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",photonum]]];
    } statisticsFail:^(NSDictionary *messagedic) {
        
    } fail:^(NSError *error) {
        
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.returnArray.count>0) {
        MKOrderListModel * tempModle = (MKOrderListModel*)self.returnArray[indexPath.section];
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


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (self.returnArray.count == 0) {
        return 0;
    }else {
        return 10;
    }
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, NPWidth, 10)];
    return view;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.returnArray.count == 0) {
        NSInteger line = [JXEncapSulationObjc s_calculateNumberArrayNum:self.recommendedArray.count singleNumber:2];
        if (indexPath.row == 0) {
            return 271;
        }else if (indexPath.row == 1){
            return TableViewControllerCell_Height;
        }else {
            
            return line * BranchOrder_Collection_Height;
        }
    }else {
        MKOrderListModel * tempModle = (MKOrderListModel*)self.returnArray[indexPath.section];
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


#pragma mark - 推荐商品
- (void)y_dateRequest {
    
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
}


#pragma mark --
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat contentOffset = scrollView.contentOffset.y;
    if (!is_dropdown && contentOffset < 0) {
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
    
    if (self.returnArray.count>0) {
        is_regat = 1;
    }
    [self.returnArray removeAllObjects];
    
    // 刷新过程中停止交互
    self.tableView.scrollEnabled = NO;
    // 刷新表格
    
    // 直接控制下拉时间避免等待时间过长
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(MJDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self requestrefund];
        
    });
}
#pragma mark -- 下拉结束
- (void)endofthedropdown {
    // 拿到当前的下拉刷新控件，结束刷新状态
    [self.tableView.mj_header endRefreshing];
    self.tableView.scrollEnabled = YES;
}




//// 头部滑动
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    
//    CGFloat sectionHeaderHeight = 10;
//    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0)
//    {
//        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
//    }
//    else if(scrollView.contentOffset.y>=sectionHeaderHeight)
//    {
//        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
//    }
//}

@end
