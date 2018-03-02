//
//  JXListStoreViewController.m
//  JaneCargo
//
//  Created by 鹏 on 2017/8/8.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXListStoreViewController.h"
#import "JXListStoreTableViewCell.h"
#import "JXShopHomeViewController.h"
#import "JXNoContentTableViewCell.h"
@interface JXListStoreViewController () <UITableViewDelegate,UITableViewDataSource> {

    NSInteger datepay;
    BOOL is_dropdown;
}
@property (nonatomic, strong) UITableView *listTable;
@property (nonatomic, strong) NSMutableArray *dateArray;
@end

@implementation JXListStoreViewController

static const CGFloat MJDuration = 0.5;

- (void)viewDidLoad {
    [super viewDidLoad];
    datepay = 1;
    self.dateArray = @[].mutableCopy;
    [self listtableView];
    [self date_Request:datepay];
}


- (void)date_Request:(NSInteger)page {

    [JXNetworkRequest goodsListFoeShop:[NSString stringWithFormat:@"%ld",page]  completed:^(NSDictionary *messagedic) {
        NSArray *infoArray = messagedic[@"info"];
        for (NSDictionary *list in infoArray) {
            JXStoreMore* obj = [JXStoreMore mj_objectWithKeyValues:list];
            [self.dateArray addObject:obj];
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

- (void)listtableView {
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.listTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, NPWidth, NPHeight-64)];
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.dateArray.count == 0) {
        return 1;
    }else {
        return self.dateArray.count;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JXStoreModel *model;
    if (self.dateArray.count>0) {
        model = self.dateArray[indexPath.section];
    }
    
    
    if (self.dateArray.count == 0) {
        JXNoContentTableViewCell *cell = [JXNoContentTableViewCell cellWithTable];
        [cell setSelectionStyle:(UITableViewCellSelectionStyleNone)];
        self.listTable.scrollEnabled = NO;
        return cell;
    }else {
        JXListStoreTableViewCell *cell = [JXListStoreTableViewCell cellWithTable];
        [cell setSelectionStyle:(UITableViewCellSelectionStyleNone)];
        [cell setBackgroundColor:kUIColorFromRGB(0xf2f2f2)];
        
        cell.SelectImage = ^(NSInteger type,JXStoreMore *model) {
            [self selectgoods:type model:model];
        };
        cell.Moreblock = ^(JXStoreMore *model) {
            [self moregoodsmodel:model];
        };
        cell.Deletegoodshop = ^(JXStoreMore *model) {
            [self deletegoodShopmodel:model indexPath:indexPath];
        };
        [cell setModel:model];
        return cell;
    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


// 选中
- (void)selectgoods:(NSInteger)type model:(JXStoreMore *)model {
    
    NSMutableArray *goodidArray = @[].mutableCopy;
    NSArray *dateArray = model.info;
    for (JXHomepagModel *model in dateArray) {
        [goodidArray addObject:model];
    }
    [JXPodOrPreVc buyGoodsModel:goodidArray[type] navigation:self.navigationController];
}

// 更多
- (void)moregoodsmodel:(JXStoreMore *)model {
    
    JXShopHomeViewController *shop = [[JXShopHomeViewController alloc] init];
    shop.seller_id = model.seller_id;
    [self.navigationController pushViewController:shop animated:YES];
}

// 删除
- (void)deletegoodShopmodel:(JXStoreMore *)model indexPath:(NSIndexPath *)indexPath{

    [JXNetworkRequest asyncCancelFocusOnBusiness:model.seller_id completed:^(NSDictionary *messagedic) {
        [self showHint:@"删除成功"];
        [self.dateArray removeObjectAtIndex:indexPath.section];
        [self.listTable reloadData];
    
    } statisticsFail:^(NSDictionary *messagedic) {
        [self showHint:@"删除失败"];
    } fail:^(NSError *error) {
        [self showHint:@"删除失败"];
    }];
    
}





- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.dateArray.count == 0) {
        return self.view.frame.size.height-64;
    }else {
        return 218;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (self.dateArray.count == 0) {
        return 0;
    }else {
        return 10;
    }
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, NPWidth, 10)];
    return view;
    
}



//#pragma mark -- 删除操作
//-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return UITableViewCellEditingStyleDelete;
//}
//
////左拉抽屉(删除和修改按钮)
//- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
//    // 添加一个删除按钮
//    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除"handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
//        
//        
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//    }];
//    // 将设置好的按钮放到数组中返回
//    return @[deleteRowAction];
//}


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
