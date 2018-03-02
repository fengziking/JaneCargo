//
//  JXEvaluationViewController.m
//  Evaluation
//
//  Created by 鹏 on 2017/9/14.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXEvaluationViewController.h"
#import "EvaluationOrderCell.h"
#import "EvaluationServiceCell.h"
#import "EvaluationGoodCell.h"
#import "GoodstartTableViewCell.h"
#import "ContentStartTableViewCell.h"
#import "EvaluationSubmitCell.h"
@interface JXEvaluationViewController () <UITableViewDataSource,UITableViewDelegate,RefreshTextFieldDelegate,SubmitEvaluationDelegate> {

    NSInteger serviceEvaluation;
    NSInteger expressEvaluation;

}

@property (nonatomic, strong) UITableView *evaluationTable;
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSMutableArray *goodsArray;
@property (nonatomic, strong) NSMutableDictionary *textFielddic;
@property (nonatomic, strong) NSMutableDictionary *stratdic;
@end

@implementation JXEvaluationViewController


- (NSArray *)titleArray {
    
    return @[@"服务评星 *",@"物流评星 *"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.goodsArray = @[].mutableCopy;
    self.textFielddic = @{}.mutableCopy;
    self.stratdic = @{}.mutableCopy;
    [self y_Navigation];
    [self y_dataRequest];
    [self createMainTableView];
}

- (void)y_dataRequest {
    
    NSArray *cartArray = _model.cart;
    for (MKGoodsModel *model in cartArray) {
        [self.goodsArray addObject:model];
    }
}

- (void)evaluation {

    NSString *orderNumber = _model.ordersn;
    NSString *arr = nil;
    if (serviceEvaluation>0 && expressEvaluation>0) {
        arr = [NSString stringWithFormat:@"%ld,%ld",(long)serviceEvaluation,(long)expressEvaluation];
    }else {
        if (serviceEvaluation<=0) {
            [self showHint:@"请对服务进行评价"];
            return;
        }
        if (expressEvaluation<=0) {
            [self showHint:@"请对快递进行评价"];
            return;
        }
    }
    NSMutableArray *uploadArray = @[].mutableCopy;
    if (self.stratdic.count>0) {
        // 循环取值
        for (int i = 0; i<self.goodsArray.count; i++) {
            
            NSString *text = [self.textFielddic objectForKey:@(3+i)];
            NSString *strat = [self.stratdic objectForKey:@(3+i)];
            NSString *upload;
            if (!kStringIsEmpty(text)) {
                upload = [NSString stringWithFormat:@"%@&%@",strat,text];
            }else {
                upload = [NSString stringWithFormat:@"%@",strat];
            }
            
            [uploadArray addObject:upload];
        }
    }else {
        [self showHint:@"请对商品星级进行评价"];
        return;
    }
    // 拼接的字符串
    NSMutableString *together = @"".mutableCopy;
    NSString *constr;
    for (NSString *strs in uploadArray) {
        [together appendString:[NSString stringWithFormat:@"-%@",strs]];
    }
    constr = [NSString stringWithString:together];
    
    [JXNetworkRequest asyncEvaluationOrdersn:orderNumber arr:arr con:constr completed:^(NSDictionary *messagedic) {
        [self showHint:@"评价成功"];
        [self.navigationController popViewControllerAnimated:YES];
    } statisticsFail:^(NSDictionary *messagedic) {
        [self showHint:messagedic[@"msg"]];
    } fail:^(NSError *error) {
        
    }];
}



- (void)y_Navigation {

    UILabel * titleLabel =[[UILabel alloc]init];
    titleLabel.text = @"评论商品";
    [titleLabel sizeToFit];
    titleLabel.textColor = [UIColor blackColor];
    self.navigationItem.titleView = titleLabel;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_back"] style:(UIBarButtonItemStylePlain) target:self action:@selector(leftAction:)];

}

- (void)leftAction:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)rightAction:(UIBarButtonItem *)sender {
    
    if ([_evaluatdelegate respondsToSelector:@selector(evaluationGoodStart)]) {
        [_evaluatdelegate evaluationGoodStart];
    }
}

- (void)createMainTableView{
    
    self.evaluationTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    self.evaluationTable.delegate =self;
    self.evaluationTable.dataSource =self;
    self.evaluationTable.rowHeight = UITableViewAutomaticDimension;
    self.evaluationTable.separatorStyle = UITableViewCellEditingStyleNone;
    [self.evaluationTable setBackgroundColor:kUIColorFromRGB(0xf1f1f1)];
    [self.evaluationTable registerClass:[UITableViewCell class] forCellReuseIdentifier:@"pros"];
    [self.view addSubview:self.evaluationTable];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4+self.goodsArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else if (section == 1) {
        return 2;
    }else if (section == 2) {
        return 1;
    }else if (section == 3+self.goodsArray.count){
        return 1;
    }
    else {
        return 3;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0)
    {
        EvaluationOrderCell *cell = [EvaluationOrderCell cellWithTable];
        [cell setTitle:@"订单号"];
        [cell setModel:_model];
        return cell;
    }
    else if (indexPath.section == 1)
    {
        EvaluationServiceCell *cell = [EvaluationServiceCell cellWithTable];
        [cell setTitle:self.titleArray[indexPath.row]];
        if (indexPath.row == 0) {
            [cell changestratType:serviceEvaluation];
        }else if (indexPath.row == 1) {
            [cell changestratType:expressEvaluation];
        }
        cell.EvaluationStrat = ^(NSInteger startNumber,MKGoodsModel *model) {
            if (indexPath.row == 0) {
                serviceEvaluation = startNumber;
            }else if (indexPath.row == 1) {
                expressEvaluation = startNumber;
            }
            
        };
        
        
        return cell;
    }
    else if (indexPath.section == 2)
    {
        GoodstartTableViewCell *cell = [GoodstartTableViewCell cellWithTable];
        return cell;
    }
    else if (indexPath.section == 3+self.goodsArray.count)
    {
        EvaluationSubmitCell *cell = [EvaluationSubmitCell cellWithTable];
        cell.subitdelegate = self;
        return cell;
    }
    else
    {
        
        if (indexPath.row == 0)
        {
            EvaluationGoodCell *cell = [EvaluationGoodCell cellWithTable];
            cell.model = self.goodsArray[indexPath.section-3];
            return cell;
        }
        else if (indexPath.row == 1)
        {
            
            EvaluationServiceCell *cell = [EvaluationServiceCell cellWithTable];
            cell.model = self.goodsArray[indexPath.section-3];
            [cell setTitle:@"星级评价 *"];
            cell.EvaluationStrat = ^(NSInteger startNumber,MKGoodsModel *model) {// 记录商品评价
                NSString *strat = [NSString stringWithFormat:@"%@&%ld",model.good_id,startNumber];
                [self.stratdic setObject:strat forKey:@(indexPath.section)];
            };
            return cell;
        }
        else
        {
            ContentStartTableViewCell *cell = [ContentStartTableViewCell cellWithTable];
            cell.refreshdelegate = self;
            [cell setIndexPath:indexPath];
            NSString *textField = [self.textFielddic objectForKey:@(indexPath.section)];
            [cell setContentText:textField];
            return cell;
        }
    }
}

- (void)submit {

    [self evaluation];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}

// 点击textfield代理
- (void)completeInput {
    [self.evaluationTable setContentOffset:CGPointMake(0, 0) animated:YES];
    
}
- (void)startTypingToEvaluate {
    
    [self.evaluationTable setContentOffset:CGPointMake(0, 158) animated:YES];
}
- (void)refreshtextFieldIndex:(NSIndexPath *)indexPath text:(NSString *)text{

    [self.textFielddic setObject:text forKey:@(indexPath.section)];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0)
    {
        return 44;
    }
    else if (indexPath.section == 1)
    {
        return 44;
    }
    else if (indexPath.section == 2)
    {
        return 44;
    }
    else if (indexPath.section == 3+self.goodsArray.count)
    {
        return 79;
    }
    else
    {
        if (indexPath.row == 0)
        {
            return 85;
        }
        else if (indexPath.row == 1)
        {
            return 44;
        }
        else
        {
            return 120;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section!=0 && section!=1 && section!=2 && section!=3 && section!= 3+self.goodsArray.count) {
        return 15;
    }else {
        return 0;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    CGFloat width;
    if (section!=0 && section!=1 && section!=2 && section!=3 && section!= 3+self.goodsArray.count) {
        width= 15;
    }else {
        width= 0;
    }
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, NPWidth, width)];
    return view;
    
}
@end
