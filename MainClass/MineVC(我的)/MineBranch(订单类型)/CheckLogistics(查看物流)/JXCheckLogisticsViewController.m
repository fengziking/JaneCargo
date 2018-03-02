//
//  JXCheckLogisticsViewController.m
//  JaneCargo
//
//  Created by 鹏 on 2017/8/11.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXCheckLogisticsViewController.h"
#import "JXChecklogisticsfTableViewCell.h"
#import "JXChecklogisticssTableViewCell.h"
@interface JXCheckLogisticsViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *checkTable;
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSMutableArray *dataArray;
// 服务端数据
@property (nonatomic, strong) NSMutableArray *logisticsArray;
// 倒序排序 获取快递的最新时间
@property (nonatomic, strong) NSMutableArray *sortingArray;


@end

@implementation JXCheckLogisticsViewController


- (NSArray *)titleArray {

    return @[@"物流名称：",@"运单编号："];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = @[].mutableCopy;
    self.logisticsArray = @[].mutableCopy;
    self.sortingArray = @[].mutableCopy;
    [self is_navigation];
    [self listtableView];
    [self y_dataRequest];
}

- (void)y_dataRequest {

    [JXNetworkRequest asynclogisticsExpress_number:_model.ordersn completed:^(NSDictionary *messagedic) {
        
       // 第一分区
        JXHomepagModel *model = [[JXHomepagModel alloc] init];
        [model setValuesForKeysWithDictionary:messagedic[@"info"]];
        [self.dataArray addObject:model];

        // 快递流程信息
        NSArray *dataArrays = messagedic[@"info"][@"data"];
        for (NSDictionary *dataDic in dataArrays) {
            JXHomepagModel *model = [[JXHomepagModel alloc] init];
            [model setValuesForKeysWithDictionary:dataDic];
            [self.logisticsArray addObject:model];
        }
        NSMutableArray *sortingTimeArray = [self processingTime:self.logisticsArray];
        for (NSString *sortinTime in sortingTimeArray) {
            
            for (JXHomepagModel *modelTime in self.logisticsArray) {
                if ([modelTime.ftime isEqualToString:sortinTime]) {
                    // 最终获取的排序数据
                    [self.sortingArray addObject:modelTime];
                }
            }
        }
        [self.checkTable reloadData];
    } statisticsFail:^(NSDictionary *messagedic) {
        
    } fail:^(NSError *error) {
        
    }];
}

#pragma mark -- 处理时间并排序
- (NSMutableArray *)processingTime:(NSMutableArray *)date {
    
    NSMutableArray *timeArray = @[].mutableCopy;
    for (JXHomepagModel *timemodel in date) {
        [timeArray addObject:timemodel.ftime];
    }
    // 排序
    [timeArray sortUsingFunction:dateSorts context:NULL];
    return timeArray;
}


NSInteger dateSorts(id dict1, id dict2, void* context){
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];
    NSDate *date1 = [formatter dateFromString:dict1];
    NSDate *date2 = [formatter dateFromString:dict2];
    return [date1 compare:date2];
}



- (void)listtableView {
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.checkTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, NPWidth, NPHeight-64)];
    self.checkTable.separatorStyle = UITableViewCellEditingStyleNone;
    self.checkTable.delegate = self;
    self.checkTable.dataSource = self;
    self.checkTable.backgroundColor = kUIColorFromRGB(0xf2f2f2);
    [self.checkTable setShowsVerticalScrollIndicator:NO];
    [self.view addSubview:self.checkTable];
}

- (void)is_navigation {
    
    UILabel * titleLabel =[[UILabel alloc]init];
    titleLabel.text = @"查看物流";
    [titleLabel sizeToFit];
    titleLabel.textColor = [UIColor blackColor];
    self.navigationItem.titleView = titleLabel;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_back"] style:(UIBarButtonItemStylePlain) target:self action:@selector(leftAction:)];
}
- (void)leftAction:(UIBarButtonItem *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if (self.sortingArray.count == 0) {
        return 0;
    }else {
        return 2;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 2;
    }else {
        return self.sortingArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0)
    {
        JXChecklogisticsfTableViewCell *cell = [JXChecklogisticsfTableViewCell cellWithTable];
        [cell setSelectionStyle:(UITableViewCellSelectionStyleNone)];
        [self setCellWith:cell indexPath:indexPath];
        return cell;
    }
    else
    {
        JXHomepagModel *model = self.sortingArray[indexPath.row];
        JXChecklogisticssTableViewCell *cell = [JXChecklogisticssTableViewCell cellWithTable];
        [cell setSelectionStyle:(UITableViewCellSelectionStyleNone)];
        if (indexPath.row == 0) {
            [cell setHiddenLine:YES];
            [cell changeTextColorAndImage];
        }
        [cell setModel:model];
        return cell;
    }
}

- (void)setCellWith:(JXChecklogisticsfTableViewCell *)cell indexPath:(NSIndexPath *)indexPath{
    
    if (self.dataArray.count >0) {
        JXHomepagModel *model = self.dataArray[0];
        [cell setTitle:self.titleArray[indexPath.row]];
        model.type_model = indexPath.row;
        [cell setModel:model];
    }
    
    
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        return TableViewControllerCell_Height;
    }else {
        JXHomepagModel *model = self.sortingArray[indexPath.row];
        return model.cellHeight;
    }
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
    // Dispose of any resources that can be recreated.
}


@end
