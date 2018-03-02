//
//  JXShopHomeViewController.m
//  JaneCargo
//
//  Created by 鹏 on 2017/8/8.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXShopHomeViewController.h"
#import "JXShophomeCollectionViewCell.h"
#import "JXShopHomeCollectionReusableView.h"
#import "JXShopShufflingCollectionViewCell.h"
#import "JXJXOffNetCollectionCell.h"
@interface JXShopHomeViewController ()<SDCycleScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,LoginDelegate> {
    // 1是已关注，0是未关注
    NSInteger is_Focus;
    NSString *is_title;
    BOOL is_network;
}
@property (nonatomic, strong) JXCustomHudview *jxhud;
@property (weak, nonatomic) IBOutlet UICollectionView *shopCollection;
@property (nonatomic, strong) UIButton *rightEditor;

@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;

@property (nonatomic, strong) NSMutableArray *dateArray;
@property (nonatomic, strong) NSMutableArray *dateImageArray;

@end

@implementation JXShopHomeViewController

static NSString *kcellIdentifier = @"collectionCellID";
static NSString *kcellIdentifiershuff = @"collectionCellshuff";
static NSString *kcellIdentifierNoOff = @"collectionCellNoOff";
static NSString *kheaderIdentifier = @"headerIdentifier";
static NSString *kfooterIdentifier = @"footerIdentifier";


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [JXEncapSulationObjc blackNavigation:self color:[UIColor whiteColor]];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dateArray = @[].mutableCopy;
    self.dateImageArray = @[].mutableCopy;
    [self y_dateRequest];
    [self goodsCollection];
    [self listnavigation];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(havingNetworking:) name:@"AFNetworkReachabilityStatusYes" object:nil];
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark 实时检测网络
-(void)havingNetworking:(NSNotification *)isNetWorking {
    
    NSString *sender = isNetWorking.object;
    if (![sender boolValue]) { // 无网
        is_network = YES;
        [self.shopCollection reloadData];
    }else {
        
        is_network = NO;
        [self y_reloadDate];
    }
}

- (void)y_reloadDate {

    [self.dateArray removeAllObjects];
    [self.dateImageArray removeAllObjects];
    [self y_dateRequest];
}

- (void)listnavigation {
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_back"] style:(UIBarButtonItemStylePlain) target:self action:@selector(leftAction:)];
    _rightEditor = [[UIButton alloc] initWithFrame:CGRectMake(0, 10, 40, 24)];
    if (is_Focus == 1) {
        _rightEditor.selected = YES;
        [_rightEditor setImage:[UIImage imageNamed:@"icon_top_已关注_selected"] forState:(UIControlStateNormal)];
    }else {
        _rightEditor.selected = NO;
        [_rightEditor setImage:[UIImage imageNamed:@"icon_top_关注"] forState:(UIControlStateNormal)];
    }
    [_rightEditor setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [_rightEditor.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
    [_rightEditor addTarget:self action:@selector(setBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_rightEditor];
}

- (void)y_dateRequest {
    
    [JXNetworkRequest asyncStoreseller_id:self.seller_id completed:^(NSDictionary *messagedic) {
        // 轮播
        NSArray *infoImageArray = messagedic[@"info"][@"bannerimg"];
        for (NSDictionary *infodic in infoImageArray) {
            JXHomepagModel *model = [[JXHomepagModel alloc] init];
            [model setValuesForKeysWithDictionary:infodic];
            if (![[NSString stringWithFormat:@"%@",model.img] isEqualToString:@"(null)"]) {
                [self.dateImageArray addObject:model];
            }
        }
        NSArray *infoarray = messagedic[@"info"][@"good"];
        for (NSDictionary* list in infoarray) {
            JXStoreModel* obj = [JXStoreModel mj_objectWithKeyValues:list];
            [self.dateArray addObject:obj];
        }
        // 是否关注过
        is_Focus = [messagedic[@"info"][@"keep_shop"][@"info"] integerValue];
        is_title = messagedic[@"info"][@"seller_info"];
        if (is_Focus == 1) {
            _rightEditor.selected = YES;
            [_rightEditor setImage:[UIImage imageNamed:@"icon_top_已关注_selected"] forState:(UIControlStateNormal)];
        }else {
            _rightEditor.selected = NO;
            [_rightEditor setImage:[UIImage imageNamed:@"icon_top_关注"] forState:(UIControlStateNormal)];
        }
        [self navigateTitle];
        [self.shopCollection reloadData];
    } statisticsFail:^(NSDictionary *messagedic) {
        [self showHint:messagedic[@"msg"]];
        
    } fail:^(NSError *error) {
        [self showHint:@"网络连接失败"];
    }];
    
}
- (void)navigateTitle {
    
    UILabel * titleLabel =[[UILabel alloc]init];
    titleLabel.text = is_title;
    [titleLabel sizeToFit];
    titleLabel.textColor = [UIColor blackColor];
    self.navigationItem.titleView = titleLabel;
}

- (void)leftAction:(UIBarButtonItem *)sender  {

    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark --- 关注 取消关注（商铺）
- (void)setBtnClick:(UIButton *)sender {

    
    if (is_Focus == 0) { // 关注店铺
        
        [JXNetworkRequest asyncFocusOnBusiness:self.seller_id completed:^(NSDictionary *messagedic) {// icon_top_已关注_selected
            is_Focus = 1;
            [self listnavigation];
            [self alterMessage:messagedic[@"msg"]];
        } statisticsFail:^(NSDictionary *messagedic) {
            [self is_login:messagedic];
            [self alterMessage:messagedic[@"msg"]];
        } fail:^(NSError *error) {
            
        }];
    }else if (is_Focus == 1){ // 取消关注
        
        [JXNetworkRequest asyncCancelFocusOnBusiness:self.seller_id completed:^(NSDictionary *messagedic) {
            [self alterMessage:messagedic[@"msg"]];
            is_Focus = 0;
            [self listnavigation];
        } statisticsFail:^(NSDictionary *messagedic) {
            [self is_login:messagedic];
            [self alterMessage:messagedic[@"msg"]];
        } fail:^(NSError *error) {
            
        }];
        
    }
}

// 提示
- (void)alterMessage:(NSString *)message {
    [_jxhud hidalterhud];
    _jxhud = [JXCustomHudview alterViewWithTitle:message];
    [self.view addSubview:_jxhud];
}

// 是否登录
- (void)is_login:(NSDictionary *)messagedic {
    
    if ([messagedic[@"status"] integerValue] == 600) {
        JXLoginViewController *login = [[JXLoginViewController alloc] init];
        login.logindelegate = self;
        [self presentViewController:[[UINavigationController alloc] initWithRootViewController:login] animated:NO completion:nil];
    }
}
#pragma mark --- 登录代理 （获取用户信息更新界面）
- (void)loginSuccessful:(JXLoginViewController *)login {
    [self y_reloadDate];
}

#pragma mark ---- collection
- (void)goodsCollection {
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.shopCollection.dataSource = self;
    self.shopCollection.delegate = self;
    [self.shopCollection registerNib:[UINib nibWithNibName:NSStringFromClass([JXShophomeCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:kcellIdentifier];
    [self.shopCollection registerNib:[UINib nibWithNibName:NSStringFromClass([JXShopShufflingCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:kcellIdentifiershuff];
    [self.shopCollection registerNib:[UINib nibWithNibName:NSStringFromClass([JXJXOffNetCollectionCell class]) bundle:nil] forCellWithReuseIdentifier:kcellIdentifierNoOff];
    
    [self.shopCollection registerClass:[JXShopHomeCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kheaderIdentifier];
}

#pragma mark -CollectionView datasource
//section
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    if (is_network) {
        return 1;
    }else {
        return self.dateArray.count+1;
    }
    
}
//item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (is_network) {
        return 1;
    }else {
        if (section == 0) {
            return 1;
        }else {
            JXStoreModel * tempModle = (JXStoreModel*)self.dateArray[section-1];
            return tempModle.good.count;
        }
    }
    
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (is_network) { // 无网状态
        
        JXJXOffNetCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kcellIdentifierNoOff forIndexPath:indexPath];
        cell.UpdateRequest = ^{
            [self y_reloadDate];
        };
        return cell;
    }else {
        if (indexPath.section == 0) { // JXShopShufflingCollectionViewCell
            
            JXShopShufflingCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kcellIdentifiershuff forIndexPath:indexPath];
            [self s_sdcycScrollview:cell];
            return cell;
            
        }else {
            
            JXShophomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kcellIdentifier forIndexPath:indexPath];
            [cell.layer setBorderWidth:0.5];
            [cell.layer setBorderColor:[kUIColorFromRGB(0xcccccc) CGColor]];
            cell.model = ((JXStoreModel*)self.dateArray[indexPath.section-1]).good[indexPath.row];
            return cell;
        }
    }
    
}

//定义每个UICollectionViewCell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (is_network) {
        return CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height);
    }else {
        if (indexPath.section == 0) {
            CGFloat w = self.view.bounds.size.width;
            return CGSizeMake(self.view.bounds.size.width, w*8/15);
        }else {
            return CGSizeMake(self.view.bounds.size.width/2, self.shopCollection.frame.size.width/2*16/15);
        }
    }
    
}

//定义每个Section 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

//每个section中不同的行之间的行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

//选择了某个cell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    JXHomepagModel *model = ((JXStoreModel*)self.dateArray[indexPath.section-1]).good[indexPath.row];
    [JXPodOrPreVc buyGoodsModel:model navigation:self.navigationController];
    
}
//每个item之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
    
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableView = nil;
#pragma mark -- 定制头部视图的内容
    if (kind == UICollectionElementKindSectionHeader) {
        JXShopHomeCollectionReusableView *headerV = (JXShopHomeCollectionReusableView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kheaderIdentifier forIndexPath:indexPath];
        if (indexPath.section != 0) {
            JXStoreModel * tempModle = (JXStoreModel*)self.dateArray[indexPath.section-1];
            headerV.title = tempModle.good_type_name;
        }
        reusableView = headerV;
    }
    
    return reusableView;
}

- (void)s_sdcycScrollview:(JXShopShufflingCollectionViewCell *)headervc {
    
    [self.cycleScrollView removeFromSuperview];
    CGFloat w = self.view.bounds.size.width;
    NSMutableArray *arrays = @[].mutableCopy;
    for (JXHomepagModel *modes in self.dateImageArray) {
        [arrays addObject:[NSString stringWithFormat:@"%@%@",Image_Url,modes.img]];
    }
    self.cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, w, w*8/15) delegate:self placeholderImage:[UIImage imageNamed:@"img_图片加载"]];
    self.cycleScrollView.localizationImageNamesGroup = arrays;
    self.cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    self.cycleScrollView.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.cycleScrollView.autoScrollTimeInterval = 5.0;
    self.cycleScrollView.pageControlDotSize = CGSizeMake(7, 7);
    self.cycleScrollView.pageControlBottomOffset = 8;
    [self.cycleScrollView setBackgroundColor:[UIColor whiteColor]];
    [headervc addSubview:self.cycleScrollView];
}


- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    
    
}

////返回头headerView的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    if (is_network) {
        CGSize size = CGSizeMake([[UIScreen mainScreen] bounds].size.width, 0);
        return size;
    }else {
        if (section == 0) {
            CGSize size = CGSizeMake([[UIScreen mainScreen] bounds].size.width, 0);
            return size;
        }
        CGSize size = CGSizeMake([[UIScreen mainScreen] bounds].size.width, 44);
        return size;
    }
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
