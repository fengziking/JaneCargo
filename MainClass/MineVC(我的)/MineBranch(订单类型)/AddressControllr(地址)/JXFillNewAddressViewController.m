//
//  JXFillNewAddressViewController.m
//  JaneCargo
//
//  Created by cxy on 2017/7/11.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXFillNewAddressViewController.h"
#import "BLAreaPickerView.h"



@interface JXFillNewAddressViewController ()<UITextFieldDelegate,BLPickerViewDelegate,UITextViewDelegate> {

    // 详细地址
    NSString *detailed_Address;
    // 是否默认地址
    NSString *is_default;
    //  人名
    NSString *perName;
    // 手机号码
    NSString *photo_str;
    // 省
    NSString *province_str;
    // 市
    NSString *city_str;
    // 区
    NSString *area_str;
    
}

@property (weak, nonatomic) IBOutlet UITextField *recipientTextField;

@property (weak, nonatomic) IBOutlet UITextField *photoTextField;
// 区域
@property (weak, nonatomic) IBOutlet UIButton *areaButton;

@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

//@property (weak, nonatomic) IBOutlet UITextView *detaileTextView;
//@property (weak, nonatomic) IBOutlet UILabel *detaileLabel;

//@property (weak, nonatomic) IBOutlet UITextField *detaileTextField;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;
@property (weak, nonatomic) IBOutlet UILabel *s_placeholder;
@property (weak, nonatomic) IBOutlet UISwitch *closeSwitch;
@property (weak, nonatomic) IBOutlet UIView *linef;
@property (weak, nonatomic) IBOutlet UIView *lines;
@property (weak, nonatomic) IBOutlet UIView *linet;
@property (weak, nonatomic) IBOutlet UIView *linefo;

@end

@implementation JXFillNewAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 默认关闭
//    is_default = @"0";
    [self toDealwith];
    [self aboutNavigation];
    [self aboutAddressLay];
}

- (void)aboutNavigation {
    UILabel * titleLabel =[[UILabel alloc]init];
    titleLabel.text = @"地址";
    [titleLabel sizeToFit];
    titleLabel.textColor = [UIColor blackColor];
    self.navigationItem.titleView = titleLabel;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_back"] style:(UIBarButtonItemStylePlain) target:self action:@selector(leftAction:)];
    
    UIButton *rightlabel = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [rightlabel.titleLabel setFont:[UIFont systemFontOfSize:16.0f]];
    [rightlabel setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [rightlabel setTitle:@"保存" forState:(UIControlStateNormal)];
    [rightlabel addTarget:self action:@selector(rightAction:) forControlEvents:(UIControlEventTouchUpInside)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightlabel];
    
    if ([_model.is_default integerValue] == 1) { // [infodic[@"is_default"] integerValue] == 1
        is_default = @"1";
    }else {
        is_default = @"0";
        
    }
    
}

- (void)toDealwith {

    //  显示数据
    if ([_editor_str isEqualToString:@"编辑"])
    {
        _recipientTextField.text = _model.name;
        _photoTextField.text = _model.phone;
        NSString*prostr= [self procitycount:_model.s_province];
        NSString*citystr= [self procitycount:_model.s_city];
        NSString*countystr= [self procitycount:_model.s_county];
        _addressLabel.text = [NSString stringWithFormat:@"%@%@%@",prostr,citystr,countystr];
        _contentTextView.text = _model.address;
        if ([_model.is_default integerValue] == 1) {
            _closeSwitch.on = YES;
        }
        perName = _model.name;
        photo_str = _model.phone;
        province_str = prostr;
        city_str = citystr;
        area_str = countystr;
        detailed_Address = _model.address;
        [self.s_placeholder setText:@""];
    }else {
        [self.s_placeholder setText:@"请在下方输入详细地址"];
    }
}

- (NSString *)procitycount:(NSString *)prostr {
    
    if (kStringIsEmpty(prostr)) {
        return @"";
    }else {
        return prostr;
    }
}

- (void)leftAction:(UIBarButtonItem *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}
// 点击保存
- (void)rightAction:(UIButton *)sender {
    
    
    if (!kStringIsEmpty(perName)&&!kStringIsEmpty(photo_str)&&!kStringIsEmpty(detailed_Address)&&!kStringIsEmpty(province_str)) {
        
        if ([_editor_str isEqualToString:@"编辑"])
        { // 编辑状态
            [JXNetworkRequest asyncEditorAddressIs_default:is_default address_id:[NSString stringWithFormat:@"%@",_model.id] name:perName phone:photo_str address:detailed_Address s_province:province_str s_city:city_str s_county:area_str completed:^(NSDictionary *messagedic) {
                [self showHint:@"修改成功"];
                if ([_saveaddressdelegate respondsToSelector:@selector(saveaddress)]) {
                    [_saveaddressdelegate saveaddress];
                }
                [self.navigationController popViewControllerAnimated:YES];
            } statisticsFail:^(NSDictionary *messagedic) {
                [self showHint:messagedic[@"msg"]];
            } fail:^(NSError *error) {
                
            }];
        }
        else
        {
            // 上传
            [JXNetworkRequest asyncAddtheAddressIs_default:is_default name:perName phone:photo_str address:detailed_Address s_province:province_str s_city:city_str s_county:area_str completed:^(NSDictionary *messagedic) {
                
                [self showHint:@"保存成功"];
                if ([_saveaddressdelegate respondsToSelector:@selector(saveaddress)]) {
                    [_saveaddressdelegate saveaddress];
                }
                [self.navigationController popViewControllerAnimated:YES];
            } statisticsFail:^(NSDictionary *messagedic) {
                [self showHint:messagedic[@"msg"]];
                
            } fail:^(NSError *error) {
                
            }];
        }

    }else {
        
        [self hideKeyboard];
        if (kStringIsEmpty(perName)) {
            [self showHint:@"请填写收件人名"];
            return;
        }
        if (kStringIsEmpty(photo_str)) {
            [self showHint:@"请填写手机号码"];
            return;
        }
        if (kStringIsEmpty(province_str)) {
            [self showHint:@"请选择省市地址"];
            return;
        }
        if (kStringIsEmpty(detailed_Address)) {
            [self showHint:@"请填写详细地址"];
            return;
        }
    }
}

- (void)aboutAddressLay {
    
    self.view.backgroundColor = kUIColorFromRGB(0xf2f2f2);
    _recipientTextField.delegate = self;
    _photoTextField.delegate = self;
    _contentTextView.delegate = self;
    
    [self.addressLabel setTextColor:kUIColorFromRGB(0xbbbbbb)];
    [self.contentTextView setTextColor:kUIColorFromRGB(0xbbbbbb)];
    [self.s_placeholder setTextColor:kUIColorFromRGB(0xbbbbbb)];
    [_linef setBackgroundColor:kUIColorFromRGB(0xcccccc)];
    [_lines setBackgroundColor:kUIColorFromRGB(0xcccccc)];
    [_linet setBackgroundColor:kUIColorFromRGB(0xcccccc)];
    [_linefo setBackgroundColor:kUIColorFromRGB(0xcccccc)];
    
    self.photoTextField.keyboardType = UIKeyboardTypeASCIICapableNumberPad;
    
    
    [self.recipientTextField addTarget:self action:@selector(nameTextField:) forControlEvents:UIControlEventEditingDidEnd];
    [self.photoTextField addTarget:self action:@selector(idCardTextField:) forControlEvents:UIControlEventEditingDidEnd];
    
    
    [self sethideKeyBoardAccessoryView];
}

- (void)nameTextField:(UITextField *)textField {
    
    if (![RegularExpressionsBySyc deptIdInputShouldAlphaNumcharacters:textField.text]) {
        perName = @"";
        self.recipientTextField.text = @"";
    }else { //
        if (textField.text.length>10) {
            [self showHint:@"名称长度不可超过10位"];
            return;
        }
        perName = textField.text;
    }
}

- (void)idCardTextField:(UITextField *)textField {
    
    if (![JXRegular validateMobile:textField.text]) {
        photo_str = @"";
        [self showHint:@"请填写正确手机号码"];
    }else { //
        photo_str = textField.text;
    }
}

#pragma mark --- textView代理
//将要开始编辑
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    [self.s_placeholder setText:@""];
    return YES;
}

//将要结束编辑
- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    if (textView.text.length == 0) {
        [self.s_placeholder setText:@"请在下方输入详细地址"];
    }
    return YES;
}
//内容将要发生改变编辑
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    return YES;
}
//内容发生改变编辑
- (void)textViewDidChange:(UITextView *)textView {
    
    detailed_Address = textView.text;
}


#pragma marl ---- 选择区域 开关按钮

- (IBAction)areaAction:(UIButton *)sender {
    
    [self hideKeyboard];
    BLAreaPickerView * arecpick = [[BLAreaPickerView alloc] initWithFrame:CGRectMake(0, 0, NPWidth, 264* NPWidth/375.0)];
    arecpick.pickViewDelegate = self;
    arecpick.topViewBackgroundColor = kUIColorFromRGB(0xf3f3f3);
    arecpick.pickViewBackgroundColor = [UIColor whiteColor];
    [arecpick bl_show];
    
}

// 确定按钮点击回调
- (void)bl_selectedAreaResultWithProvince:(NSString *)provinceTitle
                                     city:(NSString *)cityTitle
                                     area:(NSString *)areaTitle {
    province_str = provinceTitle;
    city_str = cityTitle;
    if (areaTitle!=nil) {
        area_str = areaTitle;
    }else {
        area_str = @"";
    }
    [_addressLabel setText:[NSString stringWithFormat:@"%@%@%@",provinceTitle,cityTitle,area_str]];
    [_addressLabel setTextColor:[UIColor blackColor]];
}

// 取消按钮点击回调
- (void)bl_cancelButtonClicked {

    
}



- (IBAction)closeAction:(UISwitch *)sender {
    
    BOOL closes = sender.on;
    if (closes) {
        
        is_default = @"1";
    }else {
        is_default = @"0";
    }
    
}

#pragma mark --- 当用户全部清空的时候的时候 会调用
-(BOOL)textFieldShouldClear:(UITextField *)textField {
    
    return true;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    return YES;
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
    self.recipientTextField.inputAccessoryView = accessoryView;
    self.photoTextField.inputAccessoryView = accessoryView;
    self.contentTextView.inputAccessoryView = accessoryView;
}

- (void)hideKeyboard{
    [self.recipientTextField resignFirstResponder];
    [self.photoTextField resignFirstResponder];
    [self.contentTextView resignFirstResponder];
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
