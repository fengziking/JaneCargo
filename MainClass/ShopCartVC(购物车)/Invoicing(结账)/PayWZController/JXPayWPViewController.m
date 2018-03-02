//
//  JXPayWPViewController.m
//  JaneCargo
//
//  Created by 鹏 on 2017/8/1.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXPayWPViewController.h"
#import "JXPayWPTableViewCell.h"
@interface JXPayWPViewController ()<UITableViewDelegate,UITableViewDataSource,PaydotDelegate>


@property (nonatomic, strong) UITableView *payTable;
@property (nonatomic, strong) NSMutableArray *dateArray;
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSArray *imgArray;

// 记录当前选中的dot
@property (nonatomic, assign) NSInteger indexOfSelect;

@end

@implementation JXPayWPViewController

- (NSArray *)titleArray {
    return @[@"支付宝",@"微信支付"];
}
- (NSArray *)imgArray {
    return @[@"icon_支付宝",@"icon_微信支付"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.dateArray = @[].mutableCopy;
    
    if ([_pay_str isEqualToString:@"支付宝"]) {
        _indexOfSelect = 0;
    }else {
        _indexOfSelect = 1;
    }
    
    
    [self navigation];
    [self processTheData];
    [self aboutInvoicingTable];
    
    
    
}
- (void)navigation{
    
    UILabel * titleLabel =[[UILabel alloc]init];
    titleLabel.text = @"支付方式";
    [titleLabel sizeToFit];
    titleLabel.textColor = [UIColor blackColor];
    self.navigationItem.titleView = titleLabel;
    self.automaticallyAdjustsScrollViewInsets = YES;
    [self.view setBackgroundColor:kUIColorFromRGB(0xf2f2f2)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_back"] style:(UIBarButtonItemStylePlain) target:self action:@selector(leftAction:)];
}

- (void)leftAction:(UIBarButtonItem *)sender {
    
    if ([_paymentdelegate respondsToSelector:@selector(payment:)]) {
        [_paymentdelegate payment:[self titleArray][self.indexOfSelect]];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)processTheData {
    
    for (int i = 0; i<self.titleArray.count; i++) {
        JXHomepagModel *model = [[JXHomepagModel alloc] init];
        model.name = self.titleArray[i];
        model.img = self.imgArray[i];
        model.buy_num = [NSNumber numberWithInt:i];
        if (i == 0) {
            model.isSelects = YES;
        }
        [self.dateArray addObject:model];
    }
    [self.payTable reloadData];
}

- (void)aboutInvoicingTable {
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.payTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
    self.payTable.delegate = self;
    self.payTable.dataSource = self;
    self.payTable.backgroundColor = kUIColorFromRGB(0xf2f2f2);
    self.payTable.showsVerticalScrollIndicator = NO;
    self.payTable.separatorStyle = UITableViewCellEditingStyleNone;
    [self.view addSubview:self.payTable];
    self.payTable.scrollEnabled = NO;
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dateArray.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JXHomepagModel *model;
    JXPayWPTableViewCell *cell = [JXPayWPTableViewCell cellWithTable];
    [cell setSelectionStyle:(UITableViewCellSelectionStyleNone)];
    cell.paydotdelegate = self;
    if (_indexOfSelect == indexPath.row) {
        [cell setSelectImageStr:@"icon_选中"];
    }
    if (self.dateArray.count>0)
    {
        model = self.dateArray[indexPath.row];
        [cell setModel:model];
    }
    
    return cell;
    
}
- (void)payDotTag:(NSInteger)tag {
    _indexOfSelect = tag;
    [self.payTable reloadData];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    _indexOfSelect = indexPath.row;
    [self.payTable reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, NPWidth, 10)];
    return view;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
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
