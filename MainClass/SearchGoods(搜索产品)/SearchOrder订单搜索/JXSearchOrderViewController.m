//
//  JXSearchOrderViewController.m
//  JaneCargo
//
//  Created by 鹏 on 2017/8/23.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXSearchOrderViewController.h"
#import "JXHisRecordTableViewCell.h"
#import "JXSearchResultsViewController.h"
@interface JXSearchOrderViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,Orderpaydelegate> {

    NSString *order_searchStr;

}

@property (nonatomic, strong) UITableView *searchOrderTable;
/** 搜索框*/
@property(strong,nonatomic) UISearchBar *searchBar;
/** 占位文字*/
@property(copy,nonatomic) NSString *placeHolder;

@end

@implementation JXSearchOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupBasic];
    [self setupNav];
    [self.view setBackgroundColor:kUIColorFromRGB(0xf2f2f2)];
    
}




- (void)newTime {

    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
    NSString *DateTime = [formatter stringFromDate:date];
    NSString *is_time = [[NSUserDefaults standardUserDefaults] objectForKey:@"OrderTimeClear"];
    if (kStringIsEmpty(is_time)) { // 不存在则添加
        
        [[NSUserDefaults standardUserDefaults] setObject:DateTime forKey:@"OrderTimeClear"];
        KDLOG(@"刚入门 添加成功");
    }else {
    
        NSString *contrastTime = [self dateTimeDifferenceWithStartTime:is_time endTime:DateTime];
        if ([contrastTime isEqualToString:@"24"]) { // 已经到了24小时 清除数据重新记录当前的时间
            [[NSUserDefaults standardUserDefaults] setObject:DateTime forKey:@"OrderTimeClear"];
            // 清除本地订单搜索记录
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"OrderSearchSave"];
        }else {
            KDLOG(@"时间未到不处理");
        }
    }
}


- (NSString *)dateTimeDifferenceWithStartTime:(NSString *)startTime endTime:(NSString *)endTime{
    NSDateFormatter *date = [[NSDateFormatter alloc]init];
    [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *startD =[date dateFromString:startTime];
    NSDate *endD = [date dateFromString:endTime];
    NSTimeInterval start = [startD timeIntervalSince1970]*1;
    NSTimeInterval end = [endD timeIntervalSince1970]*1;
    NSTimeInterval value = end - start;
   // int second = (int)value %60;//秒
  //  int minute = (int)value /60%60;
    int house = (int)value / (24 *3600)%3600;
    //int day = (int)value / (24 *3600);
    NSString *str= [NSString stringWithFormat:@"%d",house];
   // if (day != 0) {
   //     str = [NSString stringWithFormat:@"耗时%d天%d小时%d分%d秒",day,house,minute,second];
   // }else if (day==0 && house !=0) {
   //     str = [NSString stringWithFormat:@"耗时%d小时%d分%d秒",house,minute,second];
   // }else if (day==0 && house==0 && minute!=0) {
   //     str = [NSString stringWithFormat:@"耗时%d分%d秒",minute,second];
   // }else{
    //    str = [NSString stringWithFormat:@"耗时%d秒",second];
   // }
    return str;
}

- (void)orderpaysuccess {
    
    [self.navigationController popViewControllerAnimated:NO];
}

#pragma mark - 初始化
- (void)setupBasic {
    
    self.searchOrderTable = [[UITableView alloc] init];
    self.searchOrderTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.searchOrderTable.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    self.searchOrderTable.dataSource = self;
    self.searchOrderTable.delegate = self;
    [self.view addSubview:self.searchOrderTable];
}

- (void)setupNav {
    
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.searchBar];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(rightBtnDidClick:)];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor darkGrayColor]} forState:UIControlStateNormal];
    [self.searchBar becomeFirstResponder];
}

#pragma mark ----  取消搜索
- (void)rightBtnDidClick :(UIBarButtonItem *)item {
    
    [self.searchBar resignFirstResponder];
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark -- 搜索代理
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    if ([searchText isEqualToString:@""]) {
        return;
    }
    order_searchStr = searchText;
}
#pragma mark -- 点击搜索----进入物品排序列表
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    // 保存本地
    [self newTime];
    [self addSearchrecords:order_searchStr];
    JXSearchResultsViewController *results = [JXSearchResultsViewController alloc];
    results.orederStr = order_searchStr;
    results.orderpaydelegte = self;
    [self.navigationController pushViewController:results animated:YES];
}

- (void)addSearchrecords:(NSString *)searchName {
    
    NSArray *goodid = [[NSUserDefaults standardUserDefaults] objectForKey:@"OrderSearchSave"];
    NSMutableArray *goods_idArray = @[].mutableCopy;
    if (!kArrayIsEmpty(goodid)) { // 存在
        goods_idArray = [NSMutableArray arrayWithArray:goodid];
    }
    if (![goods_idArray containsObject:searchName]) {
        [goods_idArray addObject:searchName];
    }
    // 记录搜索
    [[NSUserDefaults standardUserDefaults] setObject:goods_idArray forKey:@"OrderSearchSave"];
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    NSArray *goodid = [[NSUserDefaults standardUserDefaults] objectForKey:@"OrderSearchSave"];
    return goodid.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    NSArray *goodid = [[NSUserDefaults standardUserDefaults] objectForKey:@"OrderSearchSave"];
    JXHisRecordTableViewCell *cell = [JXHisRecordTableViewCell cellWithTable];
    [cell setY_title:goodid[indexPath.row]];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSArray *goodid = [[NSUserDefaults standardUserDefaults] objectForKey:@"OrderSearchSave"];
    JXSearchResultsViewController *results = [JXSearchResultsViewController alloc];
    results.orederStr = goodid[indexPath.row];
    results.orderpaydelegte = self;
    [self.navigationController pushViewController:results animated:YES];
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return TableViewControllerCell_Height;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *header = [[UIView alloc] init]; //根据tyoe 创建 @"添加过的话题" 或 @"历史搜索";
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 17, NPWidth, 16)];
    [label setText:@"历史记录"];
    [header setBackgroundColor:[UIColor whiteColor]];
    [label setFont:[UIFont systemFontOfSize:16]];
    [header addSubview:label];
    return header;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 50;
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.searchBar resignFirstResponder];
}


- (UISearchBar *)searchBar {
    if (!_searchBar) { // 70 90
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width-90, 30)];
        _searchBar.delegate = self;
        _searchBar.placeholder = self.placeHolder;
        [_searchBar becomeFirstResponder];
        [self.searchBar setBarStyle:UIBarStyleBlackOpaque];// 搜索框样式
        [self.searchBar setSearchFieldBackgroundImage:[UIImage imageNamed:@"bg_sl"] forState:(UIControlStateNormal)];
        _searchBar.tintColor = [UIColor blackColor];
    }
    return _searchBar;
}


- (NSString *)placeHolder
{
    if (!_placeHolder) {
        _placeHolder = @"请输入商品名称";
    }
    return _placeHolder;
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
