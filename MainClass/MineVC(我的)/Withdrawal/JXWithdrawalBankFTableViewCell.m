//
//  JXWithdrawalBankFTableViewCell.m
//  JaneCargo
//
//  Created by 鹏 on 2018/1/17.
//  Copyright © 2018年 鹏. All rights reserved.
//

#import "JXWithdrawalBankFTableViewCell.h"

@interface JXWithdrawalBankFTableViewCell()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *backvIEW;

@property (weak, nonatomic) IBOutlet UIImageView *zfImage;
@property (weak, nonatomic) IBOutlet UIImageView *bankImage;
@property (weak, nonatomic) IBOutlet UIView *lineColor;

@property (weak, nonatomic) IBOutlet UILabel *namelabel;
@property (weak, nonatomic) IBOutlet UITextField *nameTextfield;
@property (weak, nonatomic) IBOutlet UILabel *bankNumberlabel;
@property (weak, nonatomic) IBOutlet UITextField *banknumberTextfield;
@property (weak, nonatomic) IBOutlet UILabel *banklabel;
@property (weak, nonatomic) IBOutlet UITextField *bankTextfield;

@property (weak, nonatomic) IBOutlet UILabel *titlelabel;


@property (weak, nonatomic) IBOutlet UIButton *confirmbt;



@end


@implementation JXWithdrawalBankFTableViewCell


+ (instancetype)cellwithTable {
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JXWithdrawalBankFTableViewCell class]) owner:self options:nil] lastObject];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [_backvIEW.layer setMasksToBounds:true];
    [_backvIEW.layer setCornerRadius:5.0];
    [self setBackgroundColor:kUIColorFromRGB(0xf1f1f1)];
    [self setSelectionStyle:(UITableViewCellSelectionStyleNone)];
     [_lineColor setBackgroundColor:kUIColorFromRGB(0xe3e3e3)];
    [_titlelabel setTextColor:kUIColorFromRGB(0x999999)];
    
    [_nameTextfield.layer setBorderWidth:1.0];
    [_nameTextfield.layer setBorderColor:[kUIColorFromRGB(0xe3e3e3) CGColor]];
    [_banknumberTextfield.layer setBorderWidth:1.0];
    [_banknumberTextfield.layer setBorderColor:[kUIColorFromRGB(0xe3e3e3) CGColor]];
    [_bankTextfield.layer setBorderWidth:1.0];
    [_bankTextfield.layer setBorderColor:[kUIColorFromRGB(0xe3e3e3) CGColor]];
    
    [_confirmbt.layer setMasksToBounds:true];
    [_confirmbt.layer setCornerRadius:5.0];
    [_confirmbt.layer setBorderWidth:1.0];
    [_confirmbt.layer setBorderColor:[kUIColorFromRGB(0xe3e3e3) CGColor]];
    
    
    [_namelabel setTextColor:kUIColorFromRGB(0xff5335)];
    [_bankNumberlabel setTextColor:kUIColorFromRGB(0xff5335)];
    [_banklabel setTextColor:kUIColorFromRGB(0xff5335)];
    [JXContTextObjc changelabelColor:_namelabel range:NSMakeRange(0, 5) color:[UIColor blackColor]];
    [JXContTextObjc changelabelColor:_bankNumberlabel range:NSMakeRange(0, 5) color:[UIColor blackColor]];
    [JXContTextObjc changelabelColor:_banklabel range:NSMakeRange(0, 4) color:[UIColor blackColor]];
    
    _nameTextfield.delegate = self;
    _banknumberTextfield.delegate = self;
    _bankTextfield.delegate = self;
    self.banknumberTextfield.keyboardType = UIKeyboardTypeASCIICapableNumberPad;
    [self.nameTextfield addTarget:self action:@selector(nameTextField:) forControlEvents:UIControlEventEditingDidEnd];
    [self.banknumberTextfield addTarget:self action:@selector(banknumTextField:) forControlEvents:UIControlEventEditingDidEnd];
    [self.bankTextfield addTarget:self action:@selector(bankTextField:) forControlEvents:UIControlEventEditingDidEnd];
    [self sethideKeyBoardAccessoryView];
}


- (void)nameTextField:(UITextField *)textField {
    
    _ChangPayName(textField.text);
    
}
- (void)banknumTextField:(UITextField *)textField {
    
    _ChangPayNumber(textField.text);
    
}
- (void)bankTextField:(UITextField *)textField {
    
    _ChangPayBank(textField.text);
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
    self.banknumberTextfield.inputAccessoryView = accessoryView;
    self.bankTextfield.inputAccessoryView = accessoryView;
}

- (void)hideKeyboard{
    
    [self.nameTextfield resignFirstResponder];
    [self.banknumberTextfield resignFirstResponder];
    [self.bankTextfield resignFirstResponder];
}


- (IBAction)zfpay:(UIButton *)sender {
    _ChangPay(sender.tag);
}

- (IBAction)ylpay:(UIButton *)sender {
    _ChangPay(sender.tag);
}





- (IBAction)confirmAction:(UIButton *)sender {
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
