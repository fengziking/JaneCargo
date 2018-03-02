//
//  JXAddRemoveTableViewCell.m
//  JaneCargo
//
//  Created by 鹏 on 2017/9/12.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXAddRemoveTableViewCell.h"
@interface JXAddRemoveTableViewCell()

@property (weak, nonatomic) IBOutlet UIButton *reductionbt;

@property (weak, nonatomic) IBOutlet UIButton *increasebt;

@property (weak, nonatomic) IBOutlet UILabel *goodsNumber;

@end
@implementation JXAddRemoveTableViewCell


+ (instancetype)cellWithTable {
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JXAddRemoveTableViewCell class]) owner:self options:nil] lastObject];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    KDLOG(@"%@",_goodnumberTf.text);
     _goodnumberTf.textAlignment = NSTextAlignmentCenter;
    [self sethideKeyBoardAccessoryView];
    [self setSelectionStyle:(UITableViewCellSelectionStyleNone)];
}

- (IBAction)reductionAction:(UIButton *)sender {
    
    _increse(sender.tag);
    
}

- (IBAction)increaseAction:(UIButton *)sender {
    
    _increse(sender.tag);
}

- (void)setGood_number:(NSString *)good_number {
    
    self.goodsNumber.text = good_number;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
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
    self.goodnumberTf.inputAccessoryView = accessoryView;
   
    
}

- (void)hideKeyboard{
    _completeblock();
    [self.goodnumberTf resignFirstResponder];
}


@end
