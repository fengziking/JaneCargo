//
//  JXInvoicingViewController.m
//  JaneCargo
//
//  Created by 鹏 on 2017/7/28.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXInvoicingViewController.h"
#import "JXInvoicingAddressTableViewCell.h"
#import "JXInvoicingTitleShopTableViewCell.h"
#import "JXInvoicingShopTableViewCell.h"
#import "JXInvoicingReturnTableViewCell.h"
#import "JXInvoicingPayWayTableViewCell.h"
#import "JXInvoicingInvoiceTableViewCell.h"
#import "JXInvoicingEinTableViewCell.h"
#import "JXFillAddressTableViewCell.h"


#import "JXSettlementView.h"
#import "MKGoodsModel.h"
#import "MKOrderListModel.h"
#import "JXPayWPViewController.h"
#import "JXLeaveViewController.h"
// 地址
#import "JXAddressViewController.h"

#import "JXAllOrderViewController.h"

@interface JXInvoicingViewController ()<UITableViewDelegate,UITableViewDataSource,InvoicingTextFieldDelegate,Paymentdelegate,LeaveAmessagedelegate,SelectAddressdelegate>

// 地址id
@property (nonatomic, strong) NSString *address_id;
// 用户留言
@property (nonatomic, strong) NSString *userMessage_str;
// 支付方式
@property (nonatomic, strong) NSString *pay_way;
// 是否开票
@property (nonatomic, assign) NSInteger is_invoice;
// 抬头
@property (nonatomic, strong) NSString *invoice_Look;
// 税号
@property (nonatomic, strong) NSString *ein_number;

@property (nonatomic, assign) BOOL onSwitch;
@property (nonatomic, strong) UITableView *invoicingTable;
@property (nonatomic, strong) JXSettlementView *footView;

@property (nonatomic, strong) NSArray *paywayArray;
@property (nonatomic, strong) NSArray *invoiceArray;
@property (nonatomic, strong) NSArray *placeArray;
@property (nonatomic, strong) NSString *payment_Str;
@property (nonatomic, strong) JXAddressModel *selectModel;

@property (nonatomic, strong) NSMutableArray *requestArray;
@property (nonatomic, strong) NSMutableArray *goods_id;
// 快递费
@property (nonatomic, assign) NSInteger courierFee_str;

@end

@implementation JXInvoicingViewController

- (NSArray *)paywayArray {
    
    return @[@"给卖家留言",@"支付方式"];
}
- (NSArray *)invoiceArray {
    
    return @[@"是否需要发票",@"发票抬头:",@"公司税号:"];
}
- (NSArray *)placeArray {
    
    return @[@"",@"请输入发票抬头",@"请输入公司税号"];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [JXEncapSulationObjc blackNavigation:self color:[UIColor whiteColor]];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDictionary *modelArray = [JXUserDefaultsObjc defaultaddress];
    if (modelArray.count > 0) {
        [JXUserDefaultsObjc storagedefaultCart:modelArray];
    }
    _payment_Str = @"支付宝";
    _onSwitch = NO;
    _goods_id = @[].mutableCopy;
    self.requestArray = @[].mutableCopy;
    [self navigation];
    switch (_retweetType) {
        case 0:
        {
        [self processTheData];
        }
            break;
        case 1:
        {
            [self payAgain];
        }
            break;
        default:
            break;
    }
    
    // 显示总价
    [self aboutInvoicingTable];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
    // 微信支付成功、失败
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(wxpayResultsAction:) name:@"WXpayResults" object:nil];
    
}

// 获取快递费
- (void)forCourierfee {

    NSDictionary *modelArray = [JXUserDefaultsObjc defaultaddresscart];
    if (modelArray.count > 0) {
        JXHomepagModel *model = [[JXHomepagModel alloc] init];
        [model setValuesForKeysWithDictionary:modelArray];
        NSString*prostr= [self procitycount:model.s_province];
        [self forCourierfeePro:prostr];
    }else {
        _courierFee_str = 0;
    }
}

- (void)forCourierfeePro:(NSString *)prostr {

    [JXNetworkRequest asyncForCourierfeeaddress_id:prostr good_ids:self.goods_id completed:^(NSDictionary *messagedic) {
        KDLOG(@"%@",messagedic);
        _courierFee_str = [messagedic[@"info"] integerValue];
        switch (_retweetType) {
            case 0:
            {
                [_footView setPriceNumber:_totalNum+_courierFee_str];
            }
                break;
            case 1:
            {
                [_footView setPriceNumber:[_is_model.total integerValue]+_courierFee_str];
            }
                break;
            default:
                break;
        }
        [self.invoicingTable reloadData];
    } statisticsFail:^(NSDictionary *messagedic) {
        
    } fail:^(NSError *error) {
        
    }];
}



- (void)wxpayResultsAction:(NSNotification *)objc {
    
    NSString *payresult = objc.object;
    if ([payresult isEqualToString:@"成功"]) {
        [self showHint:@"支付成功"];
        JXAllOrderViewController *roder = [[JXAllOrderViewController alloc] init];
        roder.hidesBottomBarWhenPushed = true;
        roder.indexController = 2;
        [self.navigationController pushViewController:roder animated:YES];
    }else {
        KDLOG(@"");
        [self showHint:@"支付失败"];
    }
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

// 我的重新再支付
- (void)payAgain {
    [self.requestArray removeAllObjects];
    [self.requestArray addObject:_is_model];
    for (MKGoodsModel *mkmodels in _is_model.cart) {
        [self.goods_id addObject:mkmodels.good_id];
    }
    [self forCourierfee];
    [self.invoicingTable reloadData];
}


// 购物车进来
- (void)processTheData {

    [self.requestArray removeAllObjects];
    for (NSDictionary *dass in self.dateArray) {
        MKOrderListModel* obj = [[MKOrderListModel alloc] init];
        for (NSString *key in dass) {
            NSMutableArray *modelar = [dass objectForKey:key];
            obj.nickname = key;
            obj.cart = [NSArray arrayWithArray:modelar];
            [self.requestArray addObject:obj];
            for (MKGoodsModel *mkmodels in modelar) {
                [self.goods_id addObject:mkmodels.id];
            }
        }
    }
    [self forCourierfee];
    [self.invoicingTable reloadData];
}


- (void)keyboardWillShow:(NSNotification *)sender {
    
    self.invoicingTable.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    CGFloat insetf = NPHeight/2+100;
    self.invoicingTable.contentInset = UIEdgeInsetsMake(0, 0, insetf, 0);
}

- (void)keyboardWillHide:(NSNotification *)sender {
    
    self.invoicingTable.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
}

- (void)navigation{
    
    UILabel * titleLabel =[[UILabel alloc]init];
    titleLabel.text = @"确认订单";
    [titleLabel sizeToFit];
    titleLabel.textColor = [UIColor blackColor];
    self.navigationItem.titleView = titleLabel;
    self.automaticallyAdjustsScrollViewInsets = YES;
    [self.view setBackgroundColor:kUIColorFromRGB(0xf2f2f2)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_back"] style:(UIBarButtonItemStylePlain) target:self action:@selector(leftAction:)];
}

- (void)leftAction:(UIBarButtonItem *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)aboutInvoicingTable {
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.invoicingTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
    self.invoicingTable.delegate = self;
    self.invoicingTable.dataSource = self;
    self.invoicingTable.backgroundColor = kUIColorFromRGB(0xf2f2f2);
    self.invoicingTable.showsVerticalScrollIndicator = NO;
    self.invoicingTable.separatorStyle = UITableViewCellEditingStyleNone;
    [self.invoicingTable registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.invoicingTable];
    
    if (@available(iOS 11.0, *)) {
        self.invoicingTable.contentInsetAdjustmentBehavior =UIScrollViewContentInsetAdjustmentNever;
        self.invoicingTable.contentInset =UIEdgeInsetsMake(0,0,0,0);//64和49自己看效果，是否应该改成0
        self.invoicingTable.scrollIndicatorInsets =self.invoicingTable.contentInset;
    }
    
    
    NSArray *nibContents = [[NSBundle mainBundle] loadNibNamed:@"JXSettlementView" owner:nil options:nil];
    _footView = [nibContents lastObject];
    _footView.frame = CGRectMake(0, [[UIScreen mainScreen] bounds].size.height-44, [[UIScreen mainScreen] bounds].size.width, 44);
    _footView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_footView];
    
    switch (_retweetType) {
        case 0:
        {
            [_footView setPriceNumber:_totalNum];
        }
            break;
        case 1:
        {
            [_footView setPriceNumber:[_is_model.total integerValue]];
        }
            break;
        default:
            break;
    }
    [_footView setBtTitle:[NSString stringWithFormat:@"结算(%ld)",(long)_goodsNumber]];
    // 支付
    __weak typeof(self)root=self;
    _footView.setblock = ^{
        // 是否开票
        if (root.onSwitch)
        {
            root.is_invoice = 1;
            // 是否含有公司两个字
            if ([root.invoice_Look containsString:@"公司"]) {
                if (!kStringIsEmpty(root.ein_number)) { // 含有公司字税号必填
                    [root pay_wayWithzfOrwx]; // 个人发票不填税号（也可填）
                }else {
                    [root showHint:@"请填写公司税号"];
                    return ;
                }
            }else {
                if (!kStringIsEmpty(root.invoice_Look)) { // 不可为空
                    [root pay_wayWithzfOrwx];
                }else {
                    [root showHint:@"请填写公司抬头"];
                    return ;
                }
                
            }
         }
        else
        {
            root.is_invoice = 0;
            [root pay_wayWithzfOrwx];
        }
    };
}


- (void)pay_wayWithzfOrwx {
    // 地址是否完整
    NSString *address_adid = self.address_id;
    if (kStringIsEmpty(address_adid)) {
        [self showHint:@"请填写地址"];
        return;
    }
    // 支付方式
    if ([self.payment_Str isEqualToString:@"支付宝"])
    {
        self.pay_way = @"1";
    }
    else if ([self.payment_Str isEqualToString:@"微信支付"])
    {
        self.pay_way = @"2";
    }
    [JXNetworkRequest asyncPaymentaddress_id:self.address_id cart_id:self.goods_id content:self.userMessage_str pay_id:self.pay_way is_bill:self.is_invoice rise:self.invoice_Look tax:self.ein_number completed:^(NSDictionary *messagedic) {
        
        if ( [self.pay_way isEqualToString:@"1"]) {
            [self zfPay:messagedic[@"info"]];
        }else if ([self.pay_way isEqualToString:@"2"]){
            NSDictionary *wxpaydic = [self parseJSONStringToNSDictionary:messagedic[@"info"]];
            [self wxPay:wxpaydic];
        }else {
            [self showHint:messagedic[@"msg"]];
        }
    } statisticsFail:^(NSDictionary *messagedic) {
        [self showHint:messagedic[@"msg"]];
    } fail:^(NSError *error) {
        [self showHint:@"网络出现错误"];
    }];
}


-(NSDictionary *)parseJSONStringToNSDictionary:(NSString *)JSONString {
    NSData *JSONData = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableLeaves error:nil];
    return responseJSON;
}


- (void)zfPay:(NSString *)orderString {

    NSString *appScheme = @"alisdkdemo";
    // NOTE: 调用支付结果开始支付
    [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
        
        switch ([resultDic[@"resultStatus"] intValue]) {
            case 9000:
            {
                [self showHint:@"支付成功"];
                JXAllOrderViewController *roder = [[JXAllOrderViewController alloc] init];
                roder.hidesBottomBarWhenPushed = true;
                roder.indexController = 2;
                [self.navigationController pushViewController:roder animated:YES];
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


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 5+self.requestArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 1;
    }
    else if (section == 2+self.requestArray.count-1)
    {
        return 1;
    }
    else if (section == 3+self.requestArray.count-1)
    {
        return 2;
    }
    else if (section == 4+self.requestArray.count-1)
    {
        return 2;
    }
    else if (section == 5+self.requestArray.count-1)
    {
        if (_onSwitch)
        {
            return 3;
        }
        else
        {
            return 1;
        }
    }
    else
    {
        MKOrderListModel * tempModle = (MKOrderListModel*)self.requestArray[section-1];
        return tempModle.cart.count+1;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0)
    {
        if (_selectModel.name>0||_selectModel.name!=nil) {
            JXInvoicingAddressTableViewCell *cell = [JXInvoicingAddressTableViewCell cellWithTable];
            [cell setModel:_selectModel];
            [cell setSelectionStyle:(UITableViewCellSelectionStyleNone)];
            return cell;
        }else {
            
            NSDictionary *addresArray = [JXUserDefaultsObjc defaultaddress];
            if (addresArray.count >0) {
                JXInvoicingAddressTableViewCell *cell = [JXInvoicingAddressTableViewCell cellWithTable];
                JXAddressModel *model = [[JXAddressModel alloc] init];
                [model setValuesForKeysWithDictionary:addresArray];
                [cell setModel:model];
                _address_id = [NSString stringWithFormat:@"%@",model.id];
                [cell setSelectionStyle:(UITableViewCellSelectionStyleNone)];
                return cell;
            }else { // 没有默认地址
                JXFillAddressTableViewCell *cell = [JXFillAddressTableViewCell cellWithTable];
                [cell setSelectionStyle:(UITableViewCellSelectionStyleNone)];
                return cell;
            }
        }
    }
    
    else if (indexPath.section == 2+self.requestArray.count-1)
    { // 退换
        JXInvoicingReturnTableViewCell *cell = [JXInvoicingReturnTableViewCell cellWithTable];
        [cell setSelectionStyle:(UITableViewCellSelectionStyleNone)];
        return cell;
    }
    else if (indexPath.section == 3+self.requestArray.count-1)
    { // 快递
        JXInvoicingReturnTableViewCell *cell = [JXInvoicingReturnTableViewCell cellWithTable];
        [cell setSelectionStyle:(UITableViewCellSelectionStyleNone)];
        if (indexPath.row == 0) {
            [cell setTitle:@"配送方式" price:@"快递"];
        }else if (indexPath.row == 1) {
            [cell setTitle:@"快递费" price:[NSString stringWithFormat:@"¥%ld",(long)_courierFee_str]];
        }
        return cell;
        
    }
    else if (indexPath.section == 4+self.requestArray.count-1)
    {
        // 支付方式 卖家留言
        JXInvoicingPayWayTableViewCell *cell = [JXInvoicingPayWayTableViewCell cellWithTable];
        [cell setSelectionStyle:(UITableViewCellSelectionStyleNone)];
        if (indexPath.row == 1) {
            [cell setHiddenLine];
            [cell setPayWay_str:self.payment_Str];
        }
        [cell setTitle:[self paywayArray][indexPath.row]];
        return cell;
    }
    else if (indexPath.section == 5+self.requestArray.count-1)
    { // 发票抬头
        if (indexPath.row == 0) {
            JXInvoicingInvoiceTableViewCell *cell = [JXInvoicingInvoiceTableViewCell cellWithTable];
            [cell setSelectionStyle:(UITableViewCellSelectionStyleNone)];
            [cell setSwitchOn:_onSwitch];
            cell.switchblock = ^(BOOL on) {
                _onSwitch = on;
                NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:indexPath.section];
                [self.invoicingTable reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
            };
            [cell setTitle:[self invoiceArray][indexPath.row]];
            return cell;
        }else {
            JXInvoicingEinTableViewCell *cell = [JXInvoicingEinTableViewCell cellWithTable];
            [cell setSelectionStyle:(UITableViewCellSelectionStyleNone)];
            cell.invoicdelegate = self;
            [cell setTitle:[self invoiceArray][indexPath.row]];
            [cell setPlaceText:[self placeArray][indexPath.row]];
            [cell setTextTag:indexPath.row];
            return cell;
        }
        
    }
    else
    {  
        // 商铺
        if (indexPath.row == 0)
        {
            MKOrderListModel * tempModle = (MKOrderListModel*)self.requestArray[indexPath.section-1];
            JXInvoicingTitleShopTableViewCell *cell = [JXInvoicingTitleShopTableViewCell cellWithTable];
            [cell setSelectionStyle:(UITableViewCellSelectionStyleNone)];
            [cell setListmodel:tempModle];
            return cell;
        }
        else
        {
            JXInvoicingShopTableViewCell *cell = [JXInvoicingShopTableViewCell cellWithTable];
            [cell setSelectionStyle:(UITableViewCellSelectionStyleNone)];
            cell.goodsModel = ((MKOrderListModel*)self.requestArray[indexPath.section-1]).cart[indexPath.row-1];
            return cell;
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0)
    { // 填写地址
        JXAddressViewController *address = [[JXAddressViewController alloc] init];
        address.selectdelegate = self;
        KDLOG(@"有地址么%@",_selectModel.id);
        if (!kStringIsEmpty(_selectModel.id)) {
            address.addressid = _selectModel.id;
        }
        
        [self.navigationController pushViewController:address animated:YES];
//
//        address.SelectaddressBlock = ^(JXAddressModel *model) {
//            _selectModel = model;
//            _address_id = [NSString stringWithFormat:@"%@",model.id];
//            NSString*prostr= [self procitycount:model.s_province];
//            [self forCourierfeePro:prostr];
//        };
        
    }
    
    
    if (indexPath.section == 4+self.requestArray.count-1)
    {
        if (indexPath.row == 0)
        {   // 留言
            JXLeaveViewController *leave = [[JXLeaveViewController alloc] init];
            leave.messagedelegate = self;
            leave.message_Str = self.userMessage_str;
            [self.navigationController pushViewController:leave animated:YES];
        }else
        {  // 支付方式
            JXPayWPViewController *pay = [[JXPayWPViewController alloc] init];
            pay.paymentdelegate = self;
            pay.pay_str = self.payment_Str;
            [self.navigationController pushViewController:pay animated:YES];
        }
    }
}
- (NSString *)procitycount:(NSString *)prostr {
    if (kStringIsEmpty(prostr)) {
        return @"";
    }else {
        return prostr;
    }
}
#pragma mark --- 选择地址代理
- (void)selectaddressModel:(JXAddressModel *)model {

    
    _selectModel = model;
    _address_id = [NSString stringWithFormat:@"%@",model.id];
    NSString*prostr= [self procitycount:model.s_province];
    [self forCourierfeePro:prostr];
    [self.invoicingTable reloadData];
//    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:0];
//    [self.invoicingTable reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {
        return 90;
    }else if (indexPath.section == 3+self.requestArray.count-1||indexPath.section == 2+self.requestArray.count-1) {
        return TableViewControllerCell_Height;
    }else if (indexPath.section == 4+self.requestArray.count-1) {
        return TableViewControllerCell_Height;
    }else if (indexPath.section == 5+self.requestArray.count-1) {
        return TableViewControllerCell_Height;
    }else {
        if (indexPath.row == 0) {
            return TableViewControllerCell_Height;
        }
        return 88;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    if (section == 0) {
        return 0;
    }else {
        return 10;
    }
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, NPWidth, 10)];
    return view;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 4+self.requestArray.count) {
        return 64+44;
    }else {
        return 0;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *foot = [[UIView alloc] initWithFrame:CGRectMake(0, 0, NPWidth, 64)];
    [foot setBackgroundColor:[UIColor clearColor]];
    return foot;
}

// 头部滑动
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

#pragma mark --- 代理
- (void)invoicingText:(NSString *)text tag:(NSInteger)tag{

    if (tag == 1) // 发票抬头
    {
        self.invoice_Look = text;
    }
    else if (tag == 2) // 公司税号
    {
        self.ein_number = text;
    }
}
- (void)idnumberIsWrong {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        UIAlertController *aler = [UIAlertController alertControllerWithTitle:@"错误提示" message:@"税号错误" preferredStyle:(UIAlertControllerStyleAlert)];
        [self presentViewController:aler animated:true completion:nil];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确认" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [aler addAction:action];
        
    });
}
#pragma mark --- 支付方式
- (void)payment:(NSString *)payment {

    _payment_Str = payment;
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:1 inSection:4+self.requestArray.count-1];
    [self.invoicingTable reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
    
}
#pragma mark --- 留言
- (void)leaveAmessagedelegatestr:(NSString *)message {
    self.userMessage_str = message;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
