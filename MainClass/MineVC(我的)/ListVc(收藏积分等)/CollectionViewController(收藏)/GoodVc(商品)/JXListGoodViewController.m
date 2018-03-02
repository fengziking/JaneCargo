//
//  JXListGoodViewController.m
//  JaneCargo
//
//  Created by 鹏 on 2017/8/7.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXListGoodViewController.h"
#import "JXListGoodTableViewCell.h"
#import "JXNoContentTableViewCell.h"
@interface JXListGoodViewController ()<UITableViewDelegate,UITableViewDataSource> {

    NSInteger tableType;
    NSInteger datepay;
    BOOL is_dropdown;
    BOOL is_deleteGoods;
}
@property (nonatomic, strong) UITableView *listTable;
@property (weak, nonatomic) IBOutlet UIView *line;
@property (weak, nonatomic) IBOutlet UIButton *goodsbt;
@property (weak, nonatomic) IBOutlet UIButton *promotionbt;
@property (weak, nonatomic) IBOutlet UIButton *pricebt;
// 数据
@property (nonatomic, strong) NSMutableArray *dateArray;
@property (nonatomic, strong) NSMutableArray *promotionArray;
@property (nonatomic, strong) NSMutableArray *priceArray;

@end

@implementation JXListGoodViewController

static const CGFloat MJDuration = 0.5;

- (void)viewDidLoad {
    [super viewDidLoad];
    datepay = 1;
    self.dateArray = @[].mutableCopy;
    self.priceArray = @[].mutableCopy;
    self.promotionArray = @[].mutableCopy;
    [self date_Request:datepay];
    [self listtableView];
    [self listnavigation];
    
}

- (void)date_Request:(NSInteger)pay {

    [JXNetworkRequest asyncdeleteCollectionListShoppingCartspecificationsPag:[NSString stringWithFormat:@"%ld",pay] completed:^(NSDictionary *messagedic) {
        NSArray *info_Array = messagedic[@"info"];
        for (NSDictionary *infodic in info_Array) {
            JXHomepagModel *model = [[JXHomepagModel alloc] init];
            [model setValuesForKeysWithDictionary:infodic];
            [self.dateArray addObject:model];
            if ([infodic[@"is_hot"] integerValue] == 1) {
                [model setValuesForKeysWithDictionary:infodic];
                [self.promotionArray addObject:model];
            }
            if ([infodic[@"is_clear"] integerValue] == 1) {
                [model setValuesForKeysWithDictionary:infodic];
                [self.priceArray addObject:model];
            }
        }
        [self endofthedropdown];
        [self endofthepulldown];
        [self.listTable reloadData];
    } statisticsFail:^(NSDictionary *messagedic) {
        [self endofthedropdown];
        [self endofthepulldown];
    } fail:^(NSError *error) {
        [self endofthedropdown];
        [self endofthepulldown];
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)goodsAction:(UIButton *)sender {
    
    tableType = 0;
    [self setbtColor:kUIColorFromRGB(0xef5b4c) promotioncolor:kUIColorFromRGB(0x333333) pricecolor:kUIColorFromRGB(0x333333)];
    [self.listTable reloadData];
}


- (IBAction)promotionAction:(UIButton *)sender {
    
    tableType = 1;
    [self setbtColor:kUIColorFromRGB(0x333333) promotioncolor:kUIColorFromRGB(0xef5b4c) pricecolor:kUIColorFromRGB(0x333333)];
    [self.listTable reloadData];
}

- (IBAction)priceAction:(UIButton *)sender {
    
    tableType = 2;
    [self setbtColor:kUIColorFromRGB(0x333333) promotioncolor:kUIColorFromRGB(0x333333) pricecolor:kUIColorFromRGB(0xef5b4c)];
    [self.listTable reloadData];
}

- (void)setbtColor:(UIColor *)goodscolor promotioncolor:(UIColor *)promotioncolor pricecolor:(UIColor *)pricecolor {

    [self.goodsbt setTitleColor:goodscolor forState:(UIControlStateNormal)];
    [self.promotionbt setTitleColor:promotioncolor forState:(UIControlStateNormal)];
    [self.pricebt setTitleColor:pricecolor forState:(UIControlStateNormal)];
}


- (void)listnavigation {

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_back"] style:(UIBarButtonItemStylePlain) target:self action:@selector(leftAction:)];
}

- (void)leftAction:(UIBarButtonItem *)sender  {
    [self.navigationController popViewControllerAnimated:YES];
}



- (void)listtableView {
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.listTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, NPWidth, NPHeight-44-64)];
    self.listTable.separatorStyle = UITableViewCellEditingStyleNone;
    self.listTable.delegate = self;
    self.listTable.dataSource = self;
    self.listTable.backgroundColor = kUIColorFromRGB(0xf2f2f2);
    [self.listTable setShowsVerticalScrollIndicator:NO];
    [self.view addSubview:self.listTable];
    if (@available(iOS 11.0, *)) {
        self.listTable.contentInsetAdjustmentBehavior =UIScrollViewContentInsetAdjustmentNever;
        self.listTable.contentInset =UIEdgeInsetsMake(0,0,0,0);//64和49自己看效果，是否应该改成0
        self.listTable.scrollIndicatorInsets =self.listTable.contentInset;
    }
   
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (tableType == 0) {
        if (self.dateArray.count == 0)
        {
            if (is_deleteGoods) {
                return 0;
            }else {
                return 1;
            }
        }else {
            return self.dateArray.count;
        }
    }else if (tableType == 1) {
        if (self.promotionArray.count == 0)
        {
            if (is_deleteGoods) {
                return 0;
            }else {
                return 1;
            }
        }else {
            return self.promotionArray.count;
        }
    }else if (tableType == 2) {
        if (self.priceArray.count == 0)
        {
            if (is_deleteGoods) {
                return 0;
            }else {
                return 1;
            }
        }else {
            return self.priceArray.count;
        }
    }else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JXHomepagModel *model;
    if (tableType == 0)
    {
        if (self.dateArray.count == 0)
        {
            JXNoContentTableViewCell *cell = [JXNoContentTableViewCell cellWithTable];
            self.listTable.scrollEnabled = NO;
            return cell;
        }
        else
        {
            JXListGoodTableViewCell *cell = [JXListGoodTableViewCell cellWithTable];
            self.listTable.scrollEnabled = YES;
            [cell setSelectionStyle:(UITableViewCellSelectionStyleNone)];
            model = self.dateArray[indexPath.row];
            [cell setModel:model];
            return cell;
        }
        
        
    }
    else if (tableType == 1)
    {
        if (self.promotionArray.count == 0)
        {
            JXNoContentTableViewCell *cell = [JXNoContentTableViewCell cellWithTable];
            self.listTable.scrollEnabled = NO;
            return cell;
        }
        else
        {
            JXListGoodTableViewCell *cell = [JXListGoodTableViewCell cellWithTable];
            self.listTable.scrollEnabled = YES;
            [cell setSelectionStyle:(UITableViewCellSelectionStyleNone)];
            model = self.promotionArray[indexPath.row];
            [cell setModel:model];
            return cell;
        }
        
    }
    else if (tableType == 2)
    {
        if (self.priceArray.count == 0)
        {
            JXNoContentTableViewCell *cell = [JXNoContentTableViewCell cellWithTable];
            self.listTable.scrollEnabled = NO;
            return cell;
        }
        else
        {
            JXListGoodTableViewCell *cell = [JXListGoodTableViewCell cellWithTable];
            self.listTable.scrollEnabled = YES;
            [cell setSelectionStyle:(UITableViewCellSelectionStyleNone)];
            model = self.priceArray[indexPath.row];
            [cell setModel:model];
            return cell;
        }
        
    }else {
        JXNoContentTableViewCell *cell = [JXNoContentTableViewCell cellWithTable];
        self.listTable.scrollEnabled = NO;
        return cell;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JXHomepagModel *model;
    if (tableType == 0)
    {
        
        if (self.dateArray.count != 0)
        {
            model = self.dateArray[indexPath.row];
            [JXPodOrPreVc buyGoodsModel:model navigation:self.navigationController];
        }
    }
    else if (tableType == 1)
    {
        
        
        if (self.promotionArray.count != 0)
        {
            model = self.promotionArray[indexPath.row];
            [JXPodOrPreVc buyGoodsModel:model navigation:self.navigationController];
        }
    }
    else if (tableType == 2)
    {
        
        if (self.priceArray.count != 0)
        {
            model = self.priceArray[indexPath.row];
            [JXPodOrPreVc buyGoodsModel:model navigation:self.navigationController];
        }
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 1;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, NPWidth, 1)];
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableType == 0)
    {
        if (self.dateArray.count == 0)
        {
            return self.view.frame.size.height-64-50;
        }else {
            return 114;
        }
    }
    else if (tableType == 1)
    {
        if (self.promotionArray.count == 0)
        {
            return self.view.frame.size.height-64-50;
        }else {
            return 114;
        }
    }
    else if (tableType == 2)
    {
        if (self.priceArray.count == 0)
        {
            return self.view.frame.size.height-64-50;
        }else {
            return 114;
        }
    }else {
        return 0;
    }
    
}




- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.dateArray.count == 0)
    {
        return NO;
    }else {
        return YES;
    }
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        JXHomepagModel *model;
        if (tableType == 0) {
            model = self.dateArray[indexPath.row];
            [self.dateArray removeObjectAtIndex:indexPath.row];
            if (self.dateArray.count == 0) {
                is_deleteGoods = YES;
            }
        }else if (tableType == 1) {
            model = self.promotionArray[indexPath.row];
            [self.promotionArray removeObjectAtIndex:indexPath.row];
            if (self.promotionArray.count == 0) {
                is_deleteGoods = YES;
            }
        }else if (tableType == 2) {
            model = self.priceArray[indexPath.row];
            [self.priceArray removeObjectAtIndex:indexPath.row];
            if (self.priceArray.count == 0) {
                is_deleteGoods = YES;
            }
        }
        [JXNetworkRequest asyncdeleteCollectionShoppingCartspecificationsgood_id:[NSArray arrayWithObject:[NSString stringWithFormat:@"%@",model.id]] completed:^(NSDictionary *messagedic) {
            
            
            [self showHint:messagedic[@"msg"]];
        } statisticsFail:^(NSDictionary *messagedic) {
            [self showHint:messagedic[@"msg"]];
            return ;
        } fail:^(NSError *error) {
            
        }];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    
    
}

//修改删除操作title -默认 "删除"(Delete) -跟随系统语言
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}



#pragma mark --
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat contentOffset = scrollView.contentOffset.y;
    if (!is_dropdown && contentOffset < -60) {
        is_dropdown = YES;
        [self s_dropdownMJRefresh];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    if (self.listTable.contentOffset.y>self.listTable.contentSize.height-self.listTable.frame.size.height-64) {
        [self s_pullMJRefresh];
    }
}


#pragma mark UITableView + 下拉刷新 默认
- (void)s_dropdownMJRefresh { // dropdown
    __unsafe_unretained __typeof(self) weakSelf = self;
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.listTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadNewData];
        
    }];
    // 马上进入刷新状态
    [self.listTable.mj_header beginRefreshing];
}
- (void)loadNewData {
    datepay = 1;
    [self.dateArray removeAllObjects];
    [self.priceArray removeAllObjects];
    [self.promotionArray removeAllObjects];
    // 刷新过程中停止交互
    self.listTable.scrollEnabled = NO;
    // 刷新表格
    
    // 直接控制下拉时间避免等待时间过长
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(MJDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self date_Request:datepay];
        
    });
}
#pragma mark -- 下拉结束
- (void)endofthedropdown {
    // 拿到当前的下拉刷新控件，结束刷新状态
    [self.listTable.mj_header endRefreshing];
    self.listTable.scrollEnabled = YES;
}

#pragma mark -- 上拉结束
- (void)endofthepulldown {
    // 拿到当前的下拉刷新控件，结束刷新状态
    [self.listTable.mj_footer endRefreshing];
    
}

#pragma mark UITableView + 上拉刷新 自动回弹的上拉01
- (void)s_pullMJRefresh {
    
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
    self.listTable.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    // 设置了底部inset
    self.listTable.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    // 忽略掉底部inset
    self.listTable.mj_footer.ignoredScrollViewContentInsetBottom = 0;
}

#pragma mark 上拉加载更多数据
- (void)loadMoreData {
    datepay ++;
    // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
    [self date_Request:datepay];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
    });
}










@end
