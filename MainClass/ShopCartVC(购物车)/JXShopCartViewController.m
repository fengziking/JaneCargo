//
//  JXShopCartViewController.m
//  JaneCargo
//
//  Created by 鹏 on 17/6/23.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXShopCartViewController.h"
#import "ShoppingCartTableViewCell.h"
#import "JXEmptyShopTableViewCell.h"

#import "MKOrderListModel.h"
#import "MKGoodsModel.h"
// 头部
#import "HeaderForShoppingCart.h"
// 底部
#import "JXGoodShopView.h"

#import "JXInvoicingViewController.h"
// 商铺
#import "JXShopHomeViewController.h"


@interface JXShopCartViewController ()<UITableViewDelegate,UITableViewDataSource,headerViewDelegate,shopCarCellDelegate,XWPresentedOneControllerDelegate,LoginDelegate> {
    
    HeaderForShoppingCart *_headerView; // 组头view
    BOOL is_dropdown;
    BOOL is_network;
    BOOL is_firstTime;
    
    
}
@property (nonatomic, strong) JXCustomHudview *jxhud;
//@property (nonatomic, strong) UIView *loading;
@property (nonatomic, strong) JXRotating *loading;
@property (nonatomic, assign) float totalNum;  // 合计价格
@property (nonatomic, strong) JXGoodShopView *footView;
@property (nonatomic, strong) UIButton *rightEditor;
@property (nonatomic, strong) UITableView *shopTable;
@property (nonatomic, strong) NSMutableDictionary *indexPathdic;
// 记录要删除的产品
@property (nonatomic, strong) NSMutableArray *deletespecArray;
// 记录收藏的产品
@property (nonatomic, strong) NSMutableArray *collectiongood_idArray;
@property (nonatomic, strong) NSMutableArray *invoicingArray;
// 记录选中的购物产品
@property (nonatomic, strong) NSMutableArray *rowArray;
// 记录收藏的产品
@property (nonatomic, strong) NSMutableArray *collectionArray;
// 购物车原本数据
@property (nonatomic, strong) NSMutableArray *dateArray;
// 产品规格
@property (nonatomic, strong) NSMutableArray *spec_priceArray;
@property (nonatomic, strong) XWInteractiveTransition *interactivePush;
// 推荐产品控制器
@property (nonatomic, strong) JXHomePageCollectionViewController *collecotiongy;

// 推荐
@property (nonatomic,strong) NSMutableArray *recommendedArray;

@end

@implementation JXShopCartViewController

static const CGFloat MJDuration = 0.5;

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    is_firstTime = YES;
    [JXEncapSulationObjc blackNavigation:self color:[UIColor whiteColor]];
    [self refreshGoodCart];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:kUIColorFromRGB(0xf2f2f2)];
    is_network = YES;
    UILabel * titleLabel =[[UILabel alloc]init];
    titleLabel.text = @"购物车";
    [titleLabel sizeToFit];
    titleLabel.textColor = [UIColor blackColor];
    self.navigationItem.titleView = titleLabel;
    self.dateArray = @[].mutableCopy;
    self.collectionArray = @[].mutableCopy;
    self.collectiongood_idArray = @[].mutableCopy;
    self.deletespecArray = @[].mutableCopy;
    self.indexPathdic = @{}.mutableCopy;
    self.recommendedArray = @[].mutableCopy;
    
    if ([self.typeNavigate isEqualToString:@"次页面"]) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_back"] style:(UIBarButtonItemStylePlain) target:self action:@selector(leftAction:)];
    }
    [self table];
    // 推荐
    [self y_dateRequest];
    // 网络监测
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(havingNetworking:) name:@"AFNetworkReachabilityStatusYes" object:nil];
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark 实时检测网络
-(void)havingNetworking:(NSNotification *)isNetWorking {
    
    NSString *sender = isNetWorking.object;
    if (![sender boolValue]) { // 无网
        is_network = NO;
        [_shopTable reloadData];
    }else {
        is_network = YES;
        [self refreshGoodCart];
    }
}


// 导航设置
- (void)navigation {

    _rightEditor = [[UIButton alloc] initWithFrame:CGRectMake(0, 10, 40, 24)];
    [_rightEditor setTitle:@"编辑" forState:(UIControlStateNormal)];
    [_rightEditor setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [_rightEditor.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
    [_rightEditor addTarget:self action:@selector(setBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:[UIColor blackColor]}];
    
    if (self.dateArray.count > 0) {
        UIBarButtonItem * setItem = [[UIBarButtonItem alloc] initWithCustomView:_rightEditor];
        UIBarButtonItem * addPictureItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_messageBlack"] style:(UIBarButtonItemStylePlain) target:self action:@selector(messageAction:)];
        self.navigationItem.rightBarButtonItems = @[addPictureItem,setItem];
    }else {
        
        UIBarButtonItem * addPictureItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_messageBlack"] style:(UIBarButtonItemStylePlain) target:self action:@selector(messageAction:)];
        self.navigationItem.rightBarButtonItems = @[addPictureItem];
    }
}

#pragma mark ---- 导航点击方法
- (void)leftAction:(UIBarButtonItem *)sender {
    if ([_shopdetaildelegate respondsToSelector:@selector(shopdetailsdegatereload)]) {
        [_shopdetaildelegate shopdetailsdegatereload];
    }
    [self.navigationController popViewControllerAnimated:NO];
}
// 信息
- (void)messageAction:(UIBarButtonItem *)sender {
    
    JXPushMessageViewController *jxpush = [[JXPushMessageViewController alloc] init];
    [self.navigationController pushViewController:jxpush animated:YES];
}
#pragma mark ---- 编辑模式
- (void)setBtnClick:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    if (sender.selected) { // 进入编辑状态 记录原数据 清空选中状态
        KDLOG(@"打印BOOL型数据%@",sender.selected?@"YES":@"NO");
        [_rightEditor setTitle:@"完成" forState:(UIControlStateNormal)];
        // 记录编辑前商品的状态
        self.rowArray = @[].mutableCopy;
        // 点击编辑清除选中状态
        [self changShopGoodblack:^(NSInteger section, NSInteger row) {
            
            MKGoodsModel *goodsModel = ((MKOrderListModel*)self.dateArray[section]).cart[row];
            // 记录选中的产品
            if (goodsModel.isSelected)
            { //   记录选中的商品 (选唯一值作为判断 一般商品id都是唯一的)
                if (![self.rowArray containsObject:[NSString stringWithFormat:@"%@",goodsModel.id]])
                {
                    [self.rowArray addObject:[NSString stringWithFormat:@"%ld-%@",(long)section,goodsModel.id]];
                }
            }
            goodsModel.isSelected = NO;
            [self shopCellSelectedClicksection:section row:row];
        }];
        // 隐藏价格刷新数据
        [_footView sethiddenViewWithPrice:YES settle:@"删除"];
        [_footView sethiddenViewWithCollectionButton:NO];
        [_shopTable reloadData];
        
    }else {
        
        // 清除价格重新计算
        self.totalNum = 0;
        [_rightEditor setTitle:@"编辑" forState:(UIControlStateNormal)];
        // 重新计算商品之前先清除所有收藏的选中状态
        [self changShopGoodblack:^(NSInteger section, NSInteger row) {
            
            MKGoodsModel *goodsModel = ((MKOrderListModel*)self.dateArray[section]).cart[row];
            goodsModel.isSelected = NO;

        }];
        // 恢复购物车原来选中的商品
        [self changShopGoodblack:^(NSInteger section, NSInteger row) {
            
            MKGoodsModel *goodsModel = ((MKOrderListModel*)self.dateArray[section]).cart[row];
            for (NSString *selectGood in self.rowArray)
            {
                NSArray *good_p = [selectGood componentsSeparatedByString:@"-"];
                // 判断对应的分区
                if ([good_p[0]integerValue] == section)
                {
                    // 判断对应分区的商品id（商品在编辑状态时可能已被删除）
                    if ([good_p[1] isEqualToString:[NSString stringWithFormat:@"%@",goodsModel.id]])
                    {
                        goodsModel.isSelected = YES;
                    }
                }
            }
            [self shopCellSelectedClicksection:section row:row];
        }];
        [_footView sethiddenViewWithPrice:NO settle:@"结算"];
        [_footView sethiddenViewWithCollectionButton:YES];
        [_shopTable reloadData];
    }
}


#pragma mark --- 获取购物车当前选中状态
- (void)changShopGoodblack:(void(^)(NSInteger section,NSInteger row))shopgoods {

    for (int i = 0; i < self.dateArray.count; i ++)
    { //  获取分区选中状态
        for (int s = 0; s<((MKOrderListModel*)self.dateArray[i]).cart.count; s++)
        {  // 获取分区内row的选中状态
            shopgoods(i,s);
        }
    }
}

#pragma mark -- 全选状态 购物车一般进入会默认全选状态
/**
 进入购物车默认产品全选 （目前做本地保存）
 */
- (void)allgoodsSelect {
    _totalNum = 0;
    NSArray *good_idArray;
    if (_rightEditor.selected != YES) {
        good_idArray = [JXUserDefaultsObjc defaultgoods_id];
    }else { // 编辑状态下只考虑选中的产品
        good_idArray = self.collectiongood_idArray;
    }
    // 点击编辑清除所有状态
    [self changShopGoodblack:^(NSInteger section, NSInteger row) {
        MKGoodsModel *goodsModel = ((MKOrderListModel*)self.dateArray[section]).cart[row];
        for (NSString *goodstr in good_idArray) {
            if ([[NSString stringWithFormat:@"%@",goodstr] isEqualToString:[NSString stringWithFormat:@"%@",goodsModel.good_id]]) {
                goodsModel.isSelected = YES;
            }
        }
        [self shopCellSelectedClicksection:section row:row];
        
    }];
}


#pragma mark -- 返回刷新对应价格时
- (void)shopCellSelectedClicksection:(NSInteger)section row:(NSInteger)row{
    
    MKOrderListModel * listModel = (MKOrderListModel*)self.dateArray[section];
    NSInteger seletedNum =0;
    for (MKGoodsModel* goodsModel in listModel.cart) {
        if (goodsModel.isSelected) {
            seletedNum += 1;
        }
        // 1.当前组的cell的个数 是否等于 勾选的总数
        if (((MKOrderListModel*)self.dateArray[section]).cart.count == seletedNum) {
            listModel.groupSelected = YES; //cell改变组头变为选中
            //判断  //cell改变组头 //组头改变全选
            NSInteger selectedNum = 0 ;
            for (MKOrderListModel * tempListModel in self.dateArray) {//遍历所有组
                if (tempListModel.groupSelected) {//如果组头是选中的
                    selectedNum += 1;
                }
                if (selectedNum == self.dateArray.count) {
                    [_footView setDotType:YES];
                }
            }
        } else {
            listModel.groupSelected = NO;
            [_footView setDotType:NO];
        }
        
        [_shopTable reloadData];
    }
    
    if (!_rightEditor.selected) { //不处理价格
        // 计算价格
        MKGoodsModel *goodsModel = ((MKOrderListModel*)self.dateArray[section]).cart[row];
        float goods_price = goodsModel.good_price;
        float goods_number = goodsModel.number;
        if (goodsModel.isSelected) { // 计算当前选中的价格

            _totalNum += goods_price*goods_number;
            NSLog(@"%f",_totalNum);
            
        }
        [_footView setSettlementPrice:[NSString stringWithFormat:@"¥%.2f",_totalNum -1 + 1]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -- 加载数据
- (void)dateRequest {
    
    

    self.loading = [JXRotating initWithRotaing];
    [self.view addSubview:self.loading];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // 处理耗时操作的代码块...
        [JXNetworkRequest asyncGoodsCartcompleted:^(NSDictionary *messagedic) {
            is_network = YES;
            [_shopTable setScrollEnabled:YES];
            NSArray * array = messagedic[@"info"];
            for (NSDictionary* list in array) {
                MKOrderListModel* obj = [MKOrderListModel mj_objectWithKeyValues:list];
                [self.dateArray addObject:obj];
            }
             //通知主线程刷新
            dispatch_async(dispatch_get_main_queue(), ^{
                //回调或者说是通知主线程刷新，
                [self dealwithNavigationhiddenOrshow];
                [self endofthedropdown];
                [self allgoodsSelect];
                [_shopTable reloadData];
            });
            
        } statisticsFail:^(NSDictionary *messagedic) {
            is_network = YES;
            [self endofthedropdown];
            [self dealwithNavigationhiddenOrshow];
            [_shopTable reloadData];
            
            if (!is_firstTime) { // 首次进入不提示
                if ([messagedic[@"status"] integerValue] == 600) {
                    JXLoginViewController *login = [[JXLoginViewController alloc] init];
                    login.logindelegate = self;
                    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:login] animated:YES completion:nil];
                }
                [self showHint:messagedic[@"msg"]];
            }
        } fail:^(NSError *error) {
            is_network = NO;
            [_shopTable reloadData];
            [self endofthedropdown];
        }];
        
    });
}

#pragma mark --- 登录代理 （获取用户信息更新界面）
- (void)loginSuccessful:(JXLoginViewController *)login {
    [self is_userinfoMessage];
}

- (void)is_userinfoMessage{
    
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    dispatch_async(queue, ^{
        
        [JXNetworkRequest asyncAllUserInfomationIs_Cache:NO refreshCache:NO completed:^(NSDictionary *messagedic) {
            // 保存用户信息
            NSMutableDictionary *userdic = @{}.mutableCopy;
            for (NSString *content in messagedic[@"info"]) {
                
                NSString *value = [NSString stringWithFormat:@"%@",[messagedic[@"info"] objectForKey:content]];
                if (![value isEqualToString:@"<null>"]) {
                    [userdic setObject:value forKey:content];
                }
            }
            [JXUserDefaultsObjc storageLoginUserInfo:[NSDictionary dictionaryWithDictionary:userdic]];
            // 刷新页面
            [self refreshGoodCart];
        } statisticsFail:^(NSDictionary *messagedic) {
            
        } fail:^(NSError *error) {
            
        }];
    });
}



#pragma mark -- 下拉结束
- (void)endofthedropdown {
    // 拿到当前的下拉刷新控件，结束刷新状态
    [self.shopTable.mj_header endRefreshing];
    self.shopTable.scrollEnabled = YES;
}

#pragma mark -- 处理导航和底部视图
- (void)dealwithNavigationhiddenOrshow {
    
    [_footView removeFromSuperview];
    if (_rightEditor.selected != YES) {
        [self navigation];
    }
    
    if (self.dateArray.count!=0 ) {
        _shopTable.height = [[UIScreen mainScreen] bounds].size.height-64-49-50;
        [self allSelectView];
    }
    
    if (self.dateArray.count == 0) {
        _shopTable.height = [[UIScreen mainScreen] bounds].size.height-64-49-0;
        [self hiddenNavigationAndfootView:YES];
        
    }
    
    // 获取到数据后重新刷新table的高度
    NSDictionary *sidic = [JXUserDefaultsObjc loginUserSid];
    NSString *sid = sidic[@"info"];
    CGFloat viewheight = 0;
    CGFloat tabheight = 0;
    if ([self.typeNavigate isEqualToString:@"次页面"]) {
        if (!kStringIsEmpty(sid)) { // 没登录购物车为空
            if (self.dateArray.count == 0) { // 没数据 购物车为空
                viewheight = 0;
            }else {
                viewheight = 50;
            }
        }
        tabheight = 0;
    }else {
        if (!kStringIsEmpty(sid)) { // 没登录购物车为空
            if (self.dateArray.count == 0) { // 没数据 购物车为空
                viewheight = 0;
            }else {
                viewheight = 50;
            }
        }
        tabheight = 49;
    }
    
    _shopTable.height = [[UIScreen mainScreen] bounds].size.height-64-tabheight-viewheight;
    
}

- (void)hiddenNavigationAndfootView:(BOOL)hidden {

    [_footView setHidden:hidden];
    [_rightEditor setHidden:hidden];
}

#pragma mark -- tab创建
- (void)table {
    
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    _shopTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height-64-49-50)];
    _shopTable.delegate = self;
    _shopTable.dataSource = self;
    _shopTable.showsVerticalScrollIndicator = NO;
    [_shopTable setBackgroundColor:kUIColorFromRGB(0xf2f2f2)];
    _shopTable.separatorStyle = UITableViewCellEditingStyleNone;
    [_shopTable registerClass:[JXPromotionTableViewCell class] forCellReuseIdentifier:@"pros"];
    [self.view addSubview:self.shopTable];
    if (@available(iOS 11.0, *)) {
        _shopTable.contentInsetAdjustmentBehavior =UIScrollViewContentInsetAdjustmentNever;
        _shopTable.contentInset =UIEdgeInsetsMake(0,0,0,0);//64和49自己看效果，是否应该改成0
        _shopTable.scrollIndicatorInsets =_shopTable.contentInset;
    }
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (is_network) {
        if (self.dateArray.count == 0) {
            return 1;
        }else {
            // 有值的情况下
            return self.dateArray.count+1;
        }
    }else {
        return 1;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (is_network) {
        if (self.dateArray.count == 0) {
            return 3;
        }else {
            if (section == self.dateArray.count) {
                return 2;
            }else {
                MKOrderListModel * tempModle = (MKOrderListModel*)self.dateArray[section];
                return tempModle.cart.count;
            }
        }
    }else {
        return 1;
    }
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (is_network) { // you网络
        
        if (self.dateArray.count == 0) { // 无值
            
            if (indexPath.row == 0)
            {
                JXEmptyShopTableViewCell *cell = [JXEmptyShopTableViewCell cellWhiTable];
                [cell setSelectionStyle:(UITableViewCellSelectionStyleNone)];
                [cell setBackgroundColor:kUIColorFromRGB(0xf2f2f2)];
                // 去购物
                cell.goshop = ^void(){
                    
                };
                return cell;
            }
            else if (indexPath.row == 1)
            {
                JXPromotionTitleCell *cell = [JXPromotionTitleCell cellWithTable];
                [cell setSelectionStyle:(UITableViewCellSelectionStyleNone)];
                [cell setBackgroundColor:kUIColorFromRGB(0xf2f2f2)];
                cell.gradientLabel.text = @"推荐产品";
                return cell;
            }
            else
            {
                JXPromotionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"pros" forIndexPath:indexPath];
                [JXEncapSulationObjc selectViewAbout:cell];
                [self showPromotion:cell];
                [cell setSelectionStyle:(UITableViewCellSelectionStyleNone)];
                return cell;
            }
        }else {
            // 有值的情况下
            // 推荐的商品
            if (indexPath.section == self.dateArray.count)
            {
                if (indexPath.row == 0)
                {
                    JXPromotionTitleCell *cell = [JXPromotionTitleCell cellWithTable];
                    [cell setSelectionStyle:(UITableViewCellSelectionStyleNone)];
                    [cell setBackgroundColor:kUIColorFromRGB(0xe3e3e3)];
                    [cell.titleImage setImage:[UIImage imageNamed:@"推荐商品"]];
                    cell.gradientLabel.text = @"推荐产品";
                    return cell;
                }
                else
                {
                    JXPromotionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"pros" forIndexPath:indexPath];
                    [JXEncapSulationObjc selectViewAbout:cell];
                    [self showPromotion:cell];
                    [cell setSelectionStyle:(UITableViewCellSelectionStyleNone)];
                    return cell;
                }
            }
            else
            { // 价格等
                ShoppingCartTableViewCell *cell = [ShoppingCartTableViewCell cellWhiTable];
                if (_rightEditor.selected)
                {
                    [cell.selectSpecification setEnabled:YES];
                    [cell.specificationsView setBackgroundColor:kUIColorFromRGB(0xf2f2f2)];
                    [cell.specificationsImage setHidden:NO];
                }
                else
                {
                    [cell.selectSpecification setEnabled:NO];
                    [cell.specificationsView setBackgroundColor:[UIColor whiteColor]];
                    [cell.specificationsImage setHidden:YES];
                }
                
                cell.shopDelegate = self;
                [cell.layer setBorderWidth:0.5];
                [cell.layer setBorderColor:[kUIColorFromRGB(0xe3e3e3) CGColor]];
                [cell setSelectionStyle:(UITableViewCellSelectionStyleNone)];
                //获取对应组的对应商品信息
                cell.goodsModel = ((MKOrderListModel*)self.dateArray[indexPath.section]).cart[indexPath.row];
                // 给cell做标记
                cell.tag = (long)indexPath.section *100 + (long)indexPath.row;
                NSString * cellTag = [NSString stringWithFormat:@"%zd",cell.tag];
                NSDictionary* _tempDic = @{cellTag:indexPath};
                [self.indexPathdic addEntriesFromDictionary:_tempDic];
                cell.changspec = ^(MKGoodsModel *models) {
                    [self goods_id:models.good_id modes:models];
                    
                };
                return cell;
            }
        }
    }else { // 无网络
    
        JXOffNetTableViewCell *cell = [JXOffNetTableViewCell cellWithTable];
        [_shopTable setScrollEnabled:NO];
        cell.UpdateRequest = ^{
            [self refreshGoodCart];
        };
        return cell;
    }
}



#pragma mark--- 获取产品对应的参数 (编辑状态下点击规格)
- (void)goods_id:(NSNumber *)goodsid modes:(MKGoodsModel *)model{
    
    [JXNetworkRequest asyncShoppingCartspecificationsgood_id:goodsid completed:^(NSDictionary *messagedic) {
        self.spec_priceArray = @[].mutableCopy;
        NSArray *dicArray = messagedic[@"info"];
        for (NSDictionary *sepcdic in dicArray) {
            JXHomepagModel *model = [[JXHomepagModel alloc] init];
            [model setValuesForKeysWithDictionary:sepcdic];
            [self.spec_priceArray addObject:model];
        }
        
        JXGoodsdetailViewController *new = [[JXGoodsdetailViewController alloc] init];
        new.delegate = self;
        new.seleType = 2;
        new.mkMode = model;
        new.goodsspecificationsArray = [NSArray arrayWithArray:self.spec_priceArray];
        [self presentViewController:new animated:YES completion:nil];
    } statisticsFail:^(NSDictionary *messagedic) {
        
    } fail:^(NSError *error) {
        
    }];
}

#pragma mark -- cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (is_network) {
        NSInteger line = [JXEncapSulationObjc s_calculateNumberArrayNum:self.recommendedArray.count singleNumber:2];
        if (self.dateArray.count == 0) {
            if (indexPath.row == 0) {
                return 256;
            }else if (indexPath.row == 1){
                return TableViewControllerCell_Height;
            }else {
                
                return line * BranchOrder_Collection_Height;
            }
        }else {
            if (indexPath.section == self.dateArray.count)
            {
                if (indexPath.row == 0) {
                    return TableViewControllerCell_Height;
                }else {
                    return line * BranchOrder_Collection_Height;
                }
            }else { // 自适应高度
                MKGoodsModel *model = ((MKOrderListModel*)self.dateArray[indexPath.section]).cart[indexPath.row];
                return model.cellHeight;
            }
        }
    }else {
        return NPHeight-64;
        
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (is_network) {
        if (self.dateArray.count == 0) {
            return 0;
        }else {
            
            if (section == self.dateArray.count)
            {
                return 0;
            }else {
                return 50;
            }
        }
    }else {
        return 0;
    }
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.dateArray.count == 0)
    {
        return NO;
    }else {
        // 删除
        if (indexPath.section == self.dateArray.count)
        {
            return NO;
            
        }else {
            return YES;
        }
    }
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        MKOrderListModel*listModel = self.dateArray[indexPath.section];
        
        NSMutableArray*goodsModel = (NSMutableArray*)listModel.cart;
        
        /// 如果删除的是带勾选的则计算一次数值
        MKGoodsModel*goodModel = (MKGoodsModel*)goodsModel[indexPath.row];
        if (goodModel.isSelected) {
            float goods_price = goodModel.good_price;     //价格
            float goods_number = goodModel.number;   // 数量
            _totalNum -= goods_price * goods_number;
            
            [self.footView setSettlementPrice:[NSString stringWithFormat:@"%.2f",_totalNum]];
        }
        // 删除购物车good_id记录勾选状态
        [JXJudgeStrObjc delegateGoods_idCart:[NSString stringWithFormat:@"%@",goodModel.good_id]];
        
        [goodsModel  removeObjectAtIndex:indexPath.row];    // 删除操作放到最后
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        if (goodsModel.count == 0) {
            NSMutableArray *temp = [NSMutableArray arrayWithArray:self.dateArray];
            [temp removeObjectAtIndex:indexPath.section];
            self.dateArray = temp;
        }
        // 获取删除的id MKGoodsModel
        [self.deletespecArray addObject:goodModel.id];
        // 是否收藏有要删除的产品 有就删除
        if ([self.collectiongood_idArray containsObject:goodModel.good_id]) {
            [self.collectiongood_idArray removeObject:goodModel.good_id];
        }
        
        // 告诉服务器要删除的商品
        [self deleteGoodforSelect:[NSArray arrayWithArray:self.deletespecArray]];
    }
}


//修改删除操作title -默认 "删除"(Delete) -跟随系统语言
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}


#pragma mark -- cell头部高度
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    MKOrderListModel*listModel;
    if (self.dateArray.count>0) {
        listModel = self.dateArray[section];
    }
    _headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"MKShopCarHeader"];
    if (_headerView == nil) {
        _headerView = [[HeaderForShoppingCart alloc] init];
        _headerView.headerDelegate = self;
    }
    _headerView.orderListModel = listModel;
    _headerView.tag = section;
    _headerView.headerBtn.selected = listModel.groupSelected;
    if (listModel.cart.count == 0) {
        return nil;
    }
    return _headerView;
}
#pragma mark -- 头部代理 店铺
- (void)storeSelectedBtnClick: (NSInteger)section {
    MKOrderListModel*listModel = (MKOrderListModel*)self.dateArray[section];
    JXShopHomeViewController *shop = [[JXShopHomeViewController alloc] init];
    shop.seller_id = [NSString stringWithFormat:@"%@",listModel.seller_id];
    [self.navigationController pushViewController:shop animated:YES];
}
- (void)headerSelectedBtnClick: (NSInteger)section {
    
    MKOrderListModel*listModel = self.dateArray[section];
    listModel.groupSelected = !listModel.groupSelected;
    
    // 判断如果点击 | header选中
    if (listModel.groupSelected) {
        // 判断组头的点击改变全选按钮
        NSInteger tempGroupSelectNum = 0;
        for (MKOrderListModel *model in self.dateArray) {
            if (model.groupSelected) {
                tempGroupSelectNum ++;
            }
            if (tempGroupSelectNum == self.dateArray.count) {
                [_footView setDotType:YES];
            }
        }
        for (MKGoodsModel* goodsModel in listModel.cart) {
            
            if (!goodsModel.isSelected) { //下面不是选中状态的cell 将价格加入到总价当中
                // 将未选中的产品记录
                [JXJudgeStrObjc addgoods_idCart:[NSString stringWithFormat:@"%@",goodsModel.good_id]];
                
                // 计算价格
                float goods_price = goodsModel.good_price;      //价格
                float goods_number = goodsModel.number;   // 数量
                _totalNum += goods_price * goods_number;
                goodsModel.isSelected = YES;
            }
            
            // 获取选中的id
            if (self.rightEditor.selected)
            {
                // 记录选中的产品
                if (![self.deletespecArray containsObject:goodsModel.id]) {
                    [self.deletespecArray addObject:goodsModel.id];
                }
                // 记录收藏的
                if (![self.collectiongood_idArray containsObject:goodsModel.good_id]) {
                    
                    [self.collectiongood_idArray addObject:goodsModel.good_id];
                }
            }
        }
    } else {  // 取消header选中 所有都取消
        //全选按钮变为不选中
        [_footView setDotType:NO];
        for (MKGoodsModel* goodsModel in listModel.cart) {
            // 删除购物车里边的id
            [JXJudgeStrObjc delegateGoods_idCart:[NSString stringWithFormat:@"%@",goodsModel.good_id]];
            goodsModel.isSelected = NO;
            float goods_price = goodsModel.good_price;     //价格
            float goods_number = goodsModel.number;   // 数量
            _totalNum -= goods_price * goods_number;
            
            if (self.rightEditor.selected)
            {
                // 删除选中的产品
                if ([self.deletespecArray containsObject:goodsModel.id]) {
                    
                    [self.deletespecArray removeObject:goodsModel.id];
                }
                // 删除选中的收藏产品
                if ([self.collectiongood_idArray containsObject:goodsModel.good_id]) {
                
                    [self.collectiongood_idArray removeObject:goodsModel.good_id];
                }
            }
        }
    }
    // 计算价格
    [_footView setSettlementPrice:[NSString stringWithFormat:@"¥%.2f",_totalNum - 1 + 1]];
    
    [_shopTable reloadData];
}

#pragma mark -- cell单个 选中---或取消   价格增减
- (void)shopCellSelectedClick :(NSInteger)shopCellTag {
    
    //判断组的是否选中状态是否修改
    NSString * cellTagStr = [NSString stringWithFormat:@"%zd",shopCellTag];
    NSIndexPath *indexPath = self.indexPathdic[cellTagStr];
    MKOrderListModel * listModel = (MKOrderListModel*)self.dateArray[indexPath.section];
    //0.便利当前组cell上选中按钮的个数
    NSInteger seletedNum =0;
    for (MKGoodsModel* goodsModel in listModel.cart) {
        if (goodsModel.isSelected)
        {
            seletedNum += 1;
         }
        // 1.当前组的cell的个数 是否等于 勾选的总数
        if (((MKOrderListModel*)self.dateArray[indexPath.section]).cart.count == seletedNum)
        {
            listModel.groupSelected = YES; //cell改变组头变为选中
            //判断  //cell改变组头 //组头改变全选
            NSInteger selectedNum = 0 ;
            for (MKOrderListModel * tempListModel in self.dateArray) {//遍历所有组
                if (tempListModel.groupSelected) {//如果组头是选中的
                    selectedNum += 1;
                }
                if (selectedNum == self.dateArray.count) {
                    [_footView setDotType:YES];
                }
            }
        }
        else
        {
            listModel.groupSelected = NO;
            [_footView setDotType:NO];
        }
        [_shopTable reloadData];
    }
    // 计算价格
    MKGoodsModel *goodsModel = ((MKOrderListModel*)self.dateArray[indexPath.section]).cart[indexPath.row];
    // 编辑模式下选中的商品
    [self deleteGoods_id:goodsModel];
    float goods_price = goodsModel.good_price;
    float goods_number = goodsModel.number;
    if (!goodsModel.isSelected) { // 取消选中
        _totalNum -= goods_price*goods_number;
        [JXJudgeStrObjc delegateGoods_idCart:[NSString stringWithFormat:@"%@",goodsModel.good_id]];
    }else { // 选中
        _totalNum+= goods_price*goods_number;
        [JXJudgeStrObjc addgoods_idCart:[NSString stringWithFormat:@"%@",goodsModel.good_id]];
    }
    [_footView setSettlementPrice:[NSString stringWithFormat:@"¥%.2f",_totalNum -1 + 1]];
}


#pragma mark --- 编辑模式下获取选中的商品id
- (void)deleteGoods_id:(MKGoodsModel *)goodsModel {
    // 编辑模式下
    if (self.rightEditor.selected)
    {
        // 记录选中的产品
        if ([self.deletespecArray containsObject:goodsModel.id]) {
            
            [self.deletespecArray removeObject:goodsModel.id];
        }else {
        
            [self.deletespecArray addObject:goodsModel.id];
        }
        // 记录选中的收藏产品
        if ([self.collectiongood_idArray containsObject:goodsModel.good_id]) {
            
            [self.collectiongood_idArray removeObject:goodsModel.good_id];
        }else {
            
            [self.collectiongood_idArray addObject:goodsModel.good_id];
        }
    }
}



- (void)shopCellEndEditerClick :(NSInteger)shopCellTag beforeBuyNum:(float)beforeBuyNum {
    MKGoodsModel *goodsModel;
    //判断组的是否选中状态是否修改
    NSString * cellTagStr = [NSString stringWithFormat:@"%zd",shopCellTag];
    NSIndexPath *indexPath = self.indexPathdic[cellTagStr];
    if (self.dateArray.count>0) {
        goodsModel = ((MKOrderListModel*)self.dateArray[indexPath.section]).cart[indexPath.row];
    }
    float goods_price = goodsModel.good_price;
    float goods_number = goodsModel.number;
    if (!goodsModel.isSelected) {  // 不作处理
        
    }else {
        
        _totalNum = _totalNum + goods_price*(goods_number - beforeBuyNum);
        
    }
    [_footView setSettlementPrice:[NSString stringWithFormat:@"¥%.2f",_totalNum -1 + 1]];
}

#pragma mark -- 购物车 结账 收藏 删除 底部foot
- (void)allSelectView {
    CGFloat bottheight = 0;
    if ([self.typeNavigate isEqualToString:@"次页面"]) {
        bottheight = 0;
    }else {
        bottheight = 50;
    }
    NSArray *nibContents = [[NSBundle mainBundle] loadNibNamed:@"GoodShopView" owner:nil options:nil];
    _footView = [nibContents lastObject];
    _footView.frame = CGRectMake(0, [[UIScreen mainScreen] bounds].size.height-bottheight-49, [[UIScreen mainScreen] bounds].size.width, 50);
    _footView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_footView];
    // 隐藏收藏
    if (_rightEditor.selected != YES) {
        [_footView sethiddenViewWithCollectionButton:YES];
    }else {
        [_footView sethiddenViewWithCollectionButton:NO];
        [_footView sethiddenViewWithPrice:YES settle:@"删除"];
    }
    
    
    __weak typeof(self)rootView = self;
    _footView.choosedot = ^void(BOOL choose)
    {
        if (choose)
        { // 全选
            for (int i = 0; i <self.dateArray.count; i ++)
            {
                MKOrderListModel * listModel = rootView.dateArray[i];
                if (!listModel.groupSelected)
                { //遍历如果组不是选中状态 (选中的不再去选 防止重复选中导致错误)
                    [rootView headerSelectedBtnClick:i]; //模拟组头点击了一次
                }
            }
            
        }else { // 全部取消
            
            for (int i = 0; i < rootView.dateArray.count; i ++)
            { // 遍历所有的组头点击  (选过个区头booL为NO ---不会继续选)
                [rootView headerSelectedBtnClick:i];
            }
            
        }
        [rootView.shopTable reloadData];
    };
    
    // 结算 收藏
    _footView.setcoll = ^(NSString *typeString) {
        
        [rootView.jxhud hidalterhud];
        if ([typeString isEqualToString:@"收藏"]) {
            if (rootView.collectiongood_idArray.count>0) {
                [JXNetworkRequest asyncCollectionShoppingCartspecificationsgood_id:rootView.collectiongood_idArray completed:^(NSDictionary *messagedic) {
                    [rootView showHint:messagedic[@"msg"]];
                } statisticsFail:^(NSDictionary *messagedic) {
                    [rootView showHint:messagedic[@"msg"]];
                } fail:^(NSError *error) {
                    
                }];
            }else {
                
                rootView.jxhud = [JXCustomHudview alterViewWithTitle:@"请选择商品"];
                [rootView.view addSubview:rootView.jxhud];
             }
            
        }else if ([typeString isEqualToString:@"结算"]) {
            
            if (rootView.rightEditor.selected)
            {   // 编辑模式 --删除
                if (rootView.deletespecArray.count >0) {
                    [rootView deleteGoodforSelect:[NSArray arrayWithArray:rootView.deletespecArray]];
                }else {
                    //@"请选择要删除的商品"
                    rootView.jxhud = [JXCustomHudview alterViewWithTitle:@"请选择要删除的商品"];
                    [rootView.view addSubview:rootView.jxhud];
                }
            }
            else
            { // 结账 ----进入结账信息列表 从店铺中提取用户选中的商品进行结账
                NSMutableArray *date_good = @[].mutableCopy;
                NSInteger goods_numbers = 0;
                for (int section = 0; section < self.dateArray.count; section ++)
                { //  获取分区选中状态
                    for (int row = 0; row<((MKOrderListModel*)self.dateArray[section]).cart.count; row++)
                    {  // 获取分区内row的选中状态
                        MKOrderListModel*listModel = rootView.dateArray[section];
                        MKGoodsModel *goodsModel = ((MKOrderListModel*)rootView.dateArray[section]).cart[row];
                        NSString *goods_listName = [NSString stringWithFormat:@"%@",listModel.nickname];
                        NSMutableDictionary *datedic = [NSMutableDictionary dictionary];
                        NSMutableDictionary *noSameArray = @{}.mutableCopy;
                        if (goodsModel.isSelected)
                        {
                            goods_numbers++;
                            if (date_good.count == 0)
                            {
                                NSMutableArray *goodmodelarray = @[].mutableCopy;
                                [goodmodelarray addObject:goodsModel];
                                [datedic setObject:goodmodelarray forKey:goods_listName];
                            }
                            else
                            {
                                // 遍历产品查看是否已经添加
                                for (NSDictionary *da_godic in date_good)
                                {
                                    for (NSString *datekey in da_godic)
                                    {
                                        if ([datekey isEqualToString:goods_listName])
                                        { // 同一个店铺的产品
                                            NSMutableArray *value = [da_godic objectForKey:goods_listName];
                                            NSMutableArray *nosame = @[].mutableCopy;
                                            [nosame addObject:goodsModel];
                                            [value addObject:goodsModel];
                                            [noSameArray setObject:nosame forKey:goods_listName];
                                            [datedic setObject:value forKey:goods_listName];
                                        }
                                        else
                                        { // 不是一个店铺的产品
                                            NSMutableArray *goodmodelarray = @[].mutableCopy;
                                            [goodmodelarray addObject:goodsModel];
                                            [datedic setObject:goodmodelarray forKey:goods_listName];
                                        }
                                    }
                                }
                            }
                            if (![date_good containsObject:datedic])
                            {
                                [date_good addObject:datedic];
                                if (noSameArray.count>0)
                                { // 删除多余的产品
                                  [date_good removeObject:noSameArray];
                                }
                            }
                        }
                    }
                }
                if (date_good.count>0)
                {
                    //  --结账
                    JXInvoicingViewController *invoicing = [[JXInvoicingViewController alloc] init];
                    invoicing.hidesBottomBarWhenPushed = true;
                    invoicing.dateArray = date_good;
                    invoicing.totalNum = rootView.totalNum;
                    invoicing.goodsNumber = goods_numbers;
                    [rootView.navigationController pushViewController:invoicing animated:YES];
                }
                else
                {
                    [rootView showHint:@"请选择商品"];
                }
                
            }
        }
    };
    
}

#pragma mark --- 选择规格返回刷新数据代理
- (void)refreshGoodCart {
    // 清空原本的数据
    [self.dateArray removeAllObjects];
    
     // 刷新
    [self dateRequest];
}

- (void)returnGoods_number:(NSInteger)number{}

#pragma  mark --- 动画代理
- (void)presentedOneControllerPressedDissmiss{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (id<UIViewControllerInteractiveTransitioning>)interactiveTransitionForPresent{
    return _interactivePush;
}

- (void)y_dateRequest {
    
    [JXNetworkRequest asyncRecommendedcompleted:^(NSDictionary *messagedic) {
        NSArray *infoArray = messagedic[@"info"];
        for (NSDictionary *infodic in infoArray) {
            JXHomepagModel *model = [[JXHomepagModel alloc] init];
            [model setValuesForKeysWithDictionary:infodic];
            [self.recommendedArray addObject:model];
        }
        [self.shopTable reloadData];
    } statisticsFail:^(NSDictionary *messagedic) {
        
    } fail:^(NSError *error) {
        
    }];
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
    self.collecotiongy.recommendedArray = [NSArray arrayWithArray:self.recommendedArray];
    [self addChildViewController:self.collecotiongy];
    [cell addSubview:self.collecotiongy.view];
    [self.collecotiongy didMoveToParentViewController:self];
    
}
#pragma mark -- headerView是否悬浮
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat sectionHeaderHeight = 50;
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
        if (!_rightEditor.selected) { // 不是编辑模式
            is_dropdown = YES;
            [self s_dropdownMJRefresh];
        }
        
    }
}

#pragma mark UITableView + 下拉刷新 默认
- (void)s_dropdownMJRefresh { // dropdown
    __unsafe_unretained __typeof(self) weakSelf = self;
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.shopTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadNewData];
        
    }];
    // 马上进入刷新状态
    [self.shopTable.mj_header beginRefreshing];
    
    
    
}
- (void)loadNewData {
    // 刷新数据提示是否已经登录
    is_firstTime = NO;
    if (!_rightEditor.selected) { // 不是编辑模式
        // 刷新过程中停止交互
        self.shopTable.scrollEnabled = NO;
        // 刷新表格
        
        // 直接控制下拉时间避免等待时间过长
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(MJDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self refreshGoodCart];
            
        });
    }else { // 编辑模式下不做数据刷新
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(MJDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self endofthedropdown];
            
        });
    }
}



#pragma mark ---  删除选中的商品
- (void)deleteGoodforSelect:(NSArray *)good_idArray {

    for (NSString *goodid in good_idArray)
    {
        // 删除购物车good_id记录勾选状态
        [JXJudgeStrObjc delegateGoods_idCart:[NSString stringWithFormat:@"%@",goodid]];
    }
    [JXNetworkRequest asyncdeleteShoppingCartspecificationsgood_id:good_idArray completed:^(NSDictionary *messagedic) {
        _rightEditor.selected = NO;
        [self.deletespecArray removeAllObjects];
        // 刷新数据
        [self refreshGoodCart];
    } statisticsFail:^(NSDictionary *messagedic) {
        [self showHint:messagedic[@"msg"]];
    } fail:^(NSError *error) {
        
    }];
}
#pragma mark -- 代理 商品的增减
- (void)goodsCatrIncreaseOrDecrease:(NSString *)goodNumber model:(MKGoodsModel *)model {
    [self refreshGoodCart];
    // 获取删除的id MKGoodsModel
    if (self.rightEditor.selected)
    {   // 编辑模式 --删除
        
        if (![self.deletespecArray containsObject:model.id]) {
            [self.deletespecArray addObject:model.id];
        }
        // 记录收藏的
        if (![self.collectiongood_idArray containsObject:model.good_id]) {
            [self.collectiongood_idArray addObject:model.good_id];
        }
    }
    

}

- (void)goodsOutofstock:(NSString *)stock {
    
    self.jxhud = [JXCustomHudview alterViewWithTitle:stock];
    [self.view addSubview:self.jxhud];
}





@end
