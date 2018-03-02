//
//  JXWithdrawalZFCell.m
//  JaneCargo
//
//  Created by 鹏 on 2018/1/17.
//  Copyright © 2018年 鹏. All rights reserved.
//

#import "JXWithdrawalZFCell.h"

@interface JXWithdrawalZFCell()<UITextFieldDelegate>


@property (weak, nonatomic) IBOutlet UIView *bakcView;

// 支付宝
@property (weak, nonatomic) IBOutlet UIImageView *zfImage;
// 银行卡
@property (weak, nonatomic) IBOutlet UIImageView *bankImage;

@property (weak, nonatomic) IBOutlet UIView *lineColor;

// 姓名
@property (weak, nonatomic) IBOutlet UILabel *namelabel;
@property (weak, nonatomic) IBOutlet UITextField *nameTextfield;


// 支付账户
@property (weak, nonatomic) IBOutlet UILabel *zflabel;
@property (weak, nonatomic) IBOutlet UITextField *zfTextfield;

@property (weak, nonatomic) IBOutlet UIButton *confirmbt;

// 注
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;



@end


@implementation JXWithdrawalZFCell

+ (instancetype)cellwithTable {
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JXWithdrawalZFCell class]) owner:self options:nil] lastObject];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setBackgroundColor:kUIColorFromRGB(0xf1f1f1)];
    [self setSelectionStyle:(UITableViewCellSelectionStyleNone)];
    [_bakcView.layer setMasksToBounds:true];
    [_bakcView.layer setCornerRadius:5.0];
    [_nameTextfield.layer setBorderWidth:1.0];
    [_nameTextfield.layer setBorderColor:[kUIColorFromRGB(0xe3e3e3) CGColor]];
    [_zfTextfield.layer setBorderWidth:1.0];
    [_zfTextfield.layer setBorderColor:[kUIColorFromRGB(0xe3e3e3) CGColor]];
    [_lineColor setBackgroundColor:kUIColorFromRGB(0xe3e3e3)];
    [_titleLabel setTextColor:kUIColorFromRGB(0x999999)];
    [_confirmbt.layer setMasksToBounds:true];
    [_confirmbt.layer setCornerRadius:5.0];
    [_confirmbt.layer setBorderWidth:1.0];
    [_confirmbt.layer setBorderColor:[kUIColorFromRGB(0xe3e3e3) CGColor]];
    [_namelabel setTextColor:kUIColorFromRGB(0xff5335)];
    [_zflabel setTextColor:kUIColorFromRGB(0xff5335)];
    [JXContTextObjc changelabelColor:_namelabel range:NSMakeRange(0, 4) color:[UIColor blackColor]];
    [JXContTextObjc changelabelColor:_zflabel range:NSMakeRange(0, 5) color:[UIColor blackColor]];
    
    
    _nameTextfield.delegate = self;
    _zfTextfield.delegate = self;
    [self.nameTextfield addTarget:self action:@selector(nameTextField:) forControlEvents:UIControlEventEditingDidEnd];
    [self.zfTextfield addTarget:self action:@selector(zfnumTextField:) forControlEvents:UIControlEventEditingDidEnd];
    [self sethideKeyBoardAccessoryView];
}

- (void)nameTextField:(UITextField *)textField {
    
    _ZFname(textField.text);
    
}
- (void)zfnumTextField:(UITextField *)textField {
    
    _ZFnumber(textField.text);
    
}


- (IBAction)zfpay:(UIButton *)sender {
    _ChangPay(sender.tag);
}

- (IBAction)ylpay:(UIButton *)sender {
    _ChangPay(sender.tag);
}


- (IBAction)confirmAction:(UIButton *)sender {
    
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
    [doneBtn setTitle:@"完成" forState:(UIControlStateNormal)];
    [doneBtn setTitleColor:[UIColor colorWithRed:236/255.0 green:49/255.0 blue:88/255.0 alpha:1] forState:(UIControlStateNormal)];
    [doneBtn addTarget:self action:@selector(hideKeyboard) forControlEvents:(UIControlEventTouchUpInside)];
    [accessoryView addSubview:doneBtn];
    self.nameTextfield.inputAccessoryView = accessoryView;
    self.zfTextfield.inputAccessoryView = accessoryView;
    
}

- (void)hideKeyboard{
    
    [self.nameTextfield resignFirstResponder];
    [self.zfTextfield resignFirstResponder];
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
