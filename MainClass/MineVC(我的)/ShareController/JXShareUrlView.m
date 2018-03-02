//
//  JXShareUrlView.m
//  JaneCargo
//
//  Created by 鹏 on 2018/1/26.
//  Copyright © 2018年 鹏. All rights reserved.
//

#import "JXShareUrlView.h"

@interface JXShareUrlView ()



@end


@implementation JXShareUrlView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)wxfAction:(UIButton *)sender {
    _ShareFriendblock(sender.tag);
}
- (IBAction)wxfrendAction:(UIButton *)sender {
    _ShareFriendblock(sender.tag);
}
- (IBAction)qqfriend:(UIButton *)sender {
    _ShareFriendblock(sender.tag);
}

@end
