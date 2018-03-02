//
//  JXParameterViewController.m
//  JaneCargo
//
//  Created by 鹏 on 2017/7/18.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXParameterViewController.h"
#import "JXParameterTableViewCell.h"
@interface JXParameterViewController ()<UITableViewDelegate,UITableViewDataSource> {

    UITableView *parameterTable;
}
@property (nonatomic, strong) NSArray *nameArray;
@end

@implementation JXParameterViewController


- (NSArray *)nameArray {
    
    return @[@"品牌",@"产地",@"规格",@"保质期",@"特产品类",@"储藏方法"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setFrame:CGRectMake(NPWidth, 0, NPWidth, NPHeight)];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self layoutTempTable];
}


- (void)layoutTempTable {
    
    parameterTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, NPWidth, NPHeight)];
    parameterTable.separatorStyle = UITableViewCellEditingStyleNone;
    parameterTable.delegate = self;
    parameterTable.dataSource = self;
    parameterTable.scrollEnabled = NO;
    parameterTable.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:parameterTable];
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.goodparameterArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    JXHomepagModel *model = _goodparameterArray[indexPath.row];
    JXParameterTableViewCell *cell = [JXParameterTableViewCell cellWithTable];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    parameterTable.rowHeight = 40;
    [cell setModel:model];
    return cell;
}

@end
