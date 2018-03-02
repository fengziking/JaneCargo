//
//  JXSearchGoodViewController.m
//  JaneCargo
//
//  Created by 鹏 on 2017/7/13.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXSearchGoodViewController.h"


#import "JXComprehensiveView.h"
#import "JXSearchgoodCollectionViewCell.h"
#import "JXGoodsTiedCollectionViewCell.h"
static NSString *kcellIdentifier = @"collectionCellID";
static NSString *gcellIdentifier = @"collectionCellIDg";
@interface JXSearchGoodViewController ()<UISearchBarDelegate,UIScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout> {

    BOOL isLayoutbool;
    BOOL is_dropdown;
    
}

@property (nonatomic, assign) NSInteger is_pagIndex;
// 排序
@property (nonatomic, assign) NSInteger is_assess;
@property (nonatomic, assign) NSInteger is_new_type;
@property (nonatomic, strong) NSString *is_buy_num;    // 销量
@property (nonatomic, strong) NSString *is_good_price; // 价格

// 遮罩
//@property (nonatomic, strong) ShowMaskView *showmask;

@property (weak, nonatomic) IBOutlet UIView *headerView;

/** 搜索框*/
@property(strong,nonatomic) UISearchBar *searchBar;
/** 占位文字*/
@property(copy,nonatomic) NSString *placeHolder;
@property (weak, nonatomic) IBOutlet UICollectionView *goodsSearchCollection;

// 综合
@property (weak, nonatomic) IBOutlet UILabel *comprehensiveLabel;
@property (weak, nonatomic) IBOutlet UIImageView *comprehensiveImage;
@property (weak, nonatomic) IBOutlet UIButton *comprehensivebutton;
// 销量
@property (weak, nonatomic) IBOutlet UILabel *salesLabel;
@property (weak, nonatomic) IBOutlet UIImageView *salesImage;
@property (weak, nonatomic) IBOutlet UIButton *salesButton;

// 价格
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *priceImage;
@property (weak, nonatomic) IBOutlet UIButton *priceButton;

// 布局
@property (weak, nonatomic) IBOutlet UIView *lines;
@property (weak, nonatomic) IBOutlet UIImageView *collectionImage;
@property (weak, nonatomic) IBOutlet UIButton *collectionbutton;


// 新品
@property (nonatomic, strong) NSMutableArray *newdateArray;
// 更多
@property (nonatomic, strong) NSMutableArray *goodsArrays;
// 搜索
@property (nonatomic, strong) NSMutableArray *searchgoodArrays;
// 热销
@property (nonatomic, strong) NSMutableArray *hotcakesArrays;

@end

@implementation JXSearchGoodViewController
static const CGFloat MJDuration = 0.5;

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [JXEncapSulationObjc blackNavigation:self color:[UIColor whiteColor]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.is_pagIndex = 1;
    self.is_buy_num = nil;
    self.is_good_price = nil;
    self.goodsArrays = @[].mutableCopy;
    self.newdateArray = @[].mutableCopy;
    self.hotcakesArrays = @[].mutableCopy;
    self.searchgoodArrays = @[].mutableCopy;
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self goodsNavigate];
    [self goodsCollection];
    // 默认选中综合
    [_comprehensiveImage setImage:[UIImage imageNamed:@"icon_筛选向下_selected"]];
    [self changeColorRed:_comprehensiveLabel whitelabel:_salesLabel swhitelabel:_priceLabel twhitelabel:nil];
}


- (void)goodsNavigate {
    
    isLayoutbool = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    
    switch (_retweetType) {
        case WBStatusNewGood: { ///< 新品
        
            [self request_dateNewgoodsbuy_num:nil good_price:nil page:[NSString stringWithFormat:@"%ld",self.is_pagIndex]];
        }
            break;
        case WBStatusHotCakes: { ///< 热销
            
            [self request_dateHotCakesbuy_num:nil good_price:nil page:[NSString stringWithFormat:@"%ld",self.is_pagIndex]];
        }
            break;
        case WBStatusSearch: { ///< 搜索
            
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.searchBar];
            self.searchBar.text = _searchStr;
          //  [self searchResultskeywords:_searchStr pagNumber:self.is_pagIndex ordernum:0 orderprice:0];
        }
            break;
        case WBStatusMore: { ///< 更多
            [self request_datebuy_num:nil good_price:nil page:[NSString stringWithFormat:@"%ld",self.is_pagIndex]];
            
        }
            break;
        default:
            break;
    }
    if (_retweetType!=WBStatusSearch) {
        UILabel * titleLabel =[[UILabel alloc]init];
        titleLabel.text = _is_NewProduct;
        [titleLabel sizeToFit];
        titleLabel.textColor = [UIColor blackColor];
        self.navigationItem.titleView = titleLabel;
        
    }
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_back"] style:(UIBarButtonItemStylePlain) target:self action:@selector(leftAction:)];
}

#pragma mark -- 热销
- (void)request_dateHotCakesbuy_num:(NSString *)buy_num good_price:(NSString *)good_price page:(NSString *)page{
    
    
    [JXNetworkRequest asynchotCakesbuy_num:buy_num good_price:good_price page:page completed:^(NSDictionary *messagedic) {
        NSArray *infoArray = messagedic[@"info"];
        for (NSDictionary *infodic in infoArray)
        {
            JXHomepagModel *model = [[JXHomepagModel alloc] init];
            [model setValuesForKeysWithDictionary:infodic];
            [self.hotcakesArrays addObject:model];
        }
        _dateArray = [NSMutableArray arrayWithArray:self.hotcakesArrays];
        [self endofthedropdown];
        [self endofthepulldown];
        [self.goodsSearchCollection reloadData];
    } statisticsFail:^(NSDictionary *messagedic) {
        [self endofthedropdown];
        [self endofthepulldown];
    } fail:^(NSError *error) {
        [self endofthedropdown];
        [self endofthepulldown];
    }];
    
}

#pragma mark -- 新品
- (void)request_dateNewgoodsbuy_num:(NSString *)buy_num good_price:(NSString *)good_price page:(NSString *)page {
    
    
    [JXNetworkRequest asyncNewGoodbuy_num:buy_num good_price:good_price page:page completed:^(NSDictionary *messagedic) {
        NSArray *infoArray = messagedic[@"info"];
        for (NSDictionary *infodic in infoArray)
        {
            JXHomepagModel *model = [[JXHomepagModel alloc] init];
            [model setValuesForKeysWithDictionary:infodic];
            [self.newdateArray addObject:model];
        }
        _dateArray = [NSMutableArray arrayWithArray:self.newdateArray];
        [self endofthedropdown];
        [self endofthepulldown];
        [self.goodsSearchCollection reloadData];
    } statisticsFail:^(NSDictionary *messagedic) {
        [self endofthedropdown];
        [self endofthepulldown];
    } fail:^(NSError *error) {
        [self endofthedropdown];
        [self endofthepulldown];
    }];
}
#pragma mark -- 更多
- (void)request_datebuy_num:(NSString *)buy_num good_price:(NSString *)good_price page:(NSString *)page{

    
    [JXNetworkRequest asyncMoreGoodsid:_goods_id buy_num:buy_num good_price:good_price page:page completed:^(NSDictionary *messagedic) {
        
        NSArray *infoArray = messagedic[@"info"];
        for (NSDictionary *infodic in infoArray)
        {
            JXHomepagModel *model = [[JXHomepagModel alloc] init];
            [model setValuesForKeysWithDictionary:infodic];
            [self.goodsArrays addObject:model];
        }
        _dateArray = [NSMutableArray arrayWithArray:self.goodsArrays];
        [self endofthedropdown];
        [self endofthepulldown];
        [self.goodsSearchCollection reloadData];
    } statisticsFail:^(NSDictionary *messagedic) {
        [self endofthedropdown];
        [self endofthepulldown];
    } fail:^(NSError *error) {
        [self endofthedropdown];
        [self endofthepulldown];
    }];

}
#pragma mark -- 搜索刷新
- (void)searchResultskeywords:(NSString *)keywords pagNumber:(NSInteger)pagNumber ordernum:(NSInteger)ordernum orderprice:(NSInteger)orderprice{
    
    
    
    [JXNetworkRequest asyncSearchGoodkeywords:keywords pagNumber:pagNumber ordernum:ordernum orderprice:orderprice is_Cache:NO refreshCache:NO completed:^(NSDictionary *messagedic) {
        NSArray *infoArray = messagedic[@"info"];
        for (NSDictionary *infodic in infoArray) {
            JXHomepagModel *model = [[JXHomepagModel alloc] init];
            [model setValuesForKeysWithDictionary:infodic];
            [self.searchgoodArrays addObject:model];
        }
        _dateArray = [NSMutableArray arrayWithArray:self.searchgoodArrays];
        [self endofthedropdown];
        [self endofthepulldown];
        [self.goodsSearchCollection reloadData];
    } statisticsFail:^(NSDictionary *messagedic) {
        [self endofthedropdown];
        [self endofthepulldown];
        [self showHint:messagedic[@"msg"]];
    } fail:^(NSError *error) {
        [self endofthedropdown];
        [self endofthepulldown];
    }];
}

#pragma mark -- 搜索代理
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)leftAction:(UIBarButtonItem *)sender {
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}


- (void)removeData {

    [self.newdateArray removeAllObjects];
    [self.searchgoodArrays removeAllObjects];
    [self.goodsArrays removeAllObjects];
    [self.hotcakesArrays removeAllObjects];
}

#pragma mark --- 点击四个按钮排序
- (IBAction)comprehensiveAction:(UIButton *)sender {
    
    [self removeData];
    [self changeColorRed:_comprehensiveLabel whitelabel:_salesLabel swhitelabel:_priceLabel twhitelabel:nil];
    [_comprehensiveImage setImage:[UIImage imageNamed:@"icon_筛选向下_selected"]]; // icon_筛选向下
    [_salesImage setImage:[UIImage imageNamed:@"icon_价格筛选"]];
    [_priceImage setImage:[UIImage imageNamed:@"icon_价格筛选"]];
    if (sender.selected) {
        
        self.is_buy_num = nil;
        self.is_good_price = nil;
        _is_assess = 0;
        _is_new_type = 0;
        
    }else {
        
        self.is_buy_num = nil;
        self.is_good_price = nil;
        _is_assess = 0;
        _is_new_type = 0;
    }
    switch (_retweetType) {
        case WBStatusNewGood: { ///< 新品
            
            [self request_dateNewgoodsbuy_num:nil good_price:nil page:[NSString stringWithFormat:@"%ld",self.is_pagIndex]];
        }
            break;
        case WBStatusHotCakes: { ///< 热销
            
            [self request_dateHotCakesbuy_num:nil good_price:nil page:[NSString stringWithFormat:@"%ld",self.is_pagIndex]];
        }
            break;
        case WBStatusSearch: { ///< 搜索
            
            [self searchResultskeywords:_searchStr pagNumber:self.is_pagIndex ordernum:0 orderprice:0];
        }
            break;
        case WBStatusMore: { ///< 更多
            
            [self request_datebuy_num:nil good_price:nil page:[NSString stringWithFormat:@"%ld",self.is_pagIndex]];
        }
            break;
        default:
            break;
    }
}


- (IBAction)salesButton:(UIButton *)sender {
    
    [self removeData];
    [self changeColorRed:_salesLabel whitelabel:_comprehensiveLabel swhitelabel:_priceLabel twhitelabel:nil];
    sender.selected = !sender.selected;
    if (sender.selected) {
        [_salesImage setImage:[UIImage imageNamed:@"icon_价格筛选_倒序"]];
        self.is_buy_num = @"2";
        self.is_good_price = nil;
        _is_assess = 2;
        _is_new_type = 0;
        
    }else {
        [_salesImage setImage:[UIImage imageNamed:@"icon_价格筛选_升序"]];
        self.is_buy_num = @"1";
        self.is_good_price = nil;
        _is_assess = 1;
        _is_new_type = 0;
     }
    switch (_retweetType) {
        case WBStatusNewGood: { ///< 新品
            [self request_dateNewgoodsbuy_num:self.is_buy_num good_price:self.is_good_price page:[NSString stringWithFormat:@"%ld",self.is_pagIndex]];
        }
            break;
        case WBStatusHotCakes: { ///< 热销
            [self request_dateHotCakesbuy_num:self.is_buy_num good_price:self.is_good_price page:[NSString stringWithFormat:@"%ld",self.is_pagIndex]];
        }
            break;
        case WBStatusSearch: { ///< 搜索
            [self searchResultskeywords:_searchStr pagNumber:self.is_pagIndex ordernum:1 orderprice:0];
        }
            break;
        case WBStatusMore: { ///< 更多
            [self request_datebuy_num:self.is_buy_num good_price:self.is_good_price page:[NSString stringWithFormat:@"%ld",self.is_pagIndex]];
        }
            break;
        default:
            break;
    }
    [_comprehensiveImage setImage:[UIImage imageNamed:@"icon_筛选向下"]];
    [_priceImage setImage:[UIImage imageNamed:@"icon_价格筛选"]];
    
}

- (IBAction)priceAction:(UIButton *)sender {
    
    [self removeData];
    [self changeColorRed:_priceLabel whitelabel:_salesLabel swhitelabel:_comprehensiveLabel twhitelabel:nil];
    sender.selected = !sender.selected;
    if (sender.selected) {
        [_priceImage setImage:[UIImage imageNamed:@"icon_价格筛选_倒序"]];
        self.is_buy_num = nil;
        self.is_good_price = @"2";
        _is_assess = 0;
        _is_new_type = 2;
        
    }else {
        [_priceImage setImage:[UIImage imageNamed:@"icon_价格筛选_升序"]];
        self.is_buy_num = nil;
        self.is_good_price = @"1";
        _is_assess = 0;
        _is_new_type = 1;
     }
    switch (_retweetType) {
        case WBStatusNewGood: { ///< 新品
            [self request_dateNewgoodsbuy_num:self.is_buy_num good_price:self.is_good_price page:[NSString stringWithFormat:@"%ld",self.is_pagIndex]];
        }
            break;
        case WBStatusHotCakes: { ///< 热销
            [self request_dateHotCakesbuy_num:self.is_buy_num good_price:self.is_good_price page:[NSString stringWithFormat:@"%ld",self.is_pagIndex]];
        }
            break;
        case WBStatusSearch: { ///< 搜索
            [self searchResultskeywords:_searchStr pagNumber:self.is_pagIndex ordernum:_is_assess orderprice:_is_new_type];
        }
            break;
        case WBStatusMore: { ///< 更多
            [self request_datebuy_num:self.is_buy_num good_price:self.is_good_price page:[NSString stringWithFormat:@"%ld",self.is_pagIndex]];
        }
            break;
        default:
            break;
    }
    
    [_comprehensiveImage setImage:[UIImage imageNamed:@"icon_筛选向下"]];
    [_salesImage setImage:[UIImage imageNamed:@"icon_价格筛选"]];
}

- (IBAction)collectionAction:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    if (sender.selected) {
        isLayoutbool = YES;
        [_collectionImage setImage:[UIImage imageNamed:@"icon_切换竖排"]];
    }else {
        isLayoutbool = NO;
        [_collectionImage setImage:[UIImage imageNamed:@"icon_切换横排"]];
    }
    [self.goodsSearchCollection reloadData];
}


#pragma mark -- 改变颜色
- (void)changeColorRed:(UILabel *)redlabel whitelabel:(UILabel *)whiteLabel swhitelabel:(UILabel *)swhiteLabel twhitelabel:(UILabel *)twhitelabel{

    [redlabel setTextColor:[UIColor redColor]];
    [whiteLabel setTextColor:[UIColor blackColor]];
    [swhiteLabel setTextColor:[UIColor blackColor]];
    [twhitelabel setTextColor:[UIColor blackColor]];
}


#pragma mark ---- collection
- (void)goodsCollection {
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.goodsSearchCollection.dataSource = self;
    self.goodsSearchCollection.delegate = self;
    [self.goodsSearchCollection registerNib:[UINib nibWithNibName:NSStringFromClass([JXSearchgoodCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:kcellIdentifier];
    [self.goodsSearchCollection registerNib:[UINib nibWithNibName:NSStringFromClass([JXGoodsTiedCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:gcellIdentifier];
    
    if (@available(iOS 11.0, *)) {
        self.goodsSearchCollection.contentInsetAdjustmentBehavior =UIScrollViewContentInsetAdjustmentNever;
        self.goodsSearchCollection.contentInset =UIEdgeInsetsMake(0,0,0,0);//64和49自己看效果，是否应该改成0
        self.goodsSearchCollection.scrollIndicatorInsets =self.goodsSearchCollection.contentInset;
    }
    
}

#pragma mark -CollectionView datasource
//section
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
//item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.dateArray.count;
    
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (!isLayoutbool) {
        JXGoodsTiedCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:gcellIdentifier forIndexPath:indexPath];
        
        if (self.dateArray.count>0) {
            JXHomepagModel *model = self.dateArray[indexPath.row];
            [cell setModel:model];
        }
       
        return cell;
    }else { // 一排
        JXSearchgoodCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kcellIdentifier forIndexPath:indexPath];
        
        if (self.dateArray.count>0) {
            JXHomepagModel *model = self.dateArray[indexPath.row];
            [cell setModel:model];
        }
        
        return cell;
    }
}

//定义每个UICollectionViewCell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (!isLayoutbool) {

        return CGSizeMake(self.goodsSearchCollection.frame.size.width/2, 16*self.goodsSearchCollection.frame.size.width/2/15);
    }else { // 一排
        return CGSizeMake(NPWidth, 114);
        
    }
    
    
}
//定义每个Section 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    
    if (!isLayoutbool) {
        return UIEdgeInsetsMake(0, 0, 0, 0);//分别为上、左、下、右
    }else { // 一排
        return UIEdgeInsetsMake(0, 0, 0, 0);//分别为上、左、下、右
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

    JXHomepagModel *model = self.dateArray[indexPath.row];
    [JXPodOrPreVc hiddenTabbarbuyGoodsModel:model navigation:self.navigationController];
    
}
//每个item之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }
    return 10;
}

#pragma mark --
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat contentOffset = scrollView.contentOffset.y;
    if (!is_dropdown && contentOffset < -60) {
        is_dropdown = YES;
        [self s_dropdownMJRefresh];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    if (self.goodsSearchCollection.contentOffset.y>self.goodsSearchCollection.contentSize.height-self.goodsSearchCollection.frame.size.height-64) {
        [self s_pullMJRefresh];
    }
}


#pragma mark UITableView + 下拉刷新 默认
- (void)s_dropdownMJRefresh { // dropdown
    __unsafe_unretained __typeof(self) weakSelf = self;
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.goodsSearchCollection.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadNewData];
        
    }];
    // 马上进入刷新状态
    [self.goodsSearchCollection.mj_header beginRefreshing];
}
- (void)loadNewData {
    self.is_pagIndex = 1;
    
    [self.newdateArray removeAllObjects];
    [self.searchgoodArrays removeAllObjects];
    [self.goodsArrays removeAllObjects];
    [self.hotcakesArrays removeAllObjects];
    // 刷新过程中停止交互
    self.goodsSearchCollection.scrollEnabled = NO;
    // 刷新表格
    
    // 直接控制下拉时间避免等待时间过长
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(MJDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        switch (_retweetType) {
            case WBStatusNewGood: { ///< 新品
                
               [self request_dateNewgoodsbuy_num:self.is_buy_num good_price:self.is_good_price page:[NSString stringWithFormat:@"%ld",self.is_pagIndex]];
            }
                break;
            case WBStatusHotCakes: { ///< 热销
                
                [self request_dateHotCakesbuy_num:self.is_buy_num good_price:self.is_good_price page:[NSString stringWithFormat:@"%ld",self.is_pagIndex]];
            }
                break;
            case WBStatusSearch: { ///< 搜索
                
               [self searchResultskeywords:_searchStr pagNumber:self.is_pagIndex ordernum:_is_assess orderprice:_is_new_type];
            }
                break;
            case WBStatusMore: { ///< 更多
                
               [self request_datebuy_num:self.is_buy_num good_price:self.is_good_price page:[NSString stringWithFormat:@"%ld",self.is_pagIndex]];
            }
                break;
            default:
                break;
        }
    });
}
#pragma mark -- 下拉结束
- (void)endofthedropdown {
    // 拿到当前的下拉刷新控件，结束刷新状态
    [self.goodsSearchCollection.mj_header endRefreshing];
    self.goodsSearchCollection.scrollEnabled = YES;
}

#pragma mark -- 上拉结束
- (void)endofthepulldown {
    // 拿到当前的下拉刷新控件，结束刷新状态
    [self.goodsSearchCollection.mj_footer endRefreshing];
    
}

#pragma mark UITableView + 上拉刷新 自动回弹的上拉01
- (void)s_pullMJRefresh {
    
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
    self.goodsSearchCollection.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    // 设置了底部inset
    self.goodsSearchCollection.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    // 忽略掉底部inset
    self.goodsSearchCollection.mj_footer.ignoredScrollViewContentInsetBottom = 0;
}

#pragma mark 上拉加载更多数据
- (void)loadMoreData {
    self.is_pagIndex ++;
    // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        switch (_retweetType) {
            case WBStatusNewGood: { ///< 新品
                
                [self request_dateNewgoodsbuy_num:self.is_buy_num good_price:self.is_good_price page:[NSString stringWithFormat:@"%ld",self.is_pagIndex]];
            }
                break;
            case WBStatusHotCakes: { ///< 热销
                
                [self request_dateHotCakesbuy_num:self.is_buy_num good_price:self.is_good_price page:[NSString stringWithFormat:@"%ld",self.is_pagIndex]];
            }
                break;
            case WBStatusSearch: { ///< 搜索
                
                [self searchResultskeywords:_searchStr pagNumber:self.is_pagIndex ordernum:_is_assess orderprice:_is_new_type];
                
            }
                break;
            case WBStatusMore: { ///< 更多
                
                [self request_datebuy_num:self.is_buy_num good_price:self.is_good_price page:[NSString stringWithFormat:@"%ld",self.is_pagIndex]];
            }
                break;
            default:
                break;
        }
        
        
    });
}




- (NSString *)placeHolder {
    
    if (!_placeHolder) {
        _placeHolder = @"请输入商品名称";
    }
    return _placeHolder;
}

- (UISearchBar *)searchBar
{
    if (!_searchBar) { // 70 90
        
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width-70, 30)];
        _searchBar.delegate = self;
        _searchBar.placeholder = self.placeHolder;
        [self.searchBar setBarStyle:UIBarStyleBlackOpaque];// 搜索框样式
        [self.searchBar setSearchFieldBackgroundImage:[UIImage imageNamed:@"bg_sl"] forState:(UIControlStateNormal)];
    }
    return _searchBar;
}

@end
