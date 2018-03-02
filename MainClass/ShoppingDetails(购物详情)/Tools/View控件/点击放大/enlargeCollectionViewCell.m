//
//  enlargeCollectionViewCell.m
//  代码布局
//
//  Created by iOS on 16/7/25.
//  Copyright © 2016年 iOS. All rights reserved.
//

#import "enlargeCollectionViewCell.h"
@interface enlargeCollectionViewCell()<UIScrollViewDelegate>
@property(nonatomic,strong)UIScrollView * scroll;
@end
@implementation enlargeCollectionViewCell
static CGFloat  loopimageHeight;
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        UIScrollView * scrollView = [[UIScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        self.scroll = scrollView;
//        scrollView.userInteractionEnabled = YES;
        
              self.imageView = [[UIImageView alloc]init];
        self.imageView.userInteractionEnabled = YES;
         [scrollView addSubview:self.imageView];
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImage:)];
        tap.numberOfTapsRequired=1;//单击
        tap.numberOfTouchesRequired=1;//单点触碰
        [self.imageView addGestureRecognizer:tap];
        UITapGestureRecognizer *doubleTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doubleTap:)];
        doubleTap.numberOfTapsRequired=2;//避免单击与双击冲突
        [tap requireGestureRecognizerToFail:doubleTap];
        [self.imageView addGestureRecognizer:doubleTap];
            }
    return self;
}
-(void)doubleTap:(id)sender
{
    self.scroll.zoomScale=1.0;//双击放大到两倍
}
- (IBAction)tapImage:(id)sender
{
    //[self dismissViewControllerAnimated:YES completion:nil];//单击图像,关闭图片详情(当前图片页面)
    [self.delegate removeEnlargeImageView];
}
- (void)setImage:(UIImage *)image{
    _image = image;
    self.scroll.delegate =self;
    self.scroll.contentSize = CGSizeMake(0, 0);
    self.scroll.maximumZoomScale=2.0;//图片的放大倍数
    self.scroll.minimumZoomScale=0.2;//图片的最小倍率
    [self.scroll setZoomScale:0];
    [self addSubview:self.scroll];
    self.scroll.scrollsToTop = NO;

    loopimageHeight =  (NPWidth/image.size.width)*image.size.height;
  //  NSLog(@"loopimageHeight == %f",loopimageHeight);
    self.imageView.frame = CGRectMake(0, (NPHeight - loopimageHeight)/2.0, NPWidth, loopimageHeight);
//    [self.imageView makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.scroll).offset((HEIGHT - loopimageHeight)/2.0);
//        make.bottom.equalTo(self.scroll).offset(-(HEIGHT - loopimageHeight)/2.0);
//        make.left.equalTo(self.scroll);
//        make.right.equalTo(self.scroll);
//    }];

}
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView  //委托方法,必须设置  delegate
{
    return self.imageView;//要放大的视图
}


@end
