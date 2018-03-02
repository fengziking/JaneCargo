//
//  JXReasonRefundViewController.m
//  JaneCargo
//
//  Created by 鹏 on 2017/8/5.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXReasonRefundViewController.h"
#import "JXReasonRefundtableTableViewCell.h"
@interface JXReasonRefundViewController () <UITableViewDelegate,UITableViewDataSource>{

    UITableView *reasonRefundtable;
    NSInteger select_Image;
    NSString *selectTitle;
}

@property (nonatomic, strong) NSArray *notreceivingArry; // 未收货
@property (nonatomic, strong) NSArray *titleArray; // 退货

@end

@implementation JXReasonRefundViewController

- (NSArray *)notreceivingArry {
    return @[@"退款原因",@"不喜欢/不想要",@"空包裹",@"未按约定时间发货",@"快递/物流一直未送到",@"快递/物流无跟踪记录",@"其他"];
}
- (NSArray *)titleArray {
    return @[@"退款原因",@"退运费",@"大小/尺寸与商品描述不符",@"做工问题",@"有刺激性异味",@"少件/漏发",@"包装/商品破损",@"卖家发错货",@"发票问题",@"未按约定时间发货",@"其他"];
}



- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    selectTitle = _select_title;
    [self layoutTempTable];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    select_Image = 1;
    
    
}


- (void)layoutTempTable {
    CGFloat height;
    if (_retweetType == 0) {
        height = 44*7;
    }else {
        height = 44*11;
    }
    self.automaticallyAdjustsScrollViewInsets = NO;
    reasonRefundtable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, NPWidth-40, height)];
    reasonRefundtable.separatorStyle = UITableViewCellEditingStyleNone;
    reasonRefundtable.delegate = self;
    reasonRefundtable.dataSource = self;
    reasonRefundtable.backgroundColor = kUIColorFromRGB(0xf2f2f2);
    [reasonRefundtable setShowsVerticalScrollIndicator:NO];
    [self.view addSubview:reasonRefundtable];
    reasonRefundtable.scrollEnabled = NO;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (_retweetType == 0) {
        return [[self notreceivingArry] count];
    }else {
        return self.titleArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JXReasonRefundtableTableViewCell *cell = [JXReasonRefundtableTableViewCell cellWithTable];
    [cell setSelectionStyle:(UITableViewCellSelectionStyleNone)];
    NSString *title_type;
    if (self.retweetType == 0) {
        title_type = [self notreceivingArry][indexPath.row];
    }else {
        title_type = [self titleArray][indexPath.row];
    }
    if ([selectTitle isEqualToString:@"请选择退款原因"])
    {
        if (indexPath.row == 1)
        {
            [cell setSelect_image:@"icon_支付方式_选择"];
        }
        else
        {
            if (indexPath.row == 0)
            {
                [cell setSelect_image:@""];
            }
            else
            {
                [cell setSelect_image:@"icon_支付方式_未选择"];
            }
            
        }
    }
    else
    {
        
        
        
        if (indexPath.row != 0 && [selectTitle isEqualToString:title_type])
        {
            [cell setSelect_image:@"icon_支付方式_选择"];
        }
        else
        {
            if (indexPath.row == 0)
            {
                [cell setSelect_image:@""];
            }
            else
            {
                [cell setSelect_image:@"icon_支付方式_未选择"];
            }
        }
    }
    
    [cell setTitle:title_type];
    return cell;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return TableViewControllerCell_Height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        return;
    }
    NSString *title_type;
    if (self.retweetType == 0) {
        title_type = [self notreceivingArry][indexPath.row];
    }else {
        title_type = [self titleArray][indexPath.row];
    }
//    select_Image = indexPath.row;
    selectTitle = title_type;
    [reasonRefundtable reloadData];
    
    if ([_reasond_delegate respondsToSelector:@selector(reasonRefund_content:)]) {
        [_reasond_delegate reasonRefund_content:selectTitle];
    }
    
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
