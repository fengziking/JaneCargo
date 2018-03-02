//
//  JXGenderTableViewController.m
//  JaneCargo
//
//  Created by cxy on 2017/7/6.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXGenderTableViewController.h"
#import "JXGenderTableViewCell.h"
@interface JXGenderTableViewController () {

    NSInteger sexNumber;
    NSInteger sexNum_record;

}
@property (nonatomic, assign)NSInteger indexPath;
@end

@implementation JXGenderTableViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [JXEncapSulationObjc blackNavigation:self color:[UIColor whiteColor]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel * titleLabel =[[UILabel alloc]init];
    titleLabel.text = @"选择性别";
    [titleLabel sizeToFit];
    titleLabel.textColor = [UIColor blackColor];
    self.navigationItem.titleView = titleLabel;
    self.automaticallyAdjustsScrollViewInsets = YES;
    self.tableView.scrollEnabled = NO;

    [self.tableView setBackgroundColor:kUIColorFromRGB(0xf2f2f2)];
    self.tableView.separatorStyle = UITableViewCellEditingStyleNone;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_back"] style:(UIBarButtonItemStylePlain) target:self action:@selector(leftAction:)];
    sexNumber = _sexNum;
    sexNum_record = _sexNum;
//    if (@available(iOS 11.0, *)) {
//        self.tableView.contentInsetAdjustmentBehavior =UIScrollViewContentInsetAdjustmentNever;
//        self.tableView.contentInset =UIEdgeInsetsMake(0,0,0,0);//64和49自己看效果，是否应该改成0
//        self.tableView.scrollIndicatorInsets =self.tableView.contentInset;
//    }
}

- (void)leftAction:(UIBarButtonItem *)sender {
    
    if (sexNum_record != sexNumber) {
        [JXNetworkRequest asyncsave_info:@"1" value:[NSString stringWithFormat:@"%ld",sexNumber] completed:^(NSDictionary *messagedic) {
            [self showHint:messagedic[@"msg"]];
        } statisticsFail:^(NSDictionary *messagedic) {
            [self showHint:messagedic[@"msg"]];
        } fail:^(NSError *error) {
            
        }];
    }
    
//    
//    if ([self.genderdelegate respondsToSelector:@selector(returnGender:sex:)]) {
//        [self.genderdelegate returnGender:self sex:sexNumber];
//    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.section == 0) {
        JXGenderTableViewCell *cell = [JXGenderTableViewCell cellWithTable];
        // icon_选择
        if (sexNumber == 1) {
            [cell.iconImage setImage:[UIImage imageNamed:@"icon_选择"]];
        }else {
            [cell.iconImage setImage:[UIImage imageNamed:@""]];
        }
        
        [self.tableView setRowHeight:TableViewControllerCell_Height];
        [cell setTitle:@"男"];
        return cell;
        
    }else {
        
        JXGenderTableViewCell *cell = [JXGenderTableViewCell cellWithTable];
        [cell setHiddenLine:YES];
        if (sexNumber == 2) {
            [cell.iconImage setImage:[UIImage imageNamed:@"icon_选择"]];
        }else {
            [cell.iconImage setImage:[UIImage imageNamed:@""]];
        }
        [self.tableView setRowHeight:TableViewControllerCell_Height];
        [cell setTitle:@"女"];
        return cell;
    }
    
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) { // 1男2女
        sexNumber = 1;
    }else {
        sexNumber = 2;
    }
    [self.tableView reloadData];
}




- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        return 10;
    }
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, NPWidth, 10)];
    return view;
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
