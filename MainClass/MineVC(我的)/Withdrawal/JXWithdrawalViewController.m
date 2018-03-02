//
//  JXWithdrawalViewController.m
//  JaneCargo
//
//  Created by 鹏 on 2018/1/17.
//  Copyright © 2018年 鹏. All rights reserved.
//

#import "JXWithdrawalViewController.h"
#import "JXWithdrawalZFCell.h"
#import "JXWithdrawalZFPTableViewCell.h"
#import "JXWithdrawalBankFTableViewCell.h"
#import "JXWithdrawalBankTableViewCell.h"
#import "JXWithdrawalBankTableViewCell.h"
#import "JXWithdrawalMoneyTableViewCell.h"
#import "JXWithdrawalBtTableViewCell.h"
@interface JXWithdrawalViewController ()<UITableViewDataSource,UITableViewDelegate> {
    
    NSInteger is_pay; // 支付 0-支付 1-银联
    
    // 支付宝
    NSString *zf_name;
    NSString *zf_number;
    // 银行卡
    NSString *yh_name;
    NSString *yh_number;
    NSString *yh_bankname;
    
    NSString *withdrawal_money;
    
}
@property (nonatomic, strong) UITableView *manageTable;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation JXWithdrawalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"申请提现";
    self.dataArray = @[].mutableCopy;
    [self layoutTempTable];
    [self requestData];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_back"] style:(UIBarButtonItemStylePlain) target:self action:@selector(leftAction:)];
}

- (void)leftAction:(UIBarButtonItem *)sender {
    
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)requestData {
    
    [JXNetworkRequest asyncZfPaycompleted:^(NSDictionary *messagedic) {  // is_ali/is_bank  0未填写支付账户密码 1已填写
        
        JXHomepagModel *model = [[JXHomepagModel alloc] init];
        [model setValuesForKeysWithDictionary:messagedic[@"info"][@"info"]];
        [self.dataArray addObject:model];
        [_manageTable reloadData];
        
    } statisticsFail:^(NSDictionary *messagedic) {
        
    } fail:^(NSError *error) {
        
    }];
}


- (void)layoutTempTable {
    
     [self.view setBackgroundColor:kUIColorFromRGB(0xf1f1f1)];
    self.automaticallyAdjustsScrollViewInsets = NO;
    _manageTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, NPWidth, NPHeight)];
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
    // 3
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.section == 0) { // is_ali/is_bank  0未填写支付账户密码 1已填写
        
        JXHomepagModel *model;
        if (self.dataArray.count>0) {
            
            model = self.dataArray[0];
            if (is_pay == 0) { // 支付宝
                if ([[NSString stringWithFormat:@"%@",model.is_ali] isEqualToString:@"0"]) {
                    JXWithdrawalZFCell *cell = [JXWithdrawalZFCell cellwithTable];
                    [self zfpaycell:cell];
                    
                    return cell;
                }else {
                    JXWithdrawalZFPTableViewCell *cell = [JXWithdrawalZFPTableViewCell cellwithTable];
                    [cell setModel:model];
                    cell.ChangPay = ^(NSInteger tag) {
                        is_pay = tag;
                        [_manageTable reloadData];
                    };
                    return cell;
                    
                }
            }else { // 银联
                
                if ([[NSString stringWithFormat:@"%@",model.is_bank] isEqualToString:@"0"]) {
                    
                    JXWithdrawalBankFTableViewCell *cell = [JXWithdrawalBankFTableViewCell cellwithTable];
                    [self ylsetcell:cell];
                    return cell;
                    
                }else {
                    
                    JXWithdrawalBankTableViewCell *cell = [JXWithdrawalBankTableViewCell cellwithTable];
                    [cell setModel:model];
                    cell.ChangPay = ^(NSInteger tag) {
                        is_pay = tag;
                        [_manageTable reloadData];
                    };
                    return cell;
                }
            }
          
        }else { // 默认支付宝
            
            JXWithdrawalZFCell *cell = [JXWithdrawalZFCell cellwithTable];
            return cell;
        }
        
    }else if (indexPath.section == 1) {
        
        JXWithdrawalMoneyTableViewCell *cell = [JXWithdrawalMoneyTableViewCell cellwithTable];
        [self scopeofwithdrawal:cell];
        return cell;
    }
    else {
        
        JXWithdrawalBtTableViewCell *cell = [JXWithdrawalBtTableViewCell cellwithTable];
        cell.SubmitPay = ^{
            [self withdrawalAmount];
        };
        return cell;
    }
    
}

// 提现范围
- (void)scopeofwithdrawal:(JXWithdrawalMoneyTableViewCell *)cell {
    
    [cell setMoneytext:_withdrawalamount];
    cell.WithdrawalMoney = ^(NSString *money) {
        CGFloat moneyf = [money floatValue];
        CGFloat moneys = [_withdrawalamount floatValue];
        if (moneyf>moneys) {
            [self showHint:@"已超出提现范围"];
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:1];
            [_manageTable reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
        }else {
            withdrawal_money = money;
        }
    };
    
}

// 支付宝未填写资料
- (void)zfpaycell:(JXWithdrawalZFCell *)cell {
    
    
    cell.ChangPay = ^(NSInteger tag) {
        is_pay = tag;
        [_manageTable reloadData];
    };
    cell.ZFname = ^(NSString *name) {
        zf_name = name;
    };
    cell.ZFnumber = ^(NSString *number) {
        zf_number = number;
    };
    
}


// 银联未填写资料
- (void)ylsetcell:(JXWithdrawalBankFTableViewCell *)cell {
    
    cell.ChangPay = ^(NSInteger tag) {
        is_pay = tag;
        [_manageTable reloadData];
    };
    
    cell.ChangPayName = ^(NSString *name) {
        yh_name = name;
    };
    cell.ChangPayNumber = ^(NSString *number) {
        yh_number = number;
    };
    cell.ChangPayBank = ^(NSString *bank) {
        yh_bankname = bank;
    };
}

#pragma mark ---- 提交

- (void)withdrawalAmount {
    
    JXHomepagModel *model = _dataArray[0];
    if (is_pay == 0) { // 支付宝 1
        
        if ([[NSString stringWithFormat:@"%@",model.is_ali] isEqualToString:@"0"]) {  // 未填写 // model.realname model.alipay_no
            if (kStringIsEmpty(zf_name)) {
                [self showHint:@"请填写真实姓名"];
                return;
            }
            if (kStringIsEmpty(zf_number)) {
                [self showHint:@"请填写支付宝账号"];
                return;
            }
            if (kStringIsEmpty(withdrawal_money)) {
                [self showHint:@"请填写提现金额"];
                return;
            }
            [JXNetworkRequest asyncWithdrawalpay_type:@"1" realname:zf_name alipay_no:zf_number bank:nil bank_no:nil count_money:withdrawal_money completed:^(NSDictionary *messagedic) {
                [self showHint:@"提现成功"];
                [self.navigationController popViewControllerAnimated:NO];
            } statisticsFail:^(NSDictionary *messagedic) {
                
            } fail:^(NSError *error) {
                
            }];
            
            
        }else {
            
            if (kStringIsEmpty(withdrawal_money)) {
                [self showHint:@"请填写提现金额"];
                return;
            }
            [JXNetworkRequest asyncWithdrawalpay_type:@"1" realname:model.realname alipay_no:model.alipay_no bank:nil bank_no:nil count_money:withdrawal_money completed:^(NSDictionary *messagedic) {
                [self showHint:@"提现成功"];
                [self.navigationController popViewControllerAnimated:NO];
            } statisticsFail:^(NSDictionary *messagedic) {
                
            } fail:^(NSError *error) {
                
            }];
        }
        
    }else { // 银行卡 2
        
        if ([[NSString stringWithFormat:@"%@",model.is_bank] isEqualToString:@"0"]) { // 未填写
            
            if (kStringIsEmpty(yh_name)) {
                [self showHint:@"请填写持卡人姓名"];
                return;
            }
            if (kStringIsEmpty(yh_number)) {
                [self showHint:@"请填写银行卡号"];
                return;
            }
            if (kStringIsEmpty(yh_bankname)) {
                [self showHint:@"请填写开户银行名称"];
                return;
            }
            if (kStringIsEmpty(withdrawal_money)) {
                [self showHint:@"请填写提现金额"];
                return;
            }
            [JXNetworkRequest asyncWithdrawalpay_type:@"2" realname:yh_name alipay_no:nil bank:yh_bankname bank_no:yh_number count_money:withdrawal_money completed:^(NSDictionary *messagedic) {
                [self showHint:@"提现成功"];
                [self.navigationController popViewControllerAnimated:NO];
            } statisticsFail:^(NSDictionary *messagedic) {
                
            } fail:^(NSError *error) {
                
            }];
            
        }else {  
            
            if (kStringIsEmpty(withdrawal_money)) {
                [self showHint:@"请填写提现金额"];
                return;
            }
            [JXNetworkRequest asyncWithdrawalpay_type:@"2" realname:model.realname alipay_no:nil bank:model.bank bank_no:model.bank_no count_money:withdrawal_money completed:^(NSDictionary *messagedic) {
                [self showHint:@"提现成功"];
                [self.navigationController popViewControllerAnimated:NO];
            } statisticsFail:^(NSDictionary *messagedic) {
                
            } fail:^(NSError *error) {
                
            }];
        }
    }
    
}








































- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JXHomepagModel *model;
    if (indexPath.section == 0) {
        
        if (self.dataArray.count >0)
        {
            model = self.dataArray[0];
            if (is_pay == 0)
            { // 支付宝
                if ([[NSString stringWithFormat:@"%@",model.is_ali] isEqualToString:@"0"])
                {
                   return 285;
                }
                else
                {
                    return 132+30;
                 }
            }
            else
            { // 银联
                
                if ([[NSString stringWithFormat:@"%@",model.is_bank] isEqualToString:@"0"])
                {
                    return 360;
                }
                else
                {
                   return 153+30;
                }
            }
            
            
        }
        else
        {
            return 285+30;
        }

    }
    else if (indexPath.section == 1)
    {
        
        return 44;
    }
    else
    {
        return 75;
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
