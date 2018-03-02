//
//  JXDetailUnderView.m
//  JaneCargo
//
//  Created by 鹏 on 2017/9/12.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXDetailUnderView.h"


static NSString *const identifier  = @"cell";

@interface JXDetailUnderView ()

@end

@implementation JXDetailUnderView

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpLable];
    [self createMainTableView];
    
}

- (void)setUpLable {
    
    
}

- (void)createMainTableView{
    
    self.productParameterTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, NPWidth, NPHeight-64) style:UITableViewStylePlain];
    self.productParameterTable.delegate =self;
    self.productParameterTable.dataSource =self;
    self.productParameterTable.rowHeight = UITableViewAutomaticDimension;
    self.productParameterTable.separatorStyle = UITableViewCellEditingStyleNone;
    [self.view addSubview:self.productParameterTable];
    
    self.headLabel = [[UILabel alloc]init];
    self.headLabel.textAlignment = NSTextAlignmentCenter;
    self.headLabel.frame = CGRectMake(0, 64, CGRectGetWidth([UIScreen mainScreen].bounds), 60);
    self.headLabel.font = [UIFont systemFontOfSize:16.0f];
    [self.headLabel setTextColor:kUIColorFromRGB(0x999999)];
    [self.view addSubview:self.headLabel];
    [self.headLabel bringSubviewToFront:self.view];
}


#pragma mark -<UITableViewDelegate,UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:0 reuseIdentifier:identifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"商品%ld号",indexPath.row];
    return cell;
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
