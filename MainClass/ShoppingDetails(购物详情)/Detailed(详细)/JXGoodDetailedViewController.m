//
//  JXGoodDetailedViewController.m
//  JaneCargo
//
//  Created by 鹏 on 2017/7/18.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXGoodDetailedViewController.h"
#import "JXIntroduceViewController.h"
#import "JXParameterViewController.h"


@interface JXGoodDetailedViewController ()<UIScrollViewDelegate>


@property (weak, nonatomic) IBOutlet UIButton *introducebt;

@property (weak, nonatomic) IBOutlet UIButton *parameterbt;

@property (weak, nonatomic) IBOutlet UIView *colorView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollViewController;
@property (weak, nonatomic) IBOutlet UIView *bottomLine;

@property (nonatomic, strong) JXIntroduceViewController *introduce;
@property (nonatomic, strong) JXParameterViewController *parameter;
@end

@implementation JXGoodDetailedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setFrame:CGRectMake(NPWidth, 0, NPWidth, NPHeight)];
    [self aboutScrollView];
    [_colorView setBackgroundColor:kUIColorFromRGB(0xe3e3e3)];
    [_bottomLine setBackgroundColor:kUIColorFromRGB(0xe3e3e3)];
    
}

- (void)viewDidAppear:(BOOL)animated {

    [super viewDidAppear:animated];
    
    
}


- (void)aboutScrollView {

    [_parameter willMoveToParentViewController:nil];
    [_parameter.view removeFromSuperview];
    [_parameter removeFromParentViewController];
    [_introduce willMoveToParentViewController:nil];
    [_introduce.view removeFromSuperview];
    [_introduce removeFromParentViewController];
    
    
    self.scrollViewController.delegate = self;
    self.scrollViewController.pagingEnabled = YES;
    self.scrollViewController.bounces = NO;
    //需要先设置bounces为NO 才起效
    self.scrollViewController.alwaysBounceVertical =NO;
    self.scrollViewController.alwaysBounceHorizontal =NO ;
    self.scrollViewController.showsHorizontalScrollIndicator = NO;
    self.scrollViewController.showsVerticalScrollIndicator = NO;
    self.scrollViewController.contentSize = CGSizeMake(NPWidth*2, 0);
    
    _introduce = [[JXIntroduceViewController alloc] init];
//    [_introduce.view setFrame:CGRectMake(0, 0, NPWidth, NPHeight)];
    _introduce.goods_id = self.goods_id;
    [self addChildViewController:_introduce];
    [self.scrollViewController addSubview:_introduce.view];
    [_introduce didMoveToParentViewController:self];
    
    _parameter = [[JXParameterViewController alloc] init];
//    [_parameter.view setFrame:CGRectMake(NPWidth, 0, NPWidth, NPHeight)];
    [self addChildViewController:_parameter];
    _parameter.goodparameterArray = _goodparameterArray;
    [self.scrollViewController addSubview:_parameter.view];
    [_parameter didMoveToParentViewController:self];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    CGFloat offsetY = scrollView.contentOffset.x;
    NSInteger index = offsetY/NPWidth;
    if (index == 0) {
        [_introducebt setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
        [_parameterbt setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    }else if (index == 1) {
        [_introducebt setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [_parameterbt setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
    }
}





- (IBAction)introduceAction:(UIButton *)sender {
    
    self.scrollViewController.contentOffset = CGPointMake(0, 0);
    [_introducebt setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
    [_parameterbt setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    
    
}
- (IBAction)parameterAction:(UIButton *)sender {
    self.scrollViewController.contentOffset = CGPointMake(NPWidth, 0);
    [_introducebt setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [_parameterbt setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
