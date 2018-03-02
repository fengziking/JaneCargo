//
//  JXWholesaleViewController.m
//  JaneCargo
//
//  Created by 鹏 on 2017/11/20.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXWholesaleViewController.h"
#import "JXWholesTableViewCell.h"
@interface JXWholesaleViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *wholesTable;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation JXWholesaleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = @[].mutableCopy;
    [self is_navigation];
    [self layoutTempTable];
    [self y_requestdata];
}


- (void)y_requestdata {
    
    [JXNetworkRequest asyncWholesalecompleted:^(NSDictionary *messagedic) {
        
        NSArray *infoarray = messagedic[@"info"];
        for (NSDictionary *infodic in infoarray) {
            JXHomepagModel *model = [[JXHomepagModel alloc] init];
            [model setValuesForKeysWithDictionary:infodic];
            [self.dataArray addObject:model];
        }
        [self.wholesTable reloadData];
    } statisticsFail:^(NSDictionary *messagedic) {
        
    } fail:^(NSError *error) {
        
    }];
}

- (void)layoutTempTable {
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.wholesTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, NPWidth, NPHeight)];
    self.wholesTable.separatorStyle = UITableViewCellEditingStyleNone;
    self.wholesTable.delegate = self;
    self.wholesTable.dataSource = self;
    self.wholesTable.backgroundColor = kUIColorFromRGB(0xf2f2f2);
    [self.wholesTable setShowsVerticalScrollIndicator:NO];
    [self.view addSubview:self.wholesTable];
    if (@available(iOS 11.0, *)) {
        self.wholesTable.contentInsetAdjustmentBehavior =UIScrollViewContentInsetAdjustmentNever;
        self.wholesTable.contentInset =UIEdgeInsetsMake(0,0,64,0);//64和49自己看效果，是否应该改成0
        self.wholesTable.scrollIndicatorInsets =self.wholesTable.contentInset;
    }
}

- (void)is_navigation {
    
    UILabel * titleLabel =[[UILabel alloc]init];
    titleLabel.text = @"批发商品";
    [titleLabel sizeToFit];
    titleLabel.textColor = [UIColor blackColor];
    self.navigationItem.titleView = titleLabel;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_back"] style:(UIBarButtonItemStylePlain) target:self action:@selector(leftAction:)];
}
- (void)leftAction:(UIBarButtonItem *)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JXWholesTableViewCell *cell = [JXWholesTableViewCell cellwhithTable];
    self.wholesTable.rowHeight = 125;
    if (self.dataArray.count >0) {
        JXHomepagModel *model = self.dataArray[indexPath.row];
        [cell setModel:model];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    JXHomepagModel *model = self.dataArray[indexPath.row];
    JXCompletedetailsViewController *jxorder = [[JXCompletedetailsViewController alloc] init];
    jxorder.goodsid = model.id;
    [self.navigationController pushViewController:jxorder animated:YES];
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
