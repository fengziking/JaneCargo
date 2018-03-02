//
//  JXCourierNumberViewController.m
//  JaneCargo
//
//  Created by 鹏 on 2017/10/11.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXCourierNumberViewController.h"
#import "JXCourierTableController.h"
@interface JXCourierNumberViewController ()<UITextFieldDelegate,CourierDelegate> {

    NSString *nameCourier;
    NSString *numberCourier;
}

@property (weak, nonatomic) IBOutlet UIButton *submitbt;
//@property (weak, nonatomic) IBOutlet UITextField *nameTextfiled;
@property (weak, nonatomic) IBOutlet UITextField *numberTextfield;

@property (weak, nonatomic) IBOutlet UIButton *namebt;

@property (weak, nonatomic) IBOutlet UIView *line;

// 遮罩
@property (nonatomic, strong) ShowMaskView *showmask;
@property (nonatomic, strong) JXCourierTableController *courierTable;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation JXCourierNumberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = @[].mutableCopy;
    [self y_navigation];
    [self y_dataRequest];
}

- (void)y_dataRequest {
    
    [JXNetworkRequest asyncCouriercompleted:^(NSDictionary *messagedic) {
        
        for (NSDictionary *dic in messagedic[@"info"]) {
            JXHomepagModel *model = [[JXHomepagModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [self.dataArray addObject:model];
        }
        
        
    } statisticsFail:^(NSDictionary *messagedic) {
        
    } fail:^(NSError *error) {
        
    }];
}


- (IBAction)submitAtion:(UIButton *)sender {
    
    if (kStringIsEmpty(nameCourier)){
        [self showHint:@"请输入快递名称"];
        return;
    }
    if (kStringIsEmpty(numberCourier)) {
        [self showHint:@"请输入快递单号"];
        return;
    }
    [JXNetworkRequest asyncCourierNumberordersn:_model.ordersn ex_num:nameCourier ex_name:numberCourier completed:^(NSDictionary *messagedic) {
        [self showHint:@"提交成功"];
        [self.navigationController popViewControllerAnimated:YES];
    } statisticsFail:^(NSDictionary *messagedic) {
        [self showHint:@"提交失败"];
    } fail:^(NSError *error) {
        
    }];
}




- (IBAction)namebt:(UIButton *)sender {
    
    self.showmask = [ShowMaskView showMaskViewWith:^{
    }];
    [[[UIApplication  sharedApplication] keyWindow] addSubview:self.showmask];
    [self hidenoRshow];
    
    CGFloat couriHeight = 44*self.dataArray.count;
    
    self.courierTable = [[JXCourierTableController alloc] init];
    [self.courierTable.view setFrame:CGRectMake(40, (NPHeight-couriHeight)/2, NPWidth-(40*2), couriHeight)];
    self.courierTable.dateArray = [NSArray arrayWithArray:self.dataArray];
    self.courierTable.courierdelegate= self;
    [self.showmask addSubview:self.courierTable.view];
}

- (void)y_navigation {

    
    [self.line setBackgroundColor:kUIColorFromRGB(0xe3e3e3)];
    UILabel * titleLabel =[[UILabel alloc]init];
    titleLabel.text = @"填写快递单号";
    [titleLabel sizeToFit];
    titleLabel.textColor = [UIColor blackColor];
    self.navigationItem.titleView = titleLabel;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_back"] style:(UIBarButtonItemStylePlain) target:self action:@selector(leftAction:)];
    
    [self.submitbt setEnabled:NO];
    [self.submitbt setBackgroundColor:kUIColorFromRGB(0xcccccc)];
    [self.submitbt.layer setMasksToBounds:YES];
    [self.submitbt.layer setCornerRadius:2.0f];
    
//    self.nameTextfiled.delegate = self;
    self.numberTextfield.delegate = self;
    self.numberTextfield.keyboardType = UIKeyboardTypeASCIICapableNumberPad;
//    [self.nameTextfiled addTarget:self action:@selector(nameTextfiled:) forControlEvents:UIControlEventEditingDidBegin];
    [self.numberTextfield addTarget:self action:@selector(numberTextfield:) forControlEvents:UIControlEventEditingChanged];
    [self sethideKeyBoardAccessoryView];
    
    
}
// 代理
- (void)courier:(NSString *)courier coureName:(NSString *)name{
    
    [self.showmask removeFromSuperview];
    nameCourier = courier;
    [_namebt setTitle:name forState:(UIControlStateNormal)];
    [_namebt setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [self hidenoRshow];
}

//- (void)nameTextfiled:(UITextField *)textField  {
//
//    self.showmask = [ShowMaskView showMaskViewWith:^{
//
//    }];
//    [[[UIApplication  sharedApplication] keyWindow] addSubview:self.showmask];
//
//    [self hideKeyboard];
//}
- (void)numberTextfield:(UITextField *)textField  {
    
    numberCourier = textField.text;
    [self hidenoRshow];
}

- (void)hidenoRshow {
    
    if (!kStringIsEmpty(nameCourier)&&!kStringIsEmpty(numberCourier)) {
        [self.submitbt setEnabled:YES];
        [self.submitbt setBackgroundColor:kUIColorFromRGB(0xe82b48)];
    }else {
        [self.submitbt setEnabled:NO];
        [self.submitbt setBackgroundColor:kUIColorFromRGB(0xcccccc)];
    }
    
}



- (void)leftAction:(UIBarButtonItem *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark --- 当用户全部清空的时候的时候 会调用
-(BOOL)textFieldShouldClear:(UITextField *)textField {
    
    return true;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    
    
}


/**
 *  键盘添加完成按钮
 */
- (void)sethideKeyBoardAccessoryView{
    UIView *accessoryView = [[UIView alloc]init];
    accessoryView.frame = CGRectMake(0, 0, NPWidth, 30);
    accessoryView.backgroundColor = [UIColor colorWithWhite:0.900 alpha:1];
    UIButton *doneBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    doneBtn.frame = CGRectMake(CGRectGetMaxX(accessoryView.bounds) - 50, CGRectGetMinY(accessoryView.bounds), 40,30);
    //    doneBtn.backgroundColor = [UIColor grayColor];
    [doneBtn setTitle:@"完成" forState:(UIControlStateNormal)];
    [doneBtn setTitleColor:[UIColor colorWithRed:236/255.0 green:49/255.0 blue:88/255.0 alpha:1] forState:(UIControlStateNormal)];
    [doneBtn addTarget:self action:@selector(hideKeyboard) forControlEvents:(UIControlEventTouchUpInside)];
    [accessoryView addSubview:doneBtn];
//    self.nameTextfiled.inputAccessoryView = accessoryView;
    self.numberTextfield.inputAccessoryView = accessoryView;
}

- (void)hideKeyboard{
//    [self.nameTextfiled resignFirstResponder];
    [self.numberTextfield resignFirstResponder];
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
