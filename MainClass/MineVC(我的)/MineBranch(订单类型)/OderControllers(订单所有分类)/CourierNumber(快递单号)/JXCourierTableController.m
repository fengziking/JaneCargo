//
//  JXCourierTableController.m
//  JaneCargo
//
//  Created by 鹏 on 2017/10/25.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXCourierTableController.h"
#import "JXCourierCell.h"
@interface JXCourierTableController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *courierTable;


@end

@implementation JXCourierTableController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view.layer setMasksToBounds:true];
    [self.view.layer setCornerRadius:5.0];
    [self y_courierTable];
}

- (void)y_courierTable {
    
    self.courierTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, NPWidth, NPHeight)];
    self.courierTable.separatorStyle = UITableViewCellEditingStyleNone;
    self.courierTable.delegate = self;
    self.courierTable.dataSource = self;
    self.courierTable.backgroundColor = kUIColorFromRGB(0xf2f2f2);
    [self.courierTable setShowsVerticalScrollIndicator:NO];
    [self.view addSubview:self.courierTable ];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return _dateArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JXCourierCell *cell = [JXCourierCell cellWithTable];
    if (self.dateArray.count>0) {
        cell.model = self.dateArray[indexPath.section];
    }
    self.courierTable.rowHeight = 44;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    JXHomepagModel *model = self.dateArray[indexPath.section];
    if ([_courierdelegate respondsToSelector:@selector(courier:coureName:)]) {
        [_courierdelegate courier:model.exbs coureName:[NSString stringWithFormat:@"%@快递",model.exname]];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
