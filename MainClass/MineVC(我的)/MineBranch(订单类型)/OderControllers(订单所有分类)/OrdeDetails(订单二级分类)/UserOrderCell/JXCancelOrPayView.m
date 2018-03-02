//
//  JXCancelOrPayView.m
//  JaneCargo
//
//  Created by 鹏 on 2017/7/10.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXCancelOrPayView.h"

@interface JXCancelOrPayView ()



@property (weak, nonatomic) IBOutlet UIView *line;
@end


@implementation JXCancelOrPayView


- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.orderpaybt.layer setMasksToBounds:true];
    [self.orderpaybt.layer setCornerRadius:self.orderpaybt.frame.size.height/2];
    [self.orderpaybt.layer setBorderColor:[kUIColorFromRGB(0xef5b4c) CGColor]];
    [self.orderpaybt.layer setBorderWidth:0.5f];
    [self.orderpaybt setTitleColor:kUIColorFromRGB(0xef5b4c) forState:(UIControlStateNormal)];
    
    [self.ordercancelbt.layer setMasksToBounds:true];
    [self.ordercancelbt.layer setCornerRadius:self.ordercancelbt.frame.size.height/2];
    [self.ordercancelbt.layer setBorderColor:[kUIColorFromRGB(0xef5b4c) CGColor]];
    [self.ordercancelbt.layer setBorderWidth:0.5f];
    [self.ordercancelbt setTitleColor:kUIColorFromRGB(0xef5b4c) forState:(UIControlStateNormal)];
    
    [self.line setBackgroundColor:kUIColorFromRGB(0xcccccc)];
}


- (IBAction)orderpayAction:(UIButton *)sender {
    if ([_userorderdelegate respondsToSelector:@selector(infrontbt:)]) {
        [_userorderdelegate infrontbt:@"1"];
    }
}
- (IBAction)ordercancelAction:(UIButton *)sender {
    if ([_userorderdelegate respondsToSelector:@selector(infrontbt:)]) {
        [_userorderdelegate infrontbt:@"0"];
    }
}

@end
