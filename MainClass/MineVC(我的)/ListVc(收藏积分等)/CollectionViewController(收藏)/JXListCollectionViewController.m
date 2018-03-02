//
//  JXListCollectionViewController.m
//  JaneCargo
//
//  Created by 鹏 on 2017/8/7.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXListCollectionViewController.h"
#import "XWAddShopCarTitleView.h"
#import "JXListGoodViewController.h"
#import "JXListStoreViewController.h"
@interface JXListCollectionViewController ()<XWAddShopCarTitleViewDelegate,UIScrollViewDelegate>
/*
 * 导航头部视图
 */
@property(strong, nonatomic) XWAddShopCarTitleView * titleView;
@property(strong, nonatomic) UIScrollView * detailBaseView;
@end

@implementation JXListCollectionViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [JXEncapSulationObjc blackNavigation:self color:[UIColor whiteColor]];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self navigationTitle];
    [self CreatDetailBaseView];
}

- (void)navigationTitle {

    _titleView = [XWAddShopCarTitleView wxAddshopcarttitleArray:@[@"商品",@"店铺"]];
    self.navigationItem.titleView = _titleView;
    _titleView.delegate =self;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_back"] style:(UIBarButtonItemStylePlain) target:self action:@selector(leftAction:)];
}


-(void)CreatDetailBaseView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.detailBaseView =[[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, NPWidth, NPHeight)];
    self.detailBaseView.delegate = self;
    self.detailBaseView.scrollEnabled = NO;
    [self.view addSubview:self.detailBaseView];
    self.detailBaseView.pagingEnabled = YES;
    self.detailBaseView.bounces = NO;
    //需要先设置bounces为NO 才起效
    self.detailBaseView.alwaysBounceVertical =YES ;
    self.detailBaseView.alwaysBounceHorizontal =NO ;
    self.detailBaseView.showsHorizontalScrollIndicator = NO;
    self.detailBaseView.showsVerticalScrollIndicator = NO;
    self.detailBaseView.contentSize = CGSizeMake(NPWidth*2, NPHeight);
    
    JXListGoodViewController *goods = [[JXListGoodViewController alloc] init];
    [goods.view setFrame:CGRectMake(0, 0, NPWidth, NPHeight)];
    [self addChildViewController:goods];
    [self.detailBaseView addSubview:goods.view];
    [goods didMoveToParentViewController:self];

    JXListStoreViewController *comment = [[JXListStoreViewController alloc] init];
    [comment.view setFrame:CGRectMake(NPWidth, 0, NPWidth, NPHeight)];
    [self addChildViewController:comment];
    [self.detailBaseView addSubview:comment.view];
    [comment didMoveToParentViewController:self];
    // 商品
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // 设置偏移
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
}

// 减速完成调用（scrollView的contentOffSet是确定的）
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    
    if ([self.detailBaseView isEqual:scrollView])
    {
        // 索引
        NSInteger index = scrollView.contentOffset.x / scrollView.width;
        // 修改导航选中标题
        [self.titleView  updataSelectTitleWithTag:index];
    }
}


- (void)leftAction:(UIBarButtonItem *)sender  {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark- 导航标题切换代理
-(void)XWAddShopCarTitleView:(XWAddShopCarTitleView *)View ClickTitleWithTag:(NSInteger)tag andButton:(UIButton *)sender
{
    // scroll水平方向偏移
    self.detailBaseView.contentOffset = CGPointMake(tag*NPWidth, 0);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
