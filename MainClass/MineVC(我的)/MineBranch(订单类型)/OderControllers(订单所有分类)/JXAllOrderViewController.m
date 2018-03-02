//
//  JXAllOrderViewController.m
//  JaneCargo
//
//  Created by cxy on 2017/7/7.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXAllOrderViewController.h"
#import "JXScrollerTitleView.h"

// 加载数据
#import "JXBranchOrderViewController.h"

#import "JXSearchOrderViewController.h"

@interface JXAllOrderViewController ()<UIScrollViewDelegate,FunctionScrdelegate>

@property (nonatomic, strong) JXScrollerTitleView *branchTitle;

@property (nonatomic, strong) UIButton *rightEditor;
@property (nonatomic, strong) UIButton *rightEditor1;
// 标题数量
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSMutableArray *tableArray;
// 记录每次位移的坐标
@property (nonatomic, strong) NSMutableArray *contentSizeFrame;
// 记录每个label的宽度
@property (nonatomic, strong) NSMutableArray *labelwidth;


@property (nonatomic, strong) UIView *is_superView;

@end

@implementation JXAllOrderViewController


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [JXEncapSulationObjc blackNavigation:self color:[UIColor whiteColor]];
}


- (NSArray *)titleArray {
    
    return @[@"全部",@"待付款",@"待发货",@"待收货",@"去评论",@"回收站"];
}

- (void)loadView {

    self.is_superView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.view = self.is_superView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    self.contentSizeFrame = @[].mutableCopy;
    self.labelwidth = @[].mutableCopy;
    self.tableArray = @[].mutableCopy;
    
    self.branchTitle = [[JXScrollerTitleView alloc] initWithFrame:CGRectMake(0, 64, NPWidth, NPHeight)];
    [self.is_superView addSubview:self.branchTitle];
    
    self.branchTitle.titleScrollView.delegate = self;
    self.branchTitle.contentScrollView.delegate = self;
    [self setupChildVc];
    [self setupTitle];
    [self aboutNavigate];
    [self showChildView:_indexController];
    // 显示对应的Controller
    [self showCorresponding];
    
    UILabel * titleLabel =[[UILabel alloc]init];
    titleLabel.text = @"我的订单";
    [titleLabel sizeToFit];
    titleLabel.textColor = [UIColor blackColor];
    self.navigationItem.titleView = titleLabel;
}


- (void)showChildView:(NSInteger)index {


    UIViewController *willShowVc = self.childViewControllers[index];
    // 如果当前位置的位置已经显示过了，就直接返回
    if ([willShowVc isViewLoaded]) return;
    // 添加控制器的view到contentScrollView中;
    willShowVc.view.frame = CGRectMake(index*NPWidth, 0, NPWidth, NPHeight);
    [self.branchTitle.contentScrollView addSubview:willShowVc.view];
}

#pragma mark -- 微信支付成功代理
- (void)wxPayscrollectiongIndex:(NSInteger)index {

    
    [self.branchTitle.contentScrollView setContentOffset:CGPointMake(index*NPWidth,0) animated:YES];
    // 让对应的顶部标题居中显示
    UILabel *label = self.branchTitle.titleScrollView.subviews[index];
    // 改变对应的颜色
    for (UILabel *label in self.tableArray) {
        if (label.tag == index) {
            [label setTextColor:kUIColorFromRGB(0xef5b4c)];
        }else {
            [label setTextColor:kUIColorFromRGB(0x666666)];
        }
    }
    CGPoint titleOffset = self.branchTitle.titleScrollView.contentOffset;
    
    CGFloat width = self.branchTitle.titleScrollView.frame.size.width;
    titleOffset.x = label.center.x - width * 0.5;
    // 左边超出处理
    if (titleOffset.x < 0) titleOffset.x = 0;
    // 右边超出处理
    CGFloat maxTitleOffsetX = self.branchTitle.titleScrollView.contentSize.width - width;
    if (titleOffset.x > maxTitleOffsetX) titleOffset.x = maxTitleOffsetX;
    [self.branchTitle.titleScrollView setContentOffset:titleOffset animated:NO];
    [UIView animateWithDuration:0.4 animations:^{
        self.branchTitle.colorView.frame = CGRectMake([self.contentSizeFrame[index] integerValue]-titleOffset.x, SCROLLER-1.5, [self.labelwidth[index] integerValue], 2);
    }];
    [self showChildView:index];
}


- (void)showCorresponding {

    UILabel *label = self.branchTitle.titleScrollView.subviews[self.indexController];
    // 改变对应的颜色
    [label setTextColor:kUIColorFromRGB(0xef5b4c)];
    CGPoint titleOffset = self.branchTitle.titleScrollView.contentOffset;
    CGFloat width = self.branchTitle.titleScrollView.frame.size.width;
    titleOffset.x = label.center.x - width * 0.5;
    // 左边超出处理
    if (titleOffset.x < 0) titleOffset.x = 0;
    // 右边超出处理
    CGFloat maxTitleOffsetX = self.branchTitle.titleScrollView.contentSize.width - width;
    if (titleOffset.x > maxTitleOffsetX) titleOffset.x = maxTitleOffsetX;
    [self.branchTitle.titleScrollView setContentOffset:titleOffset animated:YES];
    [self.branchTitle.contentScrollView setContentOffset:CGPointMake(self.indexController*NPWidth,0) animated:YES];
    self.branchTitle.colorView.frame = CGRectMake([self.contentSizeFrame[self.indexController] integerValue]-titleOffset.x, SCROLLER-1.5, [self.labelwidth[self.indexController] integerValue], 2);
}

#pragma mark --- 导航
- (void)aboutNavigate {
    
     _rightEditor = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, 20, 20)];
    [_rightEditor setImage:[UIImage imageNamed:@"icon_订单搜索"] forState:(UIControlStateNormal)];
    [_rightEditor setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [_rightEditor.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
    [_rightEditor addTarget:self action:@selector(setItemAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    _rightEditor1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    [_rightEditor1 setImage:[UIImage imageNamed:@"icon_messageBlack"] forState:(UIControlStateNormal)];
    [_rightEditor1 setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [_rightEditor1.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
    [_rightEditor1 addTarget:self action:@selector(messageAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    UIBarButtonItem * setItem = [[UIBarButtonItem alloc] initWithCustomView:_rightEditor];
    UIBarButtonItem * addPictureItem = [[UIBarButtonItem alloc] initWithCustomView:_rightEditor1];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_back"] style:(UIBarButtonItemStylePlain) target:self action:@selector(leftAction:)];

    self.navigationItem.rightBarButtonItems = @[addPictureItem,setItem];
}

- (void)leftAction:(UIBarButtonItem *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}
// 订单搜索
- (void)setItemAction:(UIButton *)sender {

    JXSearchOrderViewController *searchorder = [[JXSearchOrderViewController alloc] init];
    [self.navigationController pushViewController:searchorder animated:YES];
}
- (void)messageAction:(UIButton *)sender {
    JXPushMessageViewController *jxpush = [[JXPushMessageViewController alloc] init];
    [self.navigationController pushViewController:jxpush animated:YES];
}

#pragma mark --- 添加控制器
// 添加控制器
- (void)setupChildVc {
    for (int i = 0; i < self.titleArray.count; i++) {
        JXBranchOrderViewController *social0 = [[JXBranchOrderViewController alloc] init];
        social0.funcdelegate = self;
        social0.title = self.titleArray[i];
        [self addChildViewController:social0];
    }
}

- (void)setupTitle {
    
    // 获取总长度
    CGFloat contentSizes = 0;
    // 获取总位移长度
    CGFloat contentScroller = 0;
    // 定义临时变量
    CGFloat labelW = 0;
    CGFloat labelY = 0;
    CGFloat labelH = self.branchTitle.titleScrollView.frame.size.height;
    CGFloat labelX = 0;
    
    // 添加label
    for (NSInteger i = 0; i<self.titleArray.count; i++) {
        
        labelW = [JXEncapSulationObjc stringWidth:self.titleArray[i] maxSize:NPWidth fontSize:14.0f];
        // 获取所有内容的长度总和
        contentSizes += labelW;
        UILabel *label = [[UILabel alloc] init];
        label.text = self.titleArray[i];
        if (i == 0) {
            labelX = 33*i+21;
        }else {
            labelX = (contentSizes-labelW)+33*i+21;
        }
        // 获取contentSize的总长度
        contentScroller = labelX;
        // 记录每次位移的坐标。宽度
        [self.contentSizeFrame addObject:[NSString stringWithFormat:@"%f",labelX]];
        [self.labelwidth addObject:[NSString stringWithFormat:@"%f",labelW]];
        
        label.frame = CGRectMake(labelX, labelY, labelW, labelH);
        label.textAlignment = NSTextAlignmentCenter;
        [label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClick:)]];
        label.userInteractionEnabled = YES;
        label.tag = i;
        if (i == _indexController) {
            [label setTextColor:kUIColorFromRGB(0xef5b4c)];
        }else {
            [label setTextColor:kUIColorFromRGB(0x666666)];
        }
        [label setFont:[UIFont systemFontOfSize:14.0f]];
        [self.tableArray addObject:label];
        [self.branchTitle.titleScrollView addSubview:label];
    }
    // 设置contentSize
    self.branchTitle.titleScrollView.contentSize = CGSizeMake(contentScroller+[JXEncapSulationObjc stringWidth:self.titleArray[self.titleArray.count-1] maxSize:NPWidth fontSize:14.0f]+20, 0);
    self.branchTitle.contentScrollView.contentSize = CGSizeMake(self.titleArray.count * NPWidth, 0);
    self.branchTitle.contentScrollView.scrollEnabled = NO;
}

/**
 * 监听顶部label点击
 */
- (void)labelClick:(UITapGestureRecognizer *)tap {
    // 取出被点击label的索引
    NSInteger index = tap.view.tag;
    _indexController = index;
    [self.branchTitle.contentScrollView setContentOffset:CGPointMake(index*NPWidth,0) animated:YES];
    // 让对应的顶部标题居中显示
    UILabel *label = self.branchTitle.titleScrollView.subviews[index];
    // 改变对应的颜色
    for (UILabel *label in self.tableArray) {
        if (label.tag == index) {
            [label setTextColor:kUIColorFromRGB(0xef5b4c)];
        }else {
            [label setTextColor:kUIColorFromRGB(0x666666)];
        }
    }
    CGPoint titleOffset = self.branchTitle.titleScrollView.contentOffset;
    CGFloat width = self.branchTitle.titleScrollView.frame.size.width;
    titleOffset.x = label.center.x - width * 0.5;
    // 左边超出处理
    if (titleOffset.x < 0) titleOffset.x = 0;
    // 右边超出处理
    CGFloat maxTitleOffsetX = self.branchTitle.titleScrollView.contentSize.width - width;
    if (titleOffset.x > maxTitleOffsetX) titleOffset.x = maxTitleOffsetX;
    [self.branchTitle.titleScrollView setContentOffset:titleOffset animated:NO];
    [UIView animateWithDuration:0.4 animations:^{
        self.branchTitle.colorView.frame = CGRectMake([self.contentSizeFrame[index] integerValue]-titleOffset.x, SCROLLER-1.5, [self.labelwidth[index] integerValue], 2);
        
    }];
    [self showChildView:index];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    CGFloat offsetX = scrollView.contentOffset.x;
    for (UILabel *label in self.tableArray)
    {
        if (label.tag == _indexController)
        {
            CGRect titleframe = self.branchTitle.colorView.frame;
            titleframe.origin.x = label.frame.origin.x-offsetX;
            // 当前位置需要显示的控制器的索引
            [UIView animateWithDuration:0.4 animations:^{
                self.branchTitle.colorView.frame = titleframe;
            }];
            
        }
    }
}






@end
