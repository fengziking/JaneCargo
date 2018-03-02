//
//  JXChecklogisticssTableViewCell.m
//  JaneCargo
//
//  Created by 鹏 on 2017/8/11.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXChecklogisticssTableViewCell.h"


@interface JXChecklogisticssTableViewCell () {

    NSAttributedString*phoneNumber;
    
}

@property (weak, nonatomic) IBOutlet UIView *topLine;
@property (weak, nonatomic) IBOutlet UIView *bottomLine;
@property (weak, nonatomic) IBOutlet UIImageView *bigImage;
@property (weak, nonatomic) IBOutlet UIImageView *smallImage;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIView *line;

@end


@implementation JXChecklogisticssTableViewCell

+ (instancetype)cellWithTable {
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JXChecklogisticssTableViewCell class]) owner:self options:nil] lastObject];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    [self.topLine setBackgroundColor:kUIColorFromRGB(0xcccccc)];
    [self.bottomLine setBackgroundColor:kUIColorFromRGB(0xcccccc)];
    [self.line setBackgroundColor:kUIColorFromRGB(0xe3e3e3)];
    
    [self.contentLabel setTextColor:kUIColorFromRGB(0x999999)];
    [self.timeLabel setTextColor:kUIColorFromRGB(0x999999)];
    
}

- (void)changeTextColorAndImage {
    [self.smallImage setImage:[UIImage imageNamed:@""]];
    [self.bigImage setImage:[UIImage imageNamed:@"img_物流当前状态"]];
    [self.timeLabel setTextColor:kUIColorFromRGB(0xef5b4c)];
    [self.contentLabel setTextColor:kUIColorFromRGB(0xef5b4c)];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void)setHiddenLine:(BOOL)hiddenLine {

    [self.topLine setHidden:hiddenLine];
}

- (void)setModel:(JXHomepagModel *)model {
    _model = model;
    self.contentLabel.text = model.context;
    self.timeLabel.text = model.ftime;
    [self distinguishPhoneNumLabel:self.contentLabel labelStr:self.contentLabel.text];
    [self layoutIfNeeded];
    // 获取最后一个View的最低层Y值
    _model.cellHeight = CGRectGetMaxY(self.timeLabel.frame)+11;
}

-(void)distinguishPhoneNumLabel:(UILabel *)label labelStr:(NSString *)labelStr{
    
    //获取字符串中的电话号码
    NSString *regulaStr = @"\\d{3,4}[- ]?\\d{7,8}";
    NSRange stringRange = NSMakeRange(0, labelStr.length);
    //正则匹配
    NSError *error;
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:labelStr];
    NSRegularExpression *regexps = [NSRegularExpression regularExpressionWithPattern:regulaStr options:0 error:&error];
    if (!error && regexps != nil) {
        [regexps enumerateMatchesInString:labelStr options:0 range:stringRange usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
            
            NSRange phoneRange = result.range;
            //定义一个NSAttributedstring接受电话号码字符串
           phoneNumber = [str attributedSubstringFromRange:phoneRange];
            //添加下划线
            NSDictionary *attribtDic = @{NSUnderlineStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleNone]};
            [str addAttributes:attribtDic range:phoneRange];
            //设置文本中的电话号码显示为黄色
            [str addAttribute:NSForegroundColorAttributeName value:kUIColorFromRGB(0x0960cc) range:phoneRange];
            label.attributedText = str;
            label.userInteractionEnabled = YES;
            //添加手势，可以点击号码拨打电话
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture:)];
            
            [label addGestureRecognizer:tap];
        }];
    }
}

//实现拨打电话的方法
-(void)tapGesture:(UITapGestureRecognizer *)sender{
    
    NSString *deviceType = [UIDevice currentDevice].model;
    if([deviceType  isEqualToString:@"iPod touch"]||[deviceType  isEqualToString:@"iPad"]||[deviceType  isEqualToString:@"iPhone Simulator"]){
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"您的设备不能打电话" delegate:nil cancelButtonTitle:@"好的,知道了" otherButtonTitles:nil,nil];
        
        [alert show];
        
    }else{
        
        //NSAttributedstring转换为NSString
        NSString *stringNum = [phoneNumber string];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",stringNum]]];
    }
    
}














































@end
