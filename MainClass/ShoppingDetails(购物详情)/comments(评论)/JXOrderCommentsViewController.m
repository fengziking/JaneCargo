//
//  JXOrderCommentsViewController.m
//  JaneCargo
//
//  Created by 鹏 on 2017/7/18.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXOrderCommentsViewController.h"
#import "JXCommentsTableViewCell.h"
#import "JXNoContentTableViewCell.h"
@interface JXOrderCommentsViewController ()<UITableViewDelegate,UITableViewDataSource> {
    
    UITableView *commentsTable;
    BOOL is_dropdown;
    NSInteger datepay;
}
@property (nonatomic, strong) NSMutableArray *commentdateArray;
@end

@implementation JXOrderCommentsViewController
static const CGFloat MJDuration = 0.5;

- (void)viewDidAppear:(BOOL)animated {

    [super viewDidAppear:animated];
//    datepay = 1;
//    [self y_dateRequest:datepay];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.commentdateArray = @[].mutableCopy;
    [self.view setFrame:CGRectMake(NPWidth*2, 0, NPWidth, NPHeight)];
    [self layoutTempTable];
    datepay = 1;
    [self y_dateRequest:datepay];
    
}


- (void)y_dateRequest:(NSUInteger)pag {

    // 评论
    [JXNetworkRequest asyncGoodseValuation:[NSString stringWithFormat:@"%@",_goodsid] page:pag is_Cache:NO refreshCache:NO completed:^(NSDictionary *messagedic) {
        // 商品评论
        NSArray *goodassessArray = messagedic[@"info"];
        for (NSDictionary *goodassessdic in goodassessArray) {
            JXHomepagModel *model = [[JXHomepagModel alloc] init];
            [model setValuesForKeysWithDictionary:goodassessdic];
            [self.commentdateArray addObject:model];
        }
        [self endofthedropdown];
        [self endofthepulldown];
        [commentsTable reloadData];
    } statisticsFail:^(NSDictionary *messagedic) {
        [self endofthedropdown];
        [self endofthepulldown];
    } fail:^(NSError *error) {
        [self endofthedropdown];
        [self endofthepulldown];
    }];
}


- (void)layoutTempTable {
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    commentsTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, NPWidth, self.view.bounds.size.height-50)];
    commentsTable.separatorStyle = UITableViewCellEditingStyleNone;
    commentsTable.delegate = self;
    commentsTable.dataSource = self;
    commentsTable.backgroundColor = kUIColorFromRGB(0xf2f2f2);
    [self.view addSubview:commentsTable];
    if (@available(iOS 11.0, *)) {
        commentsTable.contentInsetAdjustmentBehavior =UIScrollViewContentInsetAdjustmentNever;
        commentsTable.contentInset =UIEdgeInsetsMake(0,0,0,0);//64和49自己看效果，是否应该改成0
        commentsTable.scrollIndicatorInsets =commentsTable.contentInset;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.commentdateArray.count == 0) {
        return 1;
    }else {
        return self.commentdateArray.count;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.commentdateArray.count == 0) {
        JXNoContentTableViewCell *cell = [JXNoContentTableViewCell cellWithTable];
        [cell setSelectionStyle:(UITableViewCellSelectionStyleNone)];
        commentsTable.rowHeight = self.view.bounds.size.height-50-64;
        commentsTable.scrollEnabled = NO;
        return cell;
    }else {
        JXHomepagModel *model = self.commentdateArray[indexPath.section];
        JXCommentsTableViewCell *cell = [JXCommentsTableViewCell cellWithTable];
        [cell setSelectionStyle:(UITableViewCellSelectionStyleNone)];
        commentsTable.rowHeight = 100;
        commentsTable.scrollEnabled = YES;
        [cell setModel:model];
        return cell;
    }
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
    
    if (commentsTable.contentOffset.y>commentsTable.contentSize.height-commentsTable.frame.size.height-64) {
        [self s_pullMJRefresh];
    }
}


#pragma mark UITableView + 下拉刷新 默认
- (void)s_dropdownMJRefresh { // dropdown
    __unsafe_unretained __typeof(self) weakSelf = self;
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    commentsTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadNewData];
        
    }];
    // 马上进入刷新状态
    [commentsTable.mj_header beginRefreshing];
}
- (void)loadNewData {
    datepay = 1;
    [self.commentdateArray removeAllObjects];
    // 刷新过程中停止交互
    
    // 刷新表格
    
    // 直接控制下拉时间避免等待时间过长
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(MJDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self y_dateRequest:datepay];
        
    });
}
#pragma mark -- 下拉结束
- (void)endofthedropdown {
    // 拿到当前的下拉刷新控件，结束刷新状态
    [commentsTable.mj_header endRefreshing];
    
}

#pragma mark -- 上拉结束
- (void)endofthepulldown {
    // 拿到当前的下拉刷新控件，结束刷新状态
    [commentsTable.mj_footer endRefreshing];
    
}

#pragma mark UITableView + 上拉刷新 自动回弹的上拉01
- (void)s_pullMJRefresh {
    
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
    commentsTable.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    // 设置了底部inset
    commentsTable.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    // 忽略掉底部inset
    commentsTable.mj_footer.ignoredScrollViewContentInsetBottom = 0;
}

#pragma mark 上拉加载更多数据
- (void)loadMoreData {
    datepay ++;
    // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self y_dateRequest:datepay];
    });
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
