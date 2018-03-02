//
//  EvaluationServiceCell.m
//  Evaluation
//
//  Created by 鹏 on 2017/9/14.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "EvaluationServiceCell.h"

@interface EvaluationServiceCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *evaluationLabel;

@property (weak, nonatomic) IBOutlet UIButton *fbt;
@property (weak, nonatomic) IBOutlet UIButton *sbt;
@property (weak, nonatomic) IBOutlet UIButton *tbt;
@property (weak, nonatomic) IBOutlet UIButton *fobt;
@property (weak, nonatomic) IBOutlet UIButton *fibt;

@end


@implementation EvaluationServiceCell

+ (instancetype)cellWithTable {
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([EvaluationServiceCell class]) owner:self options:nil] lastObject];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setSelectionStyle:(UITableViewCellSelectionStyleNone)];
    [self.evaluationLabel setTextColor:kUIColorFromRGB(0xbbbbbb)];
}

- (void)setTitle:(NSString *)title {
    self.titleLabel.text = title;
    NSMutableAttributedString *content = [[NSMutableAttributedString alloc]initWithString:self.titleLabel.text];
    [content addAttribute:NSForegroundColorAttributeName
     
                    value:[UIColor redColor]
     
                    range:NSMakeRange(5, 1)];
    self.titleLabel.attributedText = content;
}

- (IBAction)fbtAction:(UIButton *)sender {
    _EvaluationStrat(1,_model);
    self.evaluationLabel.text = @"非常差";
    [self changeImageStraone:@"img_评论星星" two:@"img_评论星星灰色" thirt:@"img_评论星星灰色" four:@"img_评论星星灰色" five:@"img_评论星星灰色"];
}
- (IBAction)sbtAction:(UIButton *)sender {
    _EvaluationStrat(2,_model);
    self.evaluationLabel.text = @"差";
    [self changeImageStraone:@"img_评论星星" two:@"img_评论星星" thirt:@"img_评论星星灰色" four:@"img_评论星星灰色" five:@"img_评论星星灰色"];
}
- (IBAction)tbtAcion:(UIButton *)sender {
    _EvaluationStrat(3,_model);
    self.evaluationLabel.text = @"一般";
    [self changeImageStraone:@"img_评论星星" two:@"img_评论星星" thirt:@"img_评论星星" four:@"img_评论星星灰色" five:@"img_评论星星灰色"];
    
}
- (IBAction)fobAction:(UIButton *)sender {
    _EvaluationStrat(4,_model);
    self.evaluationLabel.text = @"好";
    [self changeImageStraone:@"img_评论星星" two:@"img_评论星星" thirt:@"img_评论星星" four:@"img_评论星星" five:@"img_评论星星灰色"];
}

- (IBAction)fibtAction:(UIButton *)sender {
    _EvaluationStrat(5,_model);
    self.evaluationLabel.text = @"很好";
    [self changeImageStraone:@"img_评论星星" two:@"img_评论星星" thirt:@"img_评论星星" four:@"img_评论星星" five:@"img_评论星星"];
}

- (void)changeImageStraone:(NSString *)one two:(NSString *)two thirt:(NSString *)thirt four:(NSString *)four five:(NSString *)five {
    
    [self.fbt setImage:[UIImage imageNamed:one] forState:(UIControlStateNormal)];
    [self.sbt setImage:[UIImage imageNamed:two] forState:(UIControlStateNormal)];
    [self.tbt setImage:[UIImage imageNamed:thirt] forState:(UIControlStateNormal)];
    [self.fobt setImage:[UIImage imageNamed:four] forState:(UIControlStateNormal)];
    [self.fibt setImage:[UIImage imageNamed:five] forState:(UIControlStateNormal)];
    
}


- (void)changestratType:(NSInteger)type {
    
    if (type == 1) {
        self.evaluationLabel.text = @"非常差";
        [self changeImageStraone:@"img_评论星星" two:@"img_评论星星灰色" thirt:@"img_评论星星灰色" four:@"img_评论星星灰色" five:@"img_评论星星灰色"];
    }else if (type == 2) {
        self.evaluationLabel.text = @"差";
        [self changeImageStraone:@"img_评论星星" two:@"img_评论星星" thirt:@"img_评论星星灰色" four:@"img_评论星星灰色" five:@"img_评论星星灰色"];
        
    }else if (type == 3) {
        self.evaluationLabel.text = @"一般";
        [self changeImageStraone:@"img_评论星星" two:@"img_评论星星" thirt:@"img_评论星星" four:@"img_评论星星灰色" five:@"img_评论星星灰色"];
        
    }else if (type == 4) {
        self.evaluationLabel.text = @"好";
        [self changeImageStraone:@"img_评论星星" two:@"img_评论星星" thirt:@"img_评论星星" four:@"img_评论星星" five:@"img_评论星星灰色"];
    }else if (type == 5) {
        self.evaluationLabel.text = @"很好";
        [self changeImageStraone:@"img_评论星星" two:@"img_评论星星" thirt:@"img_评论星星" four:@"img_评论星星" five:@"img_评论星星"];
    }else {
        [self changeImageStraone:@"img_评论星星灰色" two:@"img_评论星星灰色" thirt:@"img_评论星星灰色" four:@"img_评论星星灰色" five:@"img_评论星星灰色"];
    }
}







@end
