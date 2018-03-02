//
//  JXInvoiceViewController.m
//  JaneCargo
//
//  Created by 鹏 on 2017/8/9.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXInvoiceViewController.h"
#import "JXIntegralTableViewCell.h"
#import "JXNoContentTableViewCell.h"
@interface JXInvoiceViewController () <UITableViewDelegate,UITableViewDataSource> {
    
    NSInteger datepay;
    BOOL is_dropdown;
}

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UITableView *integralTable;

@end

@implementation JXInvoiceViewController
static const CGFloat MJDuration = 0.5;


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated ];
    [JXEncapSulationObjc blackNavigation:self color:[UIColor whiteColor]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    datepay = 1;
    self.dataArray = @[].mutableCopy;
    [self listtableView];
    [self listnavigation];
    [self date_Request:datepay];
}

- (void)date_Request:(NSInteger)pager {
    
    [JXNetworkRequest asyncRecordsofmakeoutanInvoice:[NSString stringWithFormat:@"%ld",pager] completed:^(NSDictionary *messagedic) {
        for (NSDictionary *dic in messagedic[@"info"]) {
            JXHomepagModel *model = [[JXHomepagModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [self.dataArray addObject:model];
        }
        [self endofthedropdown];
        [self endofthepulldown];
        [self.integralTable reloadData];
    } statisticsFail:^(NSDictionary *messagedic) {
        [self endofthedropdown];
        [self endofthepulldown];
    } fail:^(NSError *error) {
        [self endofthedropdown];
        [self endofthepulldown];
    }];
    
    
    
}


- (void)listnavigation {
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_back"] style:(UIBarButtonItemStylePlain) target:self action:@selector(leftAction:)];
}

- (void)leftAction:(UIBarButtonItem *)sender  {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)listtableView {
    [self.view setBackgroundColor:kUIColorFromRGB(0xf2f2f2)];
    UILabel * titleLabel =[[UILabel alloc]init];
    titleLabel.text = @"开票记录";
    [titleLabel sizeToFit];
    titleLabel.textColor = [UIColor blackColor];
    self.navigationItem.titleView = titleLabel;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.integralTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, NPWidth, NPHeight-64)];
    self.integralTable.separatorStyle = UITableViewCellEditingStyleNone;
    self.integralTable.delegate = self;
    self.integralTable.dataSource = self;
    self.integralTable.backgroundColor = kUIColorFromRGB(0xf2f2f2);
    [self.integralTable setShowsVerticalScrollIndicator:NO];
    [self.view addSubview:self.integralTable];
    if (@available(iOS 11.0, *)) {
        self.integralTable.contentInsetAdjustmentBehavior =UIScrollViewContentInsetAdjustmentNever;
        self.integralTable.contentInset =UIEdgeInsetsMake(0,0,0,0);//64和49自己看效果，是否应该改成0
        self.integralTable.scrollIndicatorInsets =self.integralTable.contentInset;
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.dataArray.count == 0) {
        return 1;
    }else {
        return self.dataArray.count;
    }
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.dataArray.count == 0) {
        JXNoContentTableViewCell *cell = [JXNoContentTableViewCell cellWithTable];
        [cell setSelectionStyle:(UITableViewCellSelectionStyleNone)];
        self.integralTable.scrollEnabled = NO;
        return cell;
    }else {
        JXHomepagModel *model = self.dataArray[indexPath.row];
        JXIntegralTableViewCell *cell = [JXIntegralTableViewCell cellWithTable];
        [cell setModel:model];
        return cell;
    }
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.dataArray.count == 0) {
        return self.view.frame.size.height-64;
    }else {
        return 70;
    }
    
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat contentOffset = scrollView.contentOffset.y;
    if (!is_dropdown && contentOffset < -60) {
        is_dropdown = YES;
        [self s_dropdownMJRefresh];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    if (self.integralTable.contentOffset.y>self.integralTable.contentSize.height-self.integralTable.frame.size.height-64) {
        [self s_pullMJRefresh];
    }
}

#pragma mark UITableView + 下拉刷新 默认
- (void)s_dropdownMJRefresh { // dropdown
    __unsafe_unretained __typeof(self) weakSelf = self;
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.integralTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadNewData];
        
    }];
    // 马上进入刷新状态
    [self.integralTable.mj_header beginRefreshing];
}
- (void)loadNewData {
    datepay = 1;
    [self.dataArray removeAllObjects];
    // 刷新过程中停止交互
    //    self.browseTable.scrollEnabled = NO;
    // 刷新表格
    
    // 直接控制下拉时间避免等待时间过长
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(MJDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self date_Request:datepay];
        
        
    });
}
#pragma mark -- 下拉结束
- (void)endofthedropdown {
    // 拿到当前的下拉刷新控件，结束刷新状态
    [self.integralTable.mj_header endRefreshing];
    self.integralTable.scrollEnabled = YES;
}

#pragma mark -- 上拉结束
- (void)endofthepulldown {
    // 拿到当前的下拉刷新控件，结束刷新状态
    [self.integralTable.mj_footer endRefreshing];
}


#pragma mark UITableView + 上拉刷新 自动回弹的上拉01
- (void)s_pullMJRefresh {
    
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
    self.integralTable.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    // 设置了底部inset
    self.integralTable.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    // 忽略掉底部inset
    self.integralTable.mj_footer.ignoredScrollViewContentInsetBottom = 0;
}

#pragma mark 上拉加载更多数据
- (void)loadMoreData {
    datepay ++;
    // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self date_Request:datepay];
    });
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
