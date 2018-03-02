//
//  JXAddressViewController.m
//  JaneCargo
//
//  Created by 鹏 on 2017/7/10.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXAddressViewController.h"
#import "JXAddressTableViewCell.h"
//#import "JXFillAddressViewController.h"
#import "JXFillNewAddressViewController.h"
@interface JXAddressViewController ()<UITableViewDelegate,UITableViewDataSource,SaveAddressDelegate> {
    
    UITableView *addressTable;
    BOOL is_dropdown;
}
// 记录当前选中的dot
@property (nonatomic, assign) NSInteger indexOfSelect;

@property (nonatomic, strong) NSMutableArray *dateArray;


@end

@implementation JXAddressViewController
static const CGFloat MJDuration = 0.5;
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [JXEncapSulationObjc blackNavigation:self color:[UIColor whiteColor]];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:kUIColorFromRGB(0xf2f2f2)];
    self.dateArray = @[].mutableCopy;
    
    [self requestDate];
    [self layoutTempTable];
    UILabel * titleLabel =[[UILabel alloc]init];
    titleLabel.text = @"地址管理";
    [titleLabel sizeToFit];
    titleLabel.textColor = [UIColor blackColor];
    self.navigationItem.titleView = titleLabel;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_back"] style:(UIBarButtonItemStylePlain) target:self action:@selector(leftAction:)];
}


- (void)requestDate {
    
    [JXNetworkRequest asyncAddressOftheUserCompleted:^(NSDictionary *messagedic) {
        NSMutableArray *selectArray = @[].mutableCopy;
        NSArray *infoArray = messagedic[@"info"];
        NSInteger is_defaultnumber = 0;
        for (NSDictionary *infodic in infoArray) {
            
            JXAddressModel *model = [[JXAddressModel alloc] init];
            [model setValuesForKeysWithDictionary:infodic];
            
            if ([infodic[@"is_default"] integerValue] == 1) {
                self.indexOfSelect = is_defaultnumber;
                // 保存默认地址
                [selectArray addObject:model];
                [JXUserDefaultsObjc storagedefault:infodic];
            }else {
                
                NSDictionary *modelArray = [JXUserDefaultsObjc defaultaddress];
                if ([modelArray[@"id"] isEqualToString:infodic[@"id"]]) {
                    // 删除地址（可能存在用户修改默认状态后还存在的状况）
                    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Defaultaddress"];
                }
                KDLOG(@"%@",modelArray);
                
            }
            is_defaultnumber++;
            [self.dateArray addObject:model];
        }
        [self endofthedropdown];
        [addressTable reloadData];
    } statisticsFail:^(NSDictionary *messagedic) {
        [self endofthedropdown];
        [self showHint:@"暂无地址信息"];
    } fail:^(NSError *error) {
        [self endofthedropdown];
    }];
    
}

#pragma mark -- 用户上传新地址代理
- (void)saveaddress {
    [self.dateArray removeAllObjects];
    [self requestDate];
}

- (void)layoutTempTable {
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    addressTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, NPWidth, NPHeight-50)];
    addressTable.separatorStyle = UITableViewCellEditingStyleNone;
    addressTable.delegate = self;
    addressTable.dataSource = self;
    addressTable.backgroundColor = kUIColorFromRGB(0xf2f2f2);
    [addressTable setShowsVerticalScrollIndicator:NO];
    [self.view addSubview:addressTable];
    if (@available(iOS 11.0, *)) {
        addressTable.contentInsetAdjustmentBehavior =UIScrollViewContentInsetAdjustmentNever;
        addressTable.contentInset = UIEdgeInsetsMake(0,0,0,0);//64和49自己看效果，是否应该改成0
        addressTable.scrollIndicatorInsets = addressTable.contentInset;
    }
    UIButton *addAddress = [[UIButton alloc] initWithFrame:CGRectMake(0, NPHeight-50, NPWidth, 50)];
    [addAddress addTarget:self action:@selector(addAddressAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [addAddress setTitle:@"+ 新增地址" forState:(UIControlStateNormal)];
    [addAddress setBackgroundColor:kUIColorFromRGB(0xe82b48)];
    [self.view addSubview:addAddress];
    
}

#pragma mark -- 添加新地址
- (void)addAddressAction:(UIButton *)sender {

    [self editorFillControllerTyep_str:nil model:nil];
}


#pragma mark --- 跳转编辑 填写地址页面
- (void)editorFillControllerTyep_str:(NSString *)type_str model:(JXAddressModel*)model{

    JXFillNewAddressViewController *add = [[JXFillNewAddressViewController alloc] init];
    add.saveaddressdelegate = self;
    add.editor_str = type_str;
    add.model =  model;
    [self.navigationController pushViewController:add animated:YES];
}



- (void)leftAction:(UIBarButtonItem *)sender {
    
    
    
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [self.dateArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    JXAddressTableViewCell *cell = [JXAddressTableViewCell cellWithTable];
    [cell setSelectionStyle:(UITableViewCellSelectionStyleNone)];
    [self iconSelectStrat:cell indexPath:indexPath];
    // 编辑删除
    [self deleteaddress:cell];
    return cell;
}
// 图片选中状态
- (void)iconSelectStrat:(JXAddressTableViewCell*)cell indexPath:(NSIndexPath *)indexPath {

    [cell setAddressbtTag:indexPath.section];
    
    JXAddressModel *model = self.dateArray[indexPath.section];
    
    [cell setModel:model];
    
    cell.select = ^(NSInteger tag) {
        _indexOfSelect = tag;
        [addressTable reloadData];
    };
    
    if (_addressid == nil) { // 没值的情况
        if (_indexOfSelect == indexPath.section) {
            [cell setSelectImageStr:@"icon_选中"];
        }
    }else { // 有值
    
        if ([[NSString stringWithFormat:@"%@",model.id] isEqualToString:_addressid]) {
            _addressid = nil;
            _indexOfSelect = indexPath.section;
            if (_indexOfSelect == indexPath.section) {
                [cell setSelectImageStr:@"icon_选中"];
            }
        }else {
            if (_indexOfSelect == indexPath.section) {
                [cell setSelectImageStr:@"icon_未选中"];
            }
        }
    }
  
}


- (void)deleteaddress:(JXAddressTableViewCell*)cell {

    cell.editordelete = ^(NSString *start, NSInteger tag,JXAddressModel *model) {
        if ([start isEqualToString:@"编辑"])
        {
            [self editorFillControllerTyep_str:start model:model];
        }
        else if ([start isEqualToString:@"删除"])
        {
            [JXEncapSulationObjc choseAlerController:self alerTitle:@"温馨提示" contentTitle:@"是否删除" cancel:@"取消" confirm:@"确认" block:^(id responseCode) {
                
            } choseBlock:^(id choesbk) {
                // 删除地址
                [JXNetworkRequest asyncDeletetheAddressadress_id:[NSString stringWithFormat:@"%@",model.id] completed:^(NSDictionary *messagedic) {
                    // 删除地址
                    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Defaultaddress"];
                    [self showHint:@"删除成功"];
                } statisticsFail:^(NSDictionary *messagedic) {
                    [self showHint:messagedic[@"msg"]];
                } fail:^(NSError *error) {
                    
                }];
                // 删除数据源
                [self.dateArray removeObjectAtIndex:tag];
                [addressTable reloadData];
            }];
        }
    };
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    _indexOfSelect = indexPath.section;
//    [addressTable reloadData];
    if (self.dateArray.count>0) {
        JXAddressModel *model = self.dateArray[_indexOfSelect];
        //        _SelectaddressBlock(model);
        if ([_selectdelegate respondsToSelector:@selector(selectaddressModel:)]) {
            [_selectdelegate selectaddressModel:model];
        }
    }
    if (![_typeaddres isEqualToString:@"1"]) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 90+TableViewControllerCell_Height;
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

#pragma mark --
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat contentOffset = scrollView.contentOffset.y;
    if (!is_dropdown && contentOffset < -60) {
        is_dropdown = YES;
        [self s_dropdownMJRefresh];
    }
}

#pragma mark UITableView + 下拉刷新 默认
- (void)s_dropdownMJRefresh { // dropdown
    __unsafe_unretained __typeof(self) weakSelf = self;
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    addressTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadNewData];
    }];
    // 马上进入刷新状态
    [addressTable.mj_header beginRefreshing];
}

- (void)loadNewData {
    
    [self.dateArray removeAllObjects];
    // 刷新过程中停止交互
    addressTable.scrollEnabled = NO;
    // 直接控制下拉时间避免等待时间过长
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(MJDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self requestDate];
    });
}
#pragma mark -- 下拉结束
- (void)endofthedropdown {
    // 拿到当前的下拉刷新控件，结束刷新状态
    [addressTable.mj_header endRefreshing];
    addressTable.scrollEnabled = YES;
}



@end
