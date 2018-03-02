//
//  JXRecordingView.m
//  JaneCargo
//
//  Created by 鹏 on 2017/9/19.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXRecordingView.h"

@interface JXRecordingView ()


@property (nonatomic, strong) UIView *backVie;
@property (nonatomic, strong) UIView *voiceView;
@property (nonatomic, strong) UIImageView *voiceImage;
@property (nonatomic, strong) UILabel *voiceLabel;


@property (nonatomic, strong) UIButton *record;

@end


@implementation JXRecordingView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self recordingView];
    }
    return self;
}


- (void)recordingView {

    
    self.backVie = ({
        
        UIView *view = [UIView new];
        [view setBackgroundColor:[UIColor whiteColor]];
        [view.layer setCornerRadius:35/2];
        [view.layer setMasksToBounds:YES];
        view;
    });
    [self addSubview:self.backVie];
    
    self.voiceView = ({
        
        UIView *view = [UIView new];
        view;
    });
    [self addSubview:self.voiceView];
    
    self.voiceImage = ({
    
        UIImageView *image = [UIImageView new];
        [image setImage:[UIImage imageNamed:@"icon_语音输入"]];
        image;
    });
    [self.voiceView addSubview:self.voiceImage];
    
    self.voiceLabel = ({
        
        UILabel *label = [UILabel new];
        [label setText:@"按住 说出你要的商品"];
        [label setTextColor:kUIColorFromRGB(0x666666)];
        [label setFont:[UIFont systemFontOfSize:16.0f]];
        label;
        
    });
    [self.voiceView addSubview:self.voiceLabel];
    

    self.record = ({
        
        UIButton *recordbt = [UIButton new];
        [recordbt.layer setCornerRadius:35/2];
        [recordbt.layer setMasksToBounds:YES];
        // 开始
        [recordbt addTarget:self action:@selector(recordStart:) forControlEvents:UIControlEventTouchDown];
        // 取消
        [recordbt addTarget:self action:@selector(recordCancel:) forControlEvents: UIControlEventTouchDragExit | UIControlEventTouchUpOutside];
        //完成
        [recordbt addTarget:self action:@selector(recordFinish:) forControlEvents:UIControlEventTouchUpInside];
        recordbt;
    
    });
    [self addSubview:self.record];
}

- (void)layoutSubviews {

    [super layoutSubviews];
    [self.backVie mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(5);
        make.left.equalTo(self.mas_left).offset(35);
        make.right.equalTo(self.mas_right).offset(-35);
        make.height.equalTo(@(35));
    }];
    
    
    CGFloat reco_wid = [JXEncapSulationObjc stringWidth:self.voiceLabel.text maxSize:200 fontSize:16.0f]+13+14;
    CGFloat reco_right = (self.frame.size.width- reco_wid)/2;
    [self.voiceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(11.5);
        make.left.equalTo(self.mas_left).offset(reco_right);
        make.right.equalTo(self.mas_right).offset(-reco_right);
        make.height.equalTo(@(22));
    }];
    
    
    [self.voiceImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.voiceView.mas_top).offset(0);
        make.left.equalTo(self.voiceView.mas_left).offset(0);
        make.width.equalTo(@(13));
        make.height.equalTo(@(22));
    }];
    
    [self.voiceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.voiceView.mas_top).offset(0);
        make.left.equalTo(self.voiceImage.mas_left).offset(14+13);
        make.height.equalTo(@(22));
    }];
    
    
    // 按钮
    [self.record mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(5);
        make.left.equalTo(self.mas_left).offset(35);
        make.right.equalTo(self.mas_right).offset(-35);
        make.height.equalTo(@(35));
    }];
}



- (void)recordStart:(UIButton *)button
{
    _Recordblock(0);
    [self.backVie setBackgroundColor:kUIColorFromRGB(0xe3e3e3)];
   
}

- (void)recordCancel:(UIButton *)button
{
    _Recordblock(1);
    
}

- (void)recordFinish:(UIButton *)button
{
    _Recordblock(2);
    [self.backVie setBackgroundColor:[UIColor whiteColor]];
    
}



@end
