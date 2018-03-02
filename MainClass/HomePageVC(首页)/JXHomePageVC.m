//
//  JXHomePageVC.m
//  JaneCargo
//
//  Created by 鹏 on 2017/8/15.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXHomePageVC.h"
// 自定义导航
#import "DCHoverNavView.h"
// 搜索
#import "JXGoodsSearchViewController.h"
// 广告轮播
#import "NewPagedFlowView.h"
#import "PGIndexBannerSubiew.h"

#import "JXAhuiCollectionReusableView.h"
#import "JXFourBtCollectionViewCell.h"
#import "JXHomeMoreCollectionViewCell.h"
#import "JXShufflingCollectionViewCell.h"
#import "JXAdvertisingCollectionViewCell.h"
#import "JXCategoryCollectionViewCell.h"
#import "JXRecommendTitleCollectionViewCell.h"
#import "JXHomePageCollectionViewCell.h"
@interface JXHomePageVC ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,SDCycleScrollViewDelegate,UITextFieldDelegate,NewPagedFlowViewDelegate, NewPagedFlowViewDataSource>

@property (strong , nonatomic) UICollectionView *collectionView;
// 自定义导航
@property (strong , nonatomic)DCHoverNavView *hoverNavView;
// 小轮播
//@property (strong, nonatomic) NewPagedFlowView *pageFlowView;
// 导航控件
@property (nonatomic, strong) UITextField *searchField;
@property (nonatomic, strong) UIView *transparentView;
//@property (nonatomic, strong) UIButton *rightButton;
/* 滚回顶部按钮 */
@property (strong , nonatomic)UIButton *backTopButton;

// 新品 团购。。。
@property (nonatomic, strong) NSArray *fourImageArray;
@property (nonatomic, strong) NSArray *fourTitleArray;
// 顶部轮播
@property (nonatomic, strong) NSMutableArray *sd_imageArray;
// 广告轮播图片数组--标题
@property (nonatomic, strong) NSMutableArray *secitionImageArray;
@property (nonatomic, strong) NSMutableArray *bannerTitleArray;
// 促销
@property (nonatomic, strong) NSMutableArray *salespromotionArray;
// 各类产品
@property (nonatomic, strong) NSMutableArray *productArray;
// 抢购
@property (nonatomic, strong) NSMutableArray *snapUpArray;
// 推荐
@property (nonatomic,strong) NSMutableArray *recommendedArray;


//@property (nonatomic, strong) UILabel *gradientLabel;
//@property (nonatomic, strong) UIView *sdleftView;
//@property (nonatomic, strong) UIView *sdrightView;

@end

@implementation JXHomePageVC


// 头部
static NSString *kheaderIdentifier = @"headerIdentifier";
// cell
static NSString *k_cellIdentifierFour = @"collectionCellI_Four";
static NSString *k_cellIdentifierMore = @"collectionCellI_More";
static NSString *k_cellIdentifierShuff = @"collectionCellI_Shuff";
static NSString *k_cellIdentifierAdver = @"collectionCellI_Adver";
static NSString *k_cellIdentifierCate = @"collectionCellI_Cate";
static NSString *k_cellIdentifierRecom = @"collectionCellI_Recom";
static NSString *k_cellIdentifierPage = @"collectionCellI_Page";


- (NSArray *)fourImageArray {
    
    return @[@"icon_newproduct",@"icon_groupPurchase",@"icon_clearance",@"icon_products"];
}
- (NSArray *)fourTitleArray {
    
    return @[@"新品",@"团购",@"积分",@"极惠商品"];
}

#pragma mark - LazyLoad
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [self.view addSubview:_collectionView];
        _collectionView.showsVerticalScrollIndicator = NO;
        // 头部
        [_collectionView registerClass:[JXAhuiCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kheaderIdentifier];
        // cell
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([JXFourBtCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:k_cellIdentifierFour];
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([JXHomeMoreCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:k_cellIdentifierMore];
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([JXShufflingCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:k_cellIdentifierShuff];
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([JXAdvertisingCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:k_cellIdentifierAdver];
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([JXCategoryCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:k_cellIdentifierCate];
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([JXRecommendTitleCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:k_cellIdentifierRecom];
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([JXHomePageCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:k_cellIdentifierPage];
        
        _collectionView.frame = CGRectMake(0, 0, NPWidth, NPHeight-49);
    }
    return _collectionView;
}

#pragma mark - LifeCyle
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}
#pragma mark - 导航栏
- (void)setUpNav
{
    _hoverNavView = [[DCHoverNavView alloc] init];
    [self.view insertSubview:_hoverNavView atIndex:1];
    _hoverNavView.frame = CGRectMake(0, 0, NPWidth, 64);
    [_hoverNavView leftAndrightImageleft:@"icon_logo" right:@"icon_消息"];
    
    __weak typeof(self)weakSelf = self;
    _hoverNavView.leftItemClickBlock = ^{
        [weakSelf settingItemClick];
    };
    _hoverNavView.rightItemClickBlock = ^{
        [weakSelf messageItemClick];
    };
    
    CGFloat width = NPWidth - 110;
    CGFloat height = 30;
    CGFloat X = (NPWidth - width) * 0.5;
    CGFloat Y = 30;
    CGRect frame = CGRectMake(X, Y, width, height);
    _transparentView = [[UIView alloc] initWithFrame:frame];
    [_transparentView setAlpha:0.3];
    [_transparentView setBackgroundColor:kUIColorFromRGB(0xffffff)];
    [self.transparentView.layer setMasksToBounds:true];
    [self.transparentView.layer setCornerRadius:2];
    
    _searchField = [[UITextField alloc] initWithFrame:frame];
    _searchField.keyboardType = UIKeyboardTypeASCIICapable; //键盘显示类型
    _searchField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter; //设置居中输入
    _searchField.font = [UIFont systemFontOfSize:14];
    _searchField.delegate = self;
    [self.searchField.layer setMasksToBounds:true];
    [self.searchField.layer setCornerRadius:2];
    [self setRightView];
    // 2. 中间添加searchBar
    [_hoverNavView addSubview:_transparentView];
    [_hoverNavView addSubview:_searchField];
}

#pragma mark - 设置
- (void)settingItemClick
{
    
}
#pragma mark - 消息
- (void)messageItemClick
{
    
}

- (void)setRightView {
    // 创建按钮
  //  _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
  //  [_rightButton setImage:[UIImage imageNamed:@"icon_扫码"] forState:UIControlStateNormal];
//[_rightButton sizeToFit];
    // 将imageView宽度
  //  _rightButton.frameWidth += 10;
    //居中
   // _rightButton.contentMode = UIViewContentModeCenter;
  //  _searchField.rightView = _rightButton;
    //  注意：一定要设置，想要显示搜索框左边的视图，一定要设置左边视图的模式
   // _searchField.rightViewMode = UITextFieldViewModeAlways;
  //  [_rightButton addTarget:self action:@selector(sweepyardAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
}
#pragma mark --- 扫码
- (void)sweepyardAction:(UIButton *)sender {
    
    //    JWDQRCodeViewController *QRCodeVC = [[JWDQRCodeViewController alloc] init];
    //    [self presentViewController:QRCodeVC animated:YES completion:nil];
    
    
}


#pragma mark --- 当用户全部清空的时候的时候 会调用
-(BOOL)textFieldShouldClear:(UITextField *)textField {
    
    return true;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    return YES;
}

#pragma mark --- 搜索
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [textField resignFirstResponder];
    JXGoodsSearchViewController *search = [[JXGoodsSearchViewController alloc] init];
    search.hidesBottomBarWhenPushed = true;
    [self.navigationController pushViewController:search animated:YES];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //判断回到顶部按钮是否隐藏
    _backTopButton.hidden = (scrollView.contentOffset.y > [UIScreen mainScreen].bounds.size.height) ? NO : YES;
    
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > 20)
    {
        [_hoverNavView setBackgroundColor:[UIColor whiteColor]];
        [_searchField setBackgroundColor:kUIColorFromRGB(0xf0f2f5)];
    //    [_rightButton setImage:[UIImage imageNamed:@"icon_扫码_黑色"] forState:UIControlStateNormal];
        [_hoverNavView leftAndrightImageleft:@"icon_logo_彩色" right:@"icon_messageBlack"];
    }
    else
    {
        [_hoverNavView setBackgroundColor:[UIColor clearColor]];
        [_searchField setBackgroundColor:[UIColor clearColor]];
     //   [_rightButton setImage:[UIImage imageNamed:@"icon_扫码"] forState:UIControlStateNormal];
        [_hoverNavView leftAndrightImageleft:@"icon_logo" right:@"icon_消息"];
    }
}


- (void)setUpScrollToTopView
{
    _backTopButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:_backTopButton];
    [_backTopButton addTarget:self action:@selector(ScrollToTop) forControlEvents:UIControlEventTouchUpInside];
    [_backTopButton setImage:[UIImage imageNamed:@"icon_top"] forState:UIControlStateNormal];
    _backTopButton.hidden = YES;
    _backTopButton.frame = CGRectMake(NPWidth - 50, NPHeight - 110, 40, 40);
    [_backTopButton.layer setMasksToBounds:true];
    [_backTopButton.layer setCornerRadius:20];
    [_backTopButton.layer setBorderWidth:0.5];
    [_backTopButton.layer setBorderColor:[kUIColorFromRGB(0xe3e3e3) CGColor]];
}
#pragma mark - collectionView滚回顶部
- (void)ScrollToTop {
    
    [_collectionView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.recommendedArray = @[].mutableCopy;
    [self setUpBase];
    [self setUpNav];
    [self httpsdate];
}

- (void)httpsdate {
    
    [JXNetworkRequest asyncHomePageIs_Cache:true refreshCache:false completed:^(NSDictionary *messagedic) {
        // 获取顶部轮播
        for (NSDictionary *bannerimagedic in messagedic[@"info"][@"banner"][@"info"]) {
            JXHomepagModel *model = [JXHomepagModel alloc];
            [model setValuesForKeysWithDictionary:bannerimagedic];
            [self.sd_imageArray addObject:model];
        }
        // 促销产品
        NSArray *promotionArray = messagedic[@"info"][@"cxgood"][@"info"];
        for (NSDictionary *promotiondic in promotionArray) {
            JXHomepagModel *model = [JXHomepagModel alloc];
            [model setValuesForKeysWithDictionary:promotiondic];
            [self.salespromotionArray addObject:model];
        }
        // 各类产品
        NSArray *goodArray = messagedic[@"info"][@"good_type"];
        for (NSDictionary *gooddic in goodArray) {
            JXHomepagModel *model = [JXHomepagModel alloc];
            [model setValuesForKeysWithDictionary:gooddic];
            [self.productArray addObject:model];
            // 获取产品的banner图
            NSArray *infoArray = gooddic[@"banner"][@"info"];
            if (!kArrayIsEmpty(infoArray)) {
                [self.secitionImageArray addObject:infoArray];
            }else {
                NSMutableArray *array_nil = @[].mutableCopy;
                [self.secitionImageArray addObject:array_nil];
            }
        }
        // 抢购
        NSArray *snapArray = messagedic[@"info"][@"qggood"][@"info"];
        for (NSDictionary *snapdic in snapArray) {
            JXHomepagModel *model = [JXHomepagModel alloc];
            [model setValuesForKeysWithDictionary:snapdic];
            [self.snapUpArray addObject:model];
        }
        [_collectionView reloadData];
        
    } statisticsFail:^(NSDictionary *messagedic) {
        
    } fail:^(NSError *error) {
        
    }];
    
}





#pragma mark - initialize
- (void)setUpBase
{
    [self.view setBackgroundColor:kUIColorFromRGB(0xf2f2f2)];
    self.collectionView.backgroundColor = kUIColorFromRGB(0xf2f2f2);
    self.automaticallyAdjustsScrollViewInsets = NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark -CollectionView datasource
//section
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 5+self.productArray.count;
}
//item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 4;
    }
    else if (section == 1)
    {
        return 1;
    }
    else if (section == 2)
    {
        return 3;
    }
    else if (section == 5+self.productArray.count-2)
    {
        return 1;
    }
    else if (section == 5+self.productArray.count-1)
    {
        return 6;
    }
    else
    {
        return 2;
    }
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        JXFourBtCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:k_cellIdentifierFour forIndexPath:indexPath];
        [cell setImageIcon:self.fourImageArray[indexPath.row] title:self.fourTitleArray[indexPath.row]];
        return cell;
    }
    else if (indexPath.section == 1)
    {
        JXHomeMoreCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:k_cellIdentifierMore forIndexPath:indexPath];
        return cell;
    }
    else if (indexPath.section == 2)
    {
        JXShufflingCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:k_cellIdentifierShuff forIndexPath:indexPath];
        if (self.snapUpArray.count>0) {
            JXHomepagModel *model = self.snapUpArray[indexPath.row];
            [cell setModel:model];
        }
        return cell;
    }
    else if (indexPath.section == 5+self.productArray.count-2)
    {
        JXRecommendTitleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:k_cellIdentifierRecom forIndexPath:indexPath];
        return cell;
    }
    else if (indexPath.section == 5+self.productArray.count-1)
    {
        JXHomePageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:k_cellIdentifierPage forIndexPath:indexPath];
        return cell;
        
    }
    else
    {
        // 小轮播 六张图片内容
        if (indexPath.row==0) {
            JXAdvertisingCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:k_cellIdentifierAdver forIndexPath:indexPath];
            [self littleShuffling:cell indexPath:indexPath];
            return cell;
        }else {
            JXCategoryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:k_cellIdentifierCate forIndexPath:indexPath];
            [self waterfallFlow:cell indexPath:indexPath];
            return cell;
        }
        
    }
}

// 不规则的6个图片
- (void)waterfallFlow:(JXCategoryCollectionViewCell *)cell indexPath:(NSIndexPath *)indexPath {
    
    // 取出对应的数据
    JXHomepagModel *mode;
    if (self.productArray.count > 0) {
        mode = self.productArray[indexPath.section-3];
        [cell setModel:mode];
    }
    __weak typeof(self)root = self;
    cell.Imageblock = ^(NSInteger type,JXHomepagModel *modes) {
        NSArray *infoArray = modes.good[@"info"];
        NSDictionary *good_iddic = infoArray[type];
        JXHomepagModel *goodid_mode = [[JXHomepagModel alloc] init];
        [goodid_mode setValuesForKeysWithDictionary:good_iddic];
        [JXPodOrPreVc buyGoodsModel:goodid_mode navigation:root.navigationController];
    };
    
}

// 小广告轮播
- (void)littleShuffling:(JXAdvertisingCollectionViewCell *)cell indexPath:(NSIndexPath *)indexPath{
    
    JXHomepagModel *model;
    if (self.productArray.count > 0) {
        model = self.productArray[indexPath.section-3];
    }
    // -3从0开始计算
    [self animatSDScroller:cell.advertisingScr viewTag:indexPath.section-3];
    // 传数据
    [cell setModel:model];
    
}




//定义每个UICollectionViewCell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        return CGSizeMake(NPWidth/4, 90);
    }
    else if (indexPath.section == 1)
    {
        return CGSizeMake(NPWidth, TableViewControllerCell_Height);
    }
    else if (indexPath.section == 2)
    {
        return CGSizeMake(NPWidth/3, NPWidth/3*31/25);
    }
    else if (indexPath.section == 5+self.productArray.count-2)
    {
        
        return CGSizeMake(NPWidth, TableViewControllerCell_Height);
    }
    else if (indexPath.section == 5+self.productArray.count-1)
    {
        return CGSizeMake(NPWidth/2, 200);
    }
    else
    {
        if (indexPath.row == 0) {
            return CGSizeMake(NPWidth, 154);
        }else {
            return CGSizeMake(NPWidth, NPWidth*56/73);
        }
    }
}

//定义每个Section 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (section == 0)
    {
        return UIEdgeInsetsMake(0, 0, 0, 0);//分别为上、左、下、右
    }
    else if (section == 1)
    {
        return UIEdgeInsetsMake(10, 0, 0, 0);
    }
    else if (section == 2)
    {
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }
    else
    {
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }
    
}

//每个section中不同的行之间的行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

//选择了某个cell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    
}
//每个item之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
    
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableView = nil;
    if (indexPath.section == 0) {
#pragma mark -- 定制头部视图的内容
        if (kind == UICollectionElementKindSectionHeader) {
            JXAhuiCollectionReusableView *headerV = (JXAhuiCollectionReusableView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kheaderIdentifier forIndexPath:indexPath];
            [self s_sdcycScrollview:headerV];
            reusableView = headerV;
        }
    }
    return reusableView;
}

//返回头headerView的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        CGSize size = CGSizeMake([[UIScreen mainScreen] bounds].size.width, 207);
        return size;
    }else {
        CGSize size = CGSizeMake(0, 0);
        return size;
    }
}

#pragma mark - SDCycleScrollViewDelegate 顶部轮播代理
- (void)s_sdcycScrollview:(UICollectionReusableView *)headervc {
    for (UIView *contes in headervc.subviews) {
        [contes removeFromSuperview];
    }
    CGFloat w = self.view.bounds.size.width;
    NSMutableArray *arrays = @[].mutableCopy;
    for (JXHomepagModel *modes in self.sd_imageArray) {
        [arrays addObject:[NSString stringWithFormat:@"%@%@",Image_Url,modes.imgs]];
    }
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, w, 207) shouldInfiniteLoop:YES imageNamesGroup:arrays];
    cycleScrollView.delegate = self;
    cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    [headervc addSubview:cycleScrollView];
    cycleScrollView.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    cycleScrollView.autoScrollTimeInterval = 5.0;
    cycleScrollView.pageControlDotSize = CGSizeMake(7, 7);
    cycleScrollView.pageControlBottomOffset = 8;
    UIView * whiteView = [[ShapedCard alloc]initWithFrame:CGRectZero];
    whiteView.clipsToBounds = YES;
    [cycleScrollView addSubview:whiteView];
    [cycleScrollView setBackgroundColor:[UIColor blackColor]];

}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    
    
}


#pragma mark --- 小轮播
#pragma mark --- 添加标题头动画轮播
- (void)animatSDScroller:(UIScrollView *)scrollView viewTag:(NSInteger)viewTag{
    
    [self selectViewAbout:scrollView];
    NewPagedFlowView *pageFlowView = [[NewPagedFlowView alloc] initWithFrame:CGRectMake(0, 0, NPWidth, 100)];
    pageFlowView.delegate = self;
    pageFlowView.dataSource = self;
    pageFlowView.minimumPageAlpha = 0.1;
    pageFlowView.isCarousel = YES;
    pageFlowView.orientation = NewPagedFlowViewOrientationHorizontal;
    pageFlowView.isOpenAutoScroll = YES;
    pageFlowView.leftRightMargin = 10;
    pageFlowView.topBottomMargin = 10;
    pageFlowView.tag = viewTag;
    [scrollView addSubview:pageFlowView];
    [pageFlowView reloadData];
}

- (void)selectViewAbout:(UIScrollView *)cell {
    for (UIView *contes in cell.subviews) {
        [contes removeFromSuperview];
    }
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark NewPagedFlowView Delegate
- (CGSize)sizeForPageInFlowView:(NewPagedFlowView *)flowView {
    return CGSizeMake(NPWidth - 30, 100);
}
- (void)didSelectCell:(UIView *)subView withSubViewIndex:(NSInteger)subIndex {
    
    NSLog(@"点击了第%ld张图",(long)subIndex + 1);
    
}

#pragma mark NewPagedFlowView Datasource
- (NSInteger)numberOfPagesInFlowView:(NewPagedFlowView *)flowView {
    
    if (self.secitionImageArray.count > flowView.tag) {
        NSArray *dateImage = self.secitionImageArray[flowView.tag];
        return [dateImage count];
    }
    return 0;
}

- (UIView *)flowView:(NewPagedFlowView *)flowView cellForPageAtIndex:(NSInteger)index{
    
    PGIndexBannerSubiew *bannerView = (PGIndexBannerSubiew *)[flowView dequeueReusableCell];
    if (!bannerView) {
        bannerView = [[PGIndexBannerSubiew alloc] initWithFrame:CGRectMake(0, 0, NPWidth, 100)];
        bannerView.tag = index;
        bannerView.layer.cornerRadius = 4;
        bannerView.layer.masksToBounds = YES;
    }
    NSArray *imagebanner = self.secitionImageArray[flowView.tag];
    NSMutableArray *imagebannerArray = @[].mutableCopy;
    for (NSDictionary *dicImage in imagebanner) {
        [imagebannerArray addObject:[NSString stringWithFormat:@"%@%@",Image_Url,dicImage[@"imgs"]]];
    }
    
    //在这里下载网络图片
    UIImage *cacheImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:imagebannerArray[index]];
    [bannerView.mainImageView setImage:cacheImage];
    [bannerView.mainImageView sd_setImageWithURL:[NSURL URLWithString:imagebannerArray[index]] placeholderImage:[UIImage imageNamed:@""]];
    return bannerView;
}

- (void)didScrollToPage:(NSInteger)pageNumber inFlowView:(NewPagedFlowView *)flowView {
    
    //    NSLog(@"ViewController 滚动到了第%ld页",(long)pageNumber);
}

#pragma mark --懒加载
- (NSMutableArray *)secitionImageArray {
    if (_secitionImageArray == nil) {
        _secitionImageArray = [NSMutableArray array];
    }
    return _secitionImageArray;
}
- (NSMutableArray *)sd_imageArray {
    if (_sd_imageArray == nil) {
        _sd_imageArray = [NSMutableArray array];
    }
    return _sd_imageArray;
}
- (NSMutableArray *)salespromotionArray {
    if (_salespromotionArray == nil) {
        _salespromotionArray = [NSMutableArray array];
    }
    return _salespromotionArray;
}
- (NSMutableArray *)productArray {
    if (_productArray == nil) {
        _productArray = [NSMutableArray array];
    }
    return _productArray;
}
- (NSMutableArray *)snapUpArray {
    if (_snapUpArray == nil) {
        _snapUpArray = [NSMutableArray array];
    }
    return _snapUpArray;
}
- (NSMutableArray *)bannerTitleArray {
    if (_bannerTitleArray == nil) {
        _bannerTitleArray = [NSMutableArray array];
    }
    return _bannerTitleArray;
}









@end
