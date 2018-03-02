//
//  JXPushMessageViewController.m
//  JaneCargo
//
//  Created by 鹏 on 2017/8/21.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXPushMessageViewController.h"
#import "JXMessageTableViewCell.h"
#import "JXActivityMessageTableViewCell.h"
#import "JXWebPushViewController.h"
#import "JXNoContentTableViewCell.h"
@interface JXPushMessageViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *pushMesssageTable;
@property (nonatomic, strong) NSMutableArray *dataArray;
// 倒序排序 获取最新时间
@property (nonatomic, strong) NSMutableArray *sortingArray;
@end

@implementation JXPushMessageViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [JXEncapSulationObjc blackNavigation:self color:[UIColor whiteColor]];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = @[].mutableCopy;
    self.sortingArray = @[].mutableCopy;
    [self.view setBackgroundColor:kUIColorFromRGB(0xf2f2f2)];
    [self y_navigation];
    [self layoutTempTable];
    [self y_data];
}

- (void)y_data {
    
    [JXNetworkRequest asyncPushmessagecompleted:^(NSDictionary *messagedic) {
        for (NSDictionary *infodic in messagedic[@"info"]) {
            JXHomepagModel *model = [[JXHomepagModel alloc] init];
            [model setValuesForKeysWithDictionary:infodic];
            [self.dataArray addObject:model];
        }
        NSMutableArray *sortingTimeArray = [self processingTime:self.dataArray];
        for (NSString *sortinTime in sortingTimeArray) {
            
            for (JXHomepagModel *modelTime in self.dataArray) {
                if ([modelTime.create_time isEqualToString:sortinTime]) {
                    // 最终获取的排序数据
                    [self.sortingArray addObject:modelTime];
                }
            }
        }
        [self.pushMesssageTable reloadData];
    } statisticsFail:^(NSDictionary *messagedic) {
        
    } fail:^(NSError *error) {
        
    }];
}

#pragma mark -- 处理时间并排序
- (NSMutableArray *)processingTime:(NSMutableArray *)date {
    
    NSMutableArray *timeArray = @[].mutableCopy;
    for (JXHomepagModel *timemodel in date) {
        [timeArray addObject:timemodel.create_time];
    }
    // 排序
    [timeArray sortUsingFunction:dateSort context:NULL];
    return timeArray;
}

NSInteger dateSort(id dict1, id dict2, void* context){
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date1 = [formatter dateFromString:dict1];
    NSDate *date2 = [formatter dateFromString:dict2];
    return [date2 compare:date1];
}

- (void)y_navigation {
    
    UILabel * titleLabel =[[UILabel alloc]init];
    titleLabel.text = @"消息中心";
    [titleLabel sizeToFit];
    titleLabel.textColor = [UIColor blackColor];
    self.navigationItem.titleView = titleLabel;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_back"] style:(UIBarButtonItemStylePlain) target:self action:@selector(leftAction:)];
    
}
- (void)leftAction:(UIBarButtonItem *)sender {
    
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)layoutTempTable {
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.pushMesssageTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, NPWidth, NPHeight-64)];
    self.pushMesssageTable.separatorStyle = UITableViewCellEditingStyleNone;
    self.pushMesssageTable.delegate = self;
    self.pushMesssageTable.dataSource = self;
    self.pushMesssageTable.backgroundColor = kUIColorFromRGB(0xf2f2f2);
    [self.pushMesssageTable setShowsVerticalScrollIndicator:NO];
    [self.view addSubview:self.pushMesssageTable];
    if (@available(iOS 11.0, *)) {
        self.pushMesssageTable.contentInsetAdjustmentBehavior =UIScrollViewContentInsetAdjustmentNever;
        self.pushMesssageTable.contentInset =UIEdgeInsetsMake(0,0,0,0);//64和49自己看效果，是否应该改成0
        self.pushMesssageTable.scrollIndicatorInsets =self.pushMesssageTable.contentInset;
    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    if (self.dataArray.count == 0) {
        return 1;
    }else {
        return self.sortingArray.count;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.dataArray.count == 0) {
        
        JXNoContentTableViewCell *cell = [JXNoContentTableViewCell cellWithTable];
        [cell setSelectionStyle:(UITableViewCellSelectionStyleNone)];
        self.pushMesssageTable.scrollEnabled = NO;
        return cell;
        
    }else {
        
        self.pushMesssageTable.scrollEnabled = YES;
        JXHomepagModel *model = self.sortingArray[indexPath.section];
        if ([[NSString stringWithFormat:@"%@",model.stat] isEqualToString:@"2"]) {
            JXActivityMessageTableViewCell *cell = [JXActivityMessageTableViewCell cellwithTable];
            [cell setBackgroundColor:kUIColorFromRGB(0xf2f2f2)];
            cell.WebJumpblock = ^(JXHomepagModel *model) {
                NSString *url = model.url;
                JXWebPushViewController *web = [[JXWebPushViewController alloc] init];
                web.web_url = url;
                [self.navigationController pushViewController:web animated:YES];
            };
            [cell setModel:model];
            return cell;
        }else {
            JXMessageTableViewCell *cell = [JXMessageTableViewCell cellwithTable];
            [cell setBackgroundColor:kUIColorFromRGB(0xf2f2f2)];
            [cell setModel:model];
            return cell;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.dataArray.count == 0) {
        return self.view.frame.size.height-64;
    }else {
        JXHomepagModel *model = self.sortingArray[indexPath.section];
        if ([[NSString stringWithFormat:@"%@",model.stat] isEqualToString:@"2"]){
            return 307;
        }else {
            return 166;
        }
    }
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
