//
//  JXBrowseViewController.m
//  JaneCargo
//
//  Created by 鹏 on 2017/8/8.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXBrowseViewController.h"
#import "JXListGoodTableViewCell.h"
#import "JXNoContentTableViewCell.h"
@interface JXBrowseViewController ()<UITableViewDelegate,UITableViewDataSource> {

    NSInteger datepay;
    BOOL is_dropdown;
    BOOL is_delete;
}

@property (nonatomic, strong) UITableView *browseTable;
@property (nonatomic, strong) NSMutableArray *dateArray;

@end

@implementation JXBrowseViewController

static const CGFloat MJDuration = 0.5;

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated ];
    [JXEncapSulationObjc blackNavigation:self color:[UIColor whiteColor]];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    _dateArray = @[].mutableCopy;
    datepay = 1;
    [self listnavigation];
    [self listtableView];
    [self date_Request];
}

- (void)listtableView {
    [self.view setBackgroundColor:kUIColorFromRGB(0xf2f2f2)];
    UILabel * titleLabel =[[UILabel alloc]init];
    titleLabel.text = @"浏览记录";
    [titleLabel sizeToFit];
    titleLabel.textColor = [UIColor blackColor];
    self.navigationItem.titleView = titleLabel;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.browseTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, NPWidth, NPHeight-64)];
    self.browseTable.separatorStyle = UITableViewCellEditingStyleNone;
    self.browseTable.delegate = self;
    self.browseTable.dataSource = self;
    self.browseTable.backgroundColor = kUIColorFromRGB(0xf2f2f2);
    [self.browseTable setShowsVerticalScrollIndicator:NO];
    [self.view addSubview:self.browseTable];
    if (@available(iOS 11.0, *)) {
        self.browseTable.contentInsetAdjustmentBehavior =UIScrollViewContentInsetAdjustmentNever;
        self.browseTable.contentInset =UIEdgeInsetsMake(0,0,0,0);//64和49自己看效果，是否应该改成0
        self.browseTable.scrollIndicatorInsets =self.browseTable.contentInset;
    }
}

- (void)date_Request {
    
    [JXNetworkRequest asyncGoodsListForbrowse:[NSString stringWithFormat:@"%ld",(long)datepay] completed:^(NSDictionary *messagedic) {
        
        NSArray *infoArray = messagedic[@"info"];
        for (NSDictionary *infodic in infoArray) {
            JXHomepagModel *model = [[JXHomepagModel alloc] init];
            [model setValuesForKeysWithDictionary:infodic];
            [self.dateArray addObject:model];
        }
        self.browseTable.scrollEnabled = YES;
        [self endofthedropdown];
        [self endofthepulldown];
        [self.browseTable reloadData];
    } statisticsFail:^(NSDictionary *messagedic) {
        self.browseTable.scrollEnabled = YES;
        [self endofthedropdown];
        [self endofthepulldown];
    } fail:^(NSError *error) {
        self.browseTable.scrollEnabled = YES;
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.dateArray.count == 0) {
        return 0;
    }else {
        return self.dateArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.dateArray.count == 0) {
        JXNoContentTableViewCell *cell = [JXNoContentTableViewCell cellWithTable];
        [cell setSelectionStyle:(UITableViewCellSelectionStyleNone)];
        self.browseTable.scrollEnabled = NO;
        return cell;
    }else {
        JXHomepagModel *model;
        JXListGoodTableViewCell *cell = [JXListGoodTableViewCell cellWithTable];
//        self.browseTable.scrollEnabled = YES;
        [cell setSelectionStyle:(UITableViewCellSelectionStyleNone)];
        
        if (self.dateArray.count>0) {
            
            if (indexPath.row<self.dateArray.count) {
                model = self.dateArray[indexPath.row];
            }
            [cell setModel:model];
            
        }
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.dateArray.count == 0) {
        return self.view.frame.size.height-64;
    }else {
        //
        return 114;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.dateArray.count != 0) {
        JXHomepagModel *model = self.dateArray[indexPath.row];
        [JXPodOrPreVc buyGoodsModel:model navigation:self.navigationController];
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
        
        JXHomepagModel *model = self.dateArray[indexPath.row];
        [JXNetworkRequest asyncdeleteGoodsListForbrowse:[NSString stringWithFormat:@"%@",model.id] completed:^(NSDictionary *messagedic) {
            [self.dateArray removeObjectAtIndex:indexPath.row];
            
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [self showHint:messagedic[@"msg"]];
        } statisticsFail:^(NSDictionary *messagedic) {
            [self showHint:messagedic[@"msg"]];
        } fail:^(NSError *error) {
            
        }];
    }
    
    
}

//修改删除操作title -默认 "删除"(Delete) -跟随系统语言
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}


//#pragma mark -- 删除操作
//-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (self.dateArray.count == 0) {
//        return UITableViewCellEditingStyleNone;
//    }else {
//        //
//        return UITableViewCellEditingStyleDelete;
//    }
//
//}

////左拉抽屉(删除和修改按钮)
//- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
//    // 添加一个删除按钮
//    is_delete = YES;
//    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除"handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
//
//        JXHomepagModel *model = self.dateArray[indexPath.row];
//        [JXNetworkRequest asyncdeleteGoodsListForbrowse:[NSString stringWithFormat:@"%@",model.id] completed:^(NSDictionary *messagedic) {
//            [self.dateArray removeObjectAtIndex:indexPath.row];
//
//            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//            [self showHint:messagedic[@"msg"]];
//        } statisticsFail:^(NSDictionary *messagedic) {
//            [self showHint:messagedic[@"msg"]];
//        } fail:^(NSError *error) {
//
//        }];
//
//
//
//    }];
//
//
//    // 将设置好的按钮放到数组中返回
//    return @[deleteRowAction];
//}

#pragma mark -- headerView是否悬浮
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat contentOffset = scrollView.contentOffset.y;
    if (!is_dropdown && contentOffset < -60) {
        is_dropdown = YES;
        [self s_dropdownMJRefresh];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    if (self.browseTable.contentOffset.y>self.browseTable.contentSize.height-self.browseTable.frame.size.height-64) {
        [self s_pullMJRefresh];
    }
    
}


#pragma mark UITableView + 下拉刷新 默认
- (void)s_dropdownMJRefresh { // dropdown
    __unsafe_unretained __typeof(self) weakSelf = self;
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.browseTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadNewData];
        
    }];
    // 马上进入刷新状态
    [self.browseTable.mj_header beginRefreshing];
}
- (void)loadNewData {
    datepay = 1;
    is_delete = NO;
    self.browseTable.scrollEnabled = NO;
    [self.dateArray removeAllObjects];
    // 刷新过程中停止交互
//    self.browseTable.scrollEnabled = NO;
    // 刷新表格
    
    // 直接控制下拉时间避免等待时间过长
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(MJDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self date_Request];
        
        
    });
}
#pragma mark -- 下拉结束
- (void)endofthedropdown {
    // 拿到当前的下拉刷新控件，结束刷新状态
    [self.browseTable.mj_header endRefreshing];
    
}

#pragma mark -- 上拉结束
- (void)endofthepulldown {
    // 拿到当前的下拉刷新控件，结束刷新状态
    [self.browseTable.mj_footer endRefreshing];
}


#pragma mark UITableView + 上拉刷新 自动回弹的上拉01
- (void)s_pullMJRefresh {
    
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
    self.browseTable.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    // 设置了底部inset
    self.browseTable.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    // 忽略掉底部inset
    self.browseTable.mj_footer.ignoredScrollViewContentInsetBottom = 0;
}

#pragma mark 上拉加载更多数据
- (void)loadMoreData {
    datepay ++;
    // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self date_Request];
//        [self date_Request:datepay];
    });
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
