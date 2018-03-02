//
//  JXRotating.m
//  JaneCargo
//
//  Created by 鹏 on 2017/10/26.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXRotating.h"

@implementation JXRotating

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        CGFloat Image_Width = 40;
        CGFloat Image_Hight = 40;
        UIView *backgroundImage = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Image_Width, Image_Hight)];
        [backgroundImage setBackgroundColor:[UIColor clearColor]];
        //    [backgroundImage setAlpha:0.7];
        //    [backgroundImage.layer setMasksToBounds:true];
        //    [backgroundImage.layer setCornerRadius:5.0];
        [self addSubview:backgroundImage];
        [self bringSubviewToFront:backgroundImage];
        
        NSString  *name = @"timg.gif";
        NSString  *filePath = [[NSBundle bundleWithPath:[[NSBundle mainBundle] bundlePath]] pathForResource:name ofType:nil];
        NSData  *imageData = [NSData dataWithContentsOfFile:filePath];
        UIImageView *loadingImageView = [[UIImageView alloc]init];
        loadingImageView.backgroundColor = [UIColor clearColor];
        loadingImageView.image = [UIImage sd_animatedGIFWithData:imageData];
        loadingImageView.frame = CGRectMake(0, 0, Image_Width, Image_Hight);
        [backgroundImage addSubview:loadingImageView];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self removeFromSuperview];
        });
    }
    return self;
    
}

+ (instancetype)initWithRotaing {
    CGFloat Image_Width = 40;
    CGFloat Image_Hight = 40;
    JXRotating *rot = [[JXRotating alloc] initWithFrame:CGRectMake(NPWidth/2-Image_Width/2, NPHeight/2-Image_Hight, Image_Width, Image_Hight)];
    
    return rot;
}





@end
