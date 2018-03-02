//
//  JXManagementViewController.m
//  JaneCargo
//
//  Created by 鹏 on 2018/1/17.
//  Copyright © 2018年 鹏. All rights reserved.
//

#import "JXManagementViewController.h"
#import "JXManagementTableViewCell.h"
// 自定义导航
#import "DCHoverNavView.h"
#import "JXWithdrawalViewController.h"
@interface JXManagementViewController ()<UITableViewDataSource,UITableViewDelegate> {
    
    
    NSString *txmoney;
    
}
@property (nonatomic, strong) UITableView *manageTable;
// 自定义导航
@property (strong , nonatomic)DCHoverNavView *hoverNavView;


@property (weak, nonatomic) IBOutlet UIView *backview;
@property (weak, nonatomic) IBOutlet UILabel *titleview;
@property (weak, nonatomic) IBOutlet UILabel *priceView;
@property (weak, nonatomic) IBOutlet UIButton *pricebt;
@property (weak, nonatomic) IBOutlet UILabel *lastpricelabel;

@property (weak, nonatomic) IBOutlet UIView *topline;
@property (weak, nonatomic) IBOutlet UIView *botline;

@property (weak, nonatomic) IBOutlet UILabel *pricelabel;
@property (weak, nonatomic) IBOutlet UILabel *lasprice;


@property (weak, nonatomic) IBOutlet UIView *colorview;
@property (weak, nonatomic) IBOutlet UIView *seccolor;


@property (nonatomic, strong) NSMutableArray *dataArray;


@end

@implementation JXManagementViewController

#pragma mark - LifeCyle
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}
#pragma mark - 导航栏
- (void)setUpNav {
    
    _hoverNavView = [[DCHoverNavView alloc] init];
    _hoverNavView.titleLabel.text = @"资金管理";
    [self.view insertSubview:_hoverNavView atIndex:1];
    _hoverNavView.frame = CGRectMake(0, 0, NPWidth, 64);
    __weak typeof(self)weakSelf = self;
    
    [_hoverNavView leftAndrightImageleft:@"icon_后退_白色" right:@""];
    _hoverNavView.leftItemClickBlock = ^{
        [weakSelf settingItemClick];
    };
    _hoverNavView.rightItemClickBlock = ^{
        [weakSelf messageItemClick];
    };
    _hoverNavView.rightTitle = @"提现说明";
    [self.view addSubview:_hoverNavView];
}

#pragma mark - 设置
- (void)settingItemClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 提现说明
- (void)messageItemClick {
    
   
    
}
// 提现
- (IBAction)pricebtAction:(UIButton *)sender {
    
    JXWithdrawalViewController *jxdraw = [[JXWithdrawalViewController alloc] init];
    jxdraw.withdrawalamount = txmoney;
    [self.navigationController pushViewController:jxdraw animated:NO];
    
}

- (IBAction)fibtAction:(UIButton *)sender {
    
    [_pricelabel setTextColor:kUIColorFromRGB(0xff5335)];
    [_lasprice setTextColor:kUIColorFromRGB(0x999999)];
    [_colorview setBackgroundColor:kUIColorFromRGB(0xff5335)];
    [_seccolor setBackgroundColor:[UIColor clearColor]];
    [self.dataArray removeAllObjects];
    [self requestDataWithdrawal];
    
}

- (IBAction)secbtAction:(UIButton *)sender {
    
    [_pricelabel setTextColor:kUIColorFromRGB(0x999999)];
    [_lasprice setTextColor:kUIColorFromRGB(0xff5335)];
    [_colorview setBackgroundColor:[UIColor clearColor]];
    [_seccolor setBackgroundColor:kUIColorFromRGB(0xff5335)];
    [self.dataArray removeAllObjects];
    [self requestStrandedgold];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = @[].mutableCopy;
    [self setUpNav];
    [self layoutTempTable];
    [self managemHeadview];
    [self requestDataWithdrawal];
    
}

- (void)managemHeadview {
    [self.view setBackgroundColor:kUIColorFromRGB(0xf1f1f1)];
    
    [_backview setBackgroundColor:kUIColorFromRGB(0xef5b4c)];
    [_titleview setTextColor:kUIColorFromRGB(0xff8694)];
    [_pricebt.layer setMasksToBounds:true];
    [_pricebt.layer setCornerRadius:2.0];
    [_pricebt.layer setBorderWidth:1.0];
    [_pricebt.layer setBorderColor:[[UIColor whiteColor] CGColor]];
    [_topline setBackgroundColor:kUIColorFromRGB(0xe3e3e3)];
    [_botline setBackgroundColor:kUIColorFromRGB(0xe3e3e3)];
    [JXContTextObjc changelabelColor:_lastpricelabel range:NSMakeRange(0, 5) color:kUIColorFromRGB(0xff8694)];
    [_pricelabel setTextColor:kUIColorFromRGB(0xff5335)];
    [_lasprice setTextColor:kUIColorFromRGB(0x999999)];
    
    [_colorview setBackgroundColor:kUIColorFromRGB(0xff5335)];
    
}


- (void)requestDataWithdrawal {
    
    [JXNetworkRequest asyncWithdrawalcompleted:^(NSDictionary *messagedic) { // 3-支出   4   0 在处理
        
        
        _priceView.text = messagedic[@"info"][@"info"][@"money"];
        _lastpricelabel.text = [NSString stringWithFormat:@"剩余滞留金：¥ %@",messagedic[@"info"][@"info"][@"zlj_money"]];
        txmoney = messagedic[@"info"][@"info"][@"money"];
        [JXContTextObjc changelabelColor:_lastpricelabel range:NSMakeRange(0, 6) color:kUIColorFromRGB(0xff8694)];
        for (NSDictionary *rsdic in messagedic[@"info"][@"rs"]) {
            JXHomepagModel *model = [[JXHomepagModel alloc] init];
            [model setValuesForKeysWithDictionary:rsdic];
            [self.dataArray addObject:model];
        }
        [self.manageTable reloadData];
        
    } statisticsFail:^(NSDictionary *messagedic) {
        
    } fail:^(NSError *error) {
        
    }];
    
}

- (void)requestStrandedgold {
    
    [JXNetworkRequest asyncStrandedgoldcompleted:^(NSDictionary *messagedic) {
        for (NSDictionary *rsdic in messagedic[@"info"][@"rs"]) {
            JXHomepagModel *model = [[JXHomepagModel alloc] init];
            [model setValuesForKeysWithDictionary:rsdic];
            [self.dataArray addObject:model];
        }
        [self.manageTable reloadData];
    } statisticsFail:^(NSDictionary *messagedic) {
        
    } fail:^(NSError *error) {
        
    }];
    
}
                                                                                                

- (void)layoutTempTable {
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    _manageTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 199+55, NPWidth, NPHeight-55-199)];
    _manageTable.separatorStyle = UITableViewCellEditingStyleNone;
    _manageTable.delegate = self;
    _manageTable.dataSource = self;
    _manageTable.backgroundColor = kUIColorFromRGB(0xf2f2f2);
    [_manageTable setShowsVerticalScrollIndicator:NO];
    [self.view addSubview:_manageTable];
    if (@available(iOS 11.0, *)) {
        _manageTable.contentInsetAdjustmentBehavior =UIScrollViewContentInsetAdjustmentNever;
        _manageTable.contentInset =UIEdgeInsetsMake(0,0,64,0);//64和49自己看效果，是否应该改成0
        _manageTable.scrollIndicatorInsets =_manageTable.contentInset;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JXManagementTableViewCell *cell = [JXManagementTableViewCell cellwithTable];
    _manageTable.rowHeight = 60;
    if (self.dataArray.count >0) {
        JXHomepagModel *model = self.dataArray[indexPath.row];
        [cell setModel:model];
    }
    return cell;
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
