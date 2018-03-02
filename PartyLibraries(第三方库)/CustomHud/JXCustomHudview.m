//
//  JXCustomHudview.m
//  JaneCargo
//
//  Created by 鹏 on 2017/10/24.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXCustomHudview.h"

@interface  JXCustomHudview()

@property (nonatomic, strong) UILabel *alterLabel;
@property(nonatomic,copy)NSString *title;

@end


@implementation JXCustomHudview


- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.alterLabel = ({
            
            UILabel *alter = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 40)];
            [alter setTextColor:[UIColor whiteColor]];
            [alter setTextAlignment:(NSTextAlignmentCenter)];
            [alter setFont:[UIFont systemFontOfSize:16.0f]];
            alter;
            
        });
        [self addSubview:self.alterLabel];
        
    }
    return self;
    
}

+ (instancetype)alterViewWithTitle:(NSString *)title {
     
    CGFloat alterW = [JXEncapSulationObjc stringWidth:title maxSize:NPWidth fontSize:16.0f];
    JXCustomHudview *alterView=[[JXCustomHudview alloc]initWithFrame:CGRectMake((NPWidth-(alterW+30))/2, (NPHeight-44)/2, alterW+30, 40)];
    [alterView.layer setMasksToBounds:true];
    [alterView.layer setCornerRadius:6.0];
    [alterView setBackgroundColor:[UIColor blackColor]];
    alterView.title = title;
    return alterView;
}

- (void)setTitle:(NSString *)title {
    
    self.alterLabel.text = title;
    CGFloat alterW = [JXEncapSulationObjc stringWidth:title maxSize:NPWidth fontSize:16.0f]+30;
    [self.alterLabel setFrame:CGRectMake(0, 0, alterW, 40)];
    [self.alterLabel  setTextAlignment:(NSTextAlignmentCenter)];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self removeFromSuperview];
    });
}



- (void)hidalterhud {
    
    [self removeFromSuperview];
    
}











@end
