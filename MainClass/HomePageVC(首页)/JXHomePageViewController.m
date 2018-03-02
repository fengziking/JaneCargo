//
//  JXHomePageViewController.m
//  JaneCargo
//
//  Created by 鹏 on 17/6/23.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXHomePageViewController.h"

#import "JXNewProductHomeCell.h"
// 产品分类
#import "JXClassificationTableViewCell.h"
// 手写代码
#import "MasonryTableViewCell.h"
#import "MasonryHomeTableViewCell.h"
// 广告轮播
#import "JXAdvertisingTableViewCell.h"
#import "NewPagedFlowView.h"
#import "PGIndexBannerSubiew.h"
// 促销标题
#import "JXPromotionTitleCell.h"
// 促销添加九宫
#import "JXPromotionTableViewCell.h"
#import "JXHomePageLayOut.h"
#import "JXHomePageCollectionViewController.h"
// model
#import "JXHomepagModel.h"
// 搜索
#import "JXGoodsSearchViewController.h"
#define NAVBAR_COLORCHANGE_POINT 0

#import "Base64.h"

// saoma
#import <AVFoundation/AVFoundation.h>
#import <SafariServices/SafariServices.h>

#import "JXSearchGoodViewController.h"
#import "JXIntegralVCViewController.h"
#import "JXAhuiViewController.h"
// 自定义导航
#import "DCHoverNavView.h"
#import "YYFPSLabel.h"

#import "JXOffNetTableViewCell.h"
#import "JXSalesCollectionViewController.h"
#import "JXWholesaleViewController.h"
@interface JXHomePageViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,SDCycleScrollViewDelegate,NewPagedFlowViewDelegate, NewPagedFlowViewDataSource,UITextFieldDelegate> {

    UITableView *tempTable;
    BOOL is_colorbool;
    BOOL is_dropdown;
    
}


@property (nonatomic, strong) JXSalesCollectionViewController *collecotiongy;
// 旋转
//@property (nonatomic, strong) UIView *loading;
@property (nonatomic, strong) JXRotating *loading;

// 自定义导航
@property (strong , nonatomic)DCHoverNavView *hoverNavView;
/* 滚回顶部按钮 */
@property (strong , nonatomic)UIButton *backTopButton;
// 顶部轮播
@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;
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

@property (nonatomic, strong) NSMutableArray *bannerImageArray;

@property (nonatomic, strong) UITextField *searchField;
@property (nonatomic, strong) UIView *transparentView;
@property (nonatomic, strong) UIButton *rightButton;
@end

@implementation JXHomePageViewController

static const CGFloat MJDuration = 0.5;
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


#pragma mark --- viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self layoutTempTable];
    [self httpsdatecache:NO refreshCache:YES];
    // 网络监测
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(havingNetworking:) name:@"AFNetworkReachabilityStatusYes" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushMessageAction:) name:@"PushMessage" object:nil];
}
-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
- (void)pushMessageAction:(NSNotification *)objc {
    
    [self messageItemClick];
}

#pragma mark - 自定义导航栏
- (void)setUpNav {
    
    _hoverNavView = [[DCHoverNavView alloc] init];
    [self.view insertSubview:_hoverNavView atIndex:1];
    _hoverNavView.frame = CGRectMake(0, 0, NPWidth, 64);
    [_hoverNavView leftAndrightImageleft:HomePageNavigationLeftImage right:HomePageNavigationRightImage];
    
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
    [_transparentView setAlpha:0.6];
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
- (void)settingItemClick {
    
}
#pragma mark - 消息
- (void)messageItemClick {
    
    JXPushMessageViewController *jxpush = [[JXPushMessageViewController alloc] init];
    [self.navigationController pushViewController:jxpush animated:YES];
}

- (void)setRightView {
    // 创建按钮
    _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_rightButton setImage:[UIImage imageNamed:HomePageSweepTheyardeImage] forState:UIControlStateNormal];
    [_rightButton sizeToFit];
    // 将imageView宽度
    _rightButton.frameWidth += 10;
    //居中
    _rightButton.contentMode = UIViewContentModeCenter;
  //  _searchField.rightView = _rightButton;
    //  注意：一定要设置，想要显示搜索框左边的视图，一定要设置左边视图的模式
  //  _searchField.rightViewMode = UITextFieldViewModeAlways;
   // [_rightButton addTarget:self action:@selector(sweepyardAction:) forControlEvents:(UIControlEventTouchUpInside)];
}
#pragma mark --- 扫码
- (void)sweepyardAction:(UIButton *)sender {
    
        
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
    if (offsetY > NAVBAR_COLORCHANGE_POINT)
    {
        [self navigationColor:[UIColor whiteColor] searchcolor:kUIColorFromRGB(0xf0f2f5) searchrightImage:HomePageNavigationRightImage_Black leftImage:HomePageNavigationLeftImage_Color rightImage:HomePageSweepTheyardeImage_Black];
    }
    else
    {
        [self navigationColor:[UIColor clearColor] searchcolor:[UIColor clearColor] searchrightImage:HomePageSweepTheyardeImage leftImage:HomePageNavigationLeftImage rightImage:HomePageNavigationRightImage];
    }
    // 下拉
    CGFloat contentOffset = scrollView.contentOffset.y;
    if (!is_dropdown && contentOffset < -60) {
        is_dropdown = YES;
        [self s_dropdownMJRefresh];
    }
}
// 导航
- (void)navigationColor:(UIColor *)color searchcolor:(UIColor *)searchcolor searchrightImage:(NSString *)image leftImage:(NSString *)lImage rightImage:(NSString *)rImage{

    [_hoverNavView setBackgroundColor:color];
    [_searchField setBackgroundColor:searchcolor];
    [_rightButton setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [_hoverNavView leftAndrightImageleft:lImage right:rImage];
}


- (void)setUpScrollToTopView {
    
    _backTopButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:_backTopButton];
    [_backTopButton addTarget:self action:@selector(ScrollToTop) forControlEvents:UIControlEventTouchUpInside];
    [_backTopButton setImage:[UIImage imageNamed:PlacedAtTheTop] forState:UIControlStateNormal];
    _backTopButton.hidden = YES;
    _backTopButton.frame = CGRectMake(NPWidth - 50, NPHeight - 110, 40, 40);
    [_backTopButton.layer setMasksToBounds:true];
    [_backTopButton.layer setCornerRadius:20];
    [_backTopButton.layer setBorderWidth:0.5];
    [_backTopButton.layer setBorderColor:[kUIColorFromRGB(0xe3e3e3) CGColor]];
}
#pragma mark - collectionView滚回顶部
- (void)ScrollToTop
{
    [tempTable scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
}
#pragma mark 实时检测网络
-(void)havingNetworking:(NSNotification *)isNetWorking {
    NSString *sender = isNetWorking.object;
    if (![sender boolValue]) { // 无网
        [self navigationColor:[UIColor whiteColor] searchcolor:kUIColorFromRGB(0xf0f2f5) searchrightImage:HomePageNavigationRightImage_Black leftImage:HomePageNavigationLeftImage_Color rightImage:HomePageSweepTheyardeImage_Black];
    }else {
        [self navigationColor:[UIColor clearColor] searchcolor:[UIColor clearColor] searchrightImage:HomePageSweepTheyardeImage leftImage:HomePageNavigationLeftImage rightImage:HomePageNavigationRightImage];
    }
}


- (void)layoutTempTable {
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    tempTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, NPWidth, NPHeight-49)];
    tempTable.separatorStyle = UITableViewCellEditingStyleNone;
    tempTable.delegate = self;
    tempTable.dataSource = self;
    tempTable.backgroundColor = kUIColorFromRGB(0xf2f2f2);
    [tempTable setShowsVerticalScrollIndicator:NO];
    [tempTable registerClass:[JXClassificationTableViewCell class] forCellReuseIdentifier:@"class"];
    [tempTable registerClass:[JXPromotionTableViewCell class] forCellReuseIdentifier:@"pros"];
    [tempTable registerClass:[MasonryTableViewCell class] forCellReuseIdentifier:@"masonry_y"];
    [tempTable registerClass:[MasonryHomeTableViewCell class] forCellReuseIdentifier:@"masonry_cy"];
    [self.view addSubview:tempTable];
    [self setUpScrollToTopView];
    [self setUpNav];
    if (@available(iOS 11.0, *)) {
        tempTable.contentInsetAdjustmentBehavior =UIScrollViewContentInsetAdjustmentNever;
        tempTable.contentInset =UIEdgeInsetsMake(0,0,64,0);//64和49自己看效果，是否应该改成0
        tempTable.scrollIndicatorInsets =tempTable.contentInset;
    }
}

- (void)httpsdatecache:(BOOL)cache refreshCache:(BOOL)refreshCache{
    
    self.loading = [JXRotating initWithRotaing];
    [self.view addSubview:self.loading];
    @weakify(self);
        // 处理耗时操作的代码块...
        [JXNetworkRequest asyncHomePageIs_Cache:cache refreshCache:refreshCache completed:^(NSDictionary *messagedic) {
            @strongify(self);
            [tempTable setScrollEnabled:YES];
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
                
                self.bannerImageArray = @[].mutableCopy;
                for (NSDictionary *bannerdic in infoArray) {
                    [self.bannerImageArray addObject:[NSString stringWithFormat:@"%@%@",Image_Url,bannerdic[@"imgs"]]];
                }
                [self.secitionImageArray addObject:self.bannerImageArray];
            }
            // 抢购
            NSArray *snapArray = messagedic[@"info"][@"qggood"][@"info"];
            for (NSDictionary *snapdic in snapArray) {
                JXHomepagModel *model = [JXHomepagModel alloc];
                [model setValuesForKeysWithDictionary:snapdic];
                [self.snapUpArray addObject:model];
            }
            [self s_sdcycScrollview];
            [tempTable reloadData];
           
         } statisticsFail:^(NSDictionary *messagedic) {

        } fail:^(NSError *error) {

        }];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if (self.productArray.count == 0) {
        return 1;
    }else {
        return 4+self.productArray.count;
    }
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 1;
    }else if (section == 1) {
        return 1;
    }else if (section == 4+self.productArray.count-2) {
        return 1;
    }else if (section == 4+self.productArray.count-1) {
        return 1;
    }else {
        return 2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (self.productArray.count == 0) {
        
        JXOffNetTableViewCell *cell = [JXOffNetTableViewCell cellWithTable];
        [tempTable setScrollEnabled:NO];
        cell.UpdateRequest = ^{
           [self httpsdatecache:YES refreshCache:YES];
        };
        return cell;
    }else {
        if (indexPath.section == 0)
        { // 新品
//            JXNewProductHomeCell *cell = [JXNewProductHomeCell cellWithTable];
//            [cell setSelectionStyle:(UITableViewCellSelectionStyleNone)];
//            [self cellForNewGood:cell indexPath:indexPath];
//            return cell;
            JXClassificationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"class" forIndexPath:indexPath];
            [cell setSelectionStyle:(UITableViewCellSelectionStyleNone)];
            cell.ification = ^(NSInteger typebutton) {
                [self clickIfication:typebutton];
            };
            return cell;
        }
        else if(indexPath.section == 1)
        { // 抢购
            MasonryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"masonry_y" forIndexPath:indexPath];
            [self toSnapupcell:cell indexPath:indexPath];
            [cell setBackgroundColor:kUIColorFromRGB(0xffffff)];
            [cell setSelectionStyle:(UITableViewCellSelectionStyleNone)];
            return cell;
        }
        else if(indexPath.section == 4+self.productArray.count-2)
        { // 促销广告
            JXPromotionTitleCell *cell = [JXPromotionTitleCell cellWithTable];
            [cell setBackgroundColor:kUIColorFromRGB(0xf2f2f2)];
            cell.gradientLabel.text = @"促销产品";
            return cell;
        }
        else if(indexPath.section == 4+self.productArray.count-1)
        { // 促销
            JXPromotionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"pros" forIndexPath:indexPath];
            [JXEncapSulationObjc selectViewAbout:cell];
            [self showPromotion:cell];
            [cell setSelectionStyle:(UITableViewCellSelectionStyleNone)];
            return cell;
        }
        else
        { // 广告轮播  第三个分区开始计算 section = 2
            
            if (indexPath.row%2 == 0 && indexPath.row<self.productArray.count)
            {  // 轮播图
                JXAdvertisingTableViewCell *cell = [JXAdvertisingTableViewCell cellwithTable];
                [self littleShuffling:cell indexPath:indexPath];
                [cell setSelectionStyle:(UITableViewCellSelectionStyleNone)];
                [cell setBackgroundColor:kUIColorFromRGB(0xf2f2f2)];
                return cell;
            }
            else
            {  // 内容 MasonryHomeTableViewCell
                MasonryHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"masonry_cy" forIndexPath:indexPath];
                [self waterfallFlow:cell indexPath:indexPath];
                [cell setSelectionStyle:(UITableViewCellSelectionStyleNone)];
                [cell setBackgroundColor:kUIColorFromRGB(0xf2f2f2)];
                return cell;
            }
        }
    }
}
#pragma mark --- cell处理
// 新品
- (void)cellForNewGood:(JXNewProductHomeCell *)cell indexPath:(NSIndexPath *)indexPath{

    cell.ification = ^(NSInteger typebutton) {
        [self clickIfication:typebutton];
    };
}

// 抢购
- (void)toSnapupcell:(MasonryTableViewCell *)cell indexPath:(NSIndexPath *)indexPath{

    NSMutableArray *goods_idArray = @[].mutableCopy;
    if (self.snapUpArray.count>0)
    {
        NSInteger type_models = 0;
        for (JXHomepagModel *model in self.snapUpArray) {
            model.type_model = type_models;
            [cell setModel:model];
            [goods_idArray addObject:model];
            type_models++;
        }
    }
    // 点击更多进入级惠
    __weak typeof(self)root = self;
    cell.morebt = ^{
        JXAhuiViewController *ahui = [[JXAhuiViewController alloc] init];
        [root.navigationController pushViewController:ahui animated:YES];
    };
    cell.goodbk = ^(NSInteger type) {
        if (goods_idArray.count > 0) {
            [JXPodOrPreVc buyGoodsModel:goods_idArray[type] navigation:root.navigationController];
        }
    };
}

// 小广告轮播
- (void)littleShuffling:(JXAdvertisingTableViewCell *)cell indexPath:(NSIndexPath *)indexPath{

    JXHomepagModel *model;
    if (self.productArray.count>0) {
        model = self.productArray[indexPath.section-2];
    }
    // -2从0开始计算
    [self animatSDScroller:cell.sdScrollView viewTag:indexPath.section-2];
    // 传数据
    [cell setModel:model];
}

// 不规则的6个图片
- (void)waterfallFlow:(MasonryHomeTableViewCell *)cell indexPath:(NSIndexPath *)indexPath {

    // 取出对应的数据
//    JXHomepagModel *mode = self.productArray[indexPath.section-2];
    JXHomepagModel *mode;
    if (self.productArray.count>0) {
        mode = self.productArray[indexPath.section-2];
    }
    [cell setModel:mode];
    __weak typeof(self)root = self;
    NSArray *infoArray = mode.good[@"info"];
    cell.Imageblock = ^(NSInteger type,JXHomepagModel *model) {
        if (type == 5) { // 更多产品
            JXSearchGoodViewController *searchgoods = [[JXSearchGoodViewController alloc] init];
            searchgoods.is_NewProduct = mode.name;
            searchgoods.retweetType = 3;
            searchgoods.goods_id = [NSString stringWithFormat:@"%@",mode.id];
            [self.navigationController pushViewController:searchgoods animated:YES];
            
        }else {
            NSDictionary *good_iddic = infoArray[type];
            JXHomepagModel *goodid_mode = [[JXHomepagModel alloc] init];
            [goodid_mode setValuesForKeysWithDictionary:good_iddic];
            [JXPodOrPreVc buyGoodsModel:goodid_mode navigation:root.navigationController];
        }
    };
}

#pragma mark --- 添加标题头动画轮播
- (void)animatSDScroller:(UIScrollView *)scrollView viewTag:(NSInteger)viewTag{
    
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


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark NewPagedFlowView Delegate
- (CGSize)sizeForPageInFlowView:(NewPagedFlowView *)flowView {
    return CGSizeMake(NPWidth - 14-10, 100);
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
    if (self.secitionImageArray.count>0) {
        NSArray *imagebanner = self.secitionImageArray[flowView.tag];
        //在这里下载网络图片
        UIImage *cacheImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:imagebanner[index]];
        [bannerView.mainImageView setImage:cacheImage];
        [bannerView.mainImageView sd_setImageWithURL:[NSURL URLWithString:imagebanner[index]] placeholderImage:[UIImage imageNamed:@"img_栏目图加载"]];
    }
    return bannerView;
}

- (void)didScrollToPage:(NSInteger)pageNumber inFlowView:(NewPagedFlowView *)flowView {
    
//    NSLog(@"ViewController 滚动到了第%ld页",(long)pageNumber);
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.productArray.count == 0)
    {
        return NPHeight;
    }
    else
    {
        if (indexPath.section == 0)
        {
            return 90;
        }
        else if (indexPath.section == 1)
        {
            return NPWidth/3*19/25+44+9+12+12+30;
        }
        else if (indexPath.section == 4+self.productArray.count-2)
        { // 促销广告
            return TableViewControllerCell_Height;
        }
        else if (indexPath.section == 4+self.productArray.count-1)
        { // 促销产品
            NSInteger line = [JXEncapSulationObjc s_calculateNumberArrayNum:self.salespromotionArray.count singleNumber:2];
            return line * BranchOrder_Collection_Height;
        }
        else
        {
            if (indexPath.row%2 == 0)
            {
                return 154;
            }
            else
            {
                return NPWidth*56/73;
            }
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}
// 头部高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    if (self.productArray.count == 0) {
        return 0;
    }else {
        if (section == 1)return 10;
        return 0;
    }
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    UIView *header = [[UIView alloc] init];
    if (self.productArray.count == 0) {
         [header setFrame:CGRectMake(0, 0, 0, 0)];
    }else {
        if (section == 1) {
            [header setFrame:CGRectMake(0, 0, 0, 10)];
        }else {
            [header setFrame:CGRectMake(0, 0, 0, 0)];
        }
    }
    [header setBackgroundColor:kUIColorFromRGB(0xf2f2f2)];
    return header;
}



#pragma mark - SDCycleScrollViewDelegate 轮播代理
- (void)s_sdcycScrollview {
    
    [self.cycleScrollView removeFromSuperview];
    CGFloat w = self.view.bounds.size.width;
    NSMutableArray *arrays = @[].mutableCopy;
    for (JXHomepagModel *modes in self.sd_imageArray) {
        KDLOG(@"%@",[NSString stringWithFormat:@"%@%@",Image_Url,modes.imgs]);
        [arrays addObject:[NSString stringWithFormat:@"%@%@",Image_Url,modes.imgs]];
    }
    self.cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, w, 207) delegate:self placeholderImage:[UIImage imageNamed:@"img_图片加载"]];
    self.cycleScrollView.localizationImageNamesGroup = arrays;
    self.cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    tempTable.tableHeaderView = self.cycleScrollView;
    self.cycleScrollView.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.cycleScrollView.autoScrollTimeInterval = 5.0;
    self.cycleScrollView.pageControlDotSize = CGSizeMake(7, 7);
    self.cycleScrollView.pageControlBottomOffset = 8;
    
    UIView * whiteView = [[ShapedCard alloc]initWithFrame:CGRectZero];
    whiteView.clipsToBounds = YES;
     [self.cycleScrollView addSubview:whiteView];
    [self.cycleScrollView setBackgroundColor:[UIColor whiteColor]];
    
}
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    
    
}

#pragma mark -- 商品点击事件
- (void)clickIfication:(NSInteger)type {

    if (type == 0) {  // 新品
        JXSearchGoodViewController *searchgoods = [[JXSearchGoodViewController alloc] init];
        searchgoods.is_NewProduct = @"新品";
        searchgoods.retweetType = 0;
        [self.navigationController pushViewController:searchgoods animated:YES];
    }
    if (type == 1) {  // 热销
        JXSearchGoodViewController *searchgoods = [[JXSearchGoodViewController alloc] init];
        searchgoods.is_NewProduct = @"热销";
        searchgoods.retweetType = 1;
        [self.navigationController pushViewController:searchgoods animated:YES];
    }
    if (type == 2) {   // 极惠商品
        JXAhuiViewController *ahui = [[JXAhuiViewController alloc] init];
        [self.navigationController pushViewController:ahui animated:YES];
    }
    if (type == 3) {   // 批发商品
        JXWholesaleViewController *wholes = [[JXWholesaleViewController alloc] init];
        [self.navigationController pushViewController:wholes animated:YES];
    }
}


#pragma mark -- 展示促销产品
- (void)showPromotion:(UITableViewCell *)cell {

//    [JXPodOrPreVc recommendednumberArray:self.salespromotionArray.count lines:2 datearray:self.salespromotionArray viewController:self tablecell:cell];
    
    [self.collecotiongy willMoveToParentViewController:nil];
    [self.collecotiongy.view removeFromSuperview];
    [self.collecotiongy removeFromParentViewController];
    NSInteger line = [JXEncapSulationObjc s_calculateNumberArrayNum:self.salespromotionArray.count singleNumber:2];
    JXHomePageLayOut *gylay = [[JXHomePageLayOut alloc] init];
    self.collecotiongy = [[JXSalesCollectionViewController alloc] initWithCollectionViewLayout:gylay];
    [self.collecotiongy.view setFrame:CGRectMake(0, 0, NPWidth, line * BranchOrder_Collection_Height)];
    self.collecotiongy.recommendedArray = [NSArray arrayWithArray:self.salespromotionArray];
    self.collecotiongy.childcontroller = @"哈哈";
    [self addChildViewController:self.collecotiongy];
    [cell addSubview:self.collecotiongy.view];
    [self.collecotiongy didMoveToParentViewController:self.collecotiongy];

}


#pragma mark UITableView + 下拉刷新 默认
- (void)s_dropdownMJRefresh { // dropdown
    __unsafe_unretained __typeof(self) weakSelf = self;
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    tempTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadNewData];
    }];
    // 马上进入刷新状态
    [tempTable.mj_header beginRefreshing];
}
- (void)loadNewData {
    
    [self.sd_imageArray removeAllObjects];
    [self.secitionImageArray removeAllObjects];
    [self.bannerTitleArray removeAllObjects];
    [self.salespromotionArray removeAllObjects];
    [self.productArray removeAllObjects];
    [self.snapUpArray removeAllObjects];
    // 直接控制下拉时间避免等待时间过长
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(MJDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self httpsdatecache:NO refreshCache:YES];
        [self endofthedropdown];
    });
}
#pragma mark -- 下拉结束
- (void)endofthedropdown {
    // 拿到当前的下拉刷新控件，结束刷新状态
    [tempTable.mj_header endRefreshing];
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
