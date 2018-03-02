//
//  JXAhuiViewController.m
//  JaneCargo
//
//  Created by 鹏 on 2017/8/10.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXAhuiViewController.h"
#import "JXAhuiCollectionReusableView.h"
#import "JXAhuiTimeCollectionViewCell.h"
#import "JXAhuiGoodsCollectionViewCell.h"
#import "JXAhuiTitleCollectionViewCell.h"

#import "JXSearchgoodCollectionViewCell.h"
#import "JXGoodsTiedCollectionViewCell.h"
@interface JXAhuiViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,SDCycleScrollViewDelegate>
{

    BOOL isLayoutbool;
    NSInteger pagNumber;
}
/* collection */
@property (strong , nonatomic)UICollectionView *collectionView;

@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end


@implementation JXAhuiViewController


// cell
static NSString *kcellIdentifier = @"collectionCellID";
static NSString *kcellgoodIdentifier = @"collectionCellgood";
static NSString *kcelltitleIdentifier = @"collectionCelltitle";
// 九宫2个cell
static NSString *kcellcollfIdentifier = @"collectionCellcollf";
static NSString *kcellcollIdentifier = @"collectionCellIcoll";
// 头部
static NSString *kheaderIdentifier = @"headerIdentifier";


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [JXEncapSulationObjc blackNavigation:self color:[UIColor whiteColor]];
    
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
        
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([JXAhuiTimeCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:kcellIdentifier];
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([JXAhuiGoodsCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:kcellgoodIdentifier];
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([JXAhuiTitleCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:kcelltitleIdentifier];
        // 头部
      //  [_collectionView registerClass:[JXAhuiCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kheaderIdentifier];
        
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([JXSearchgoodCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:kcellcollfIdentifier];
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([JXGoodsTiedCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:kcellcollIdentifier];
        
        _collectionView.frame = CGRectMake(0, 64, NPWidth, NPHeight-64);
     }
    return _collectionView;
}

- (void)is_navigation {
    
    UILabel * titleLabel =[[UILabel alloc]init];
    titleLabel.text = @"极惠商品";
    [titleLabel sizeToFit];
    titleLabel.textColor = [UIColor blackColor];
    self.navigationItem.titleView = titleLabel;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_back"] style:(UIBarButtonItemStylePlain) target:self action:@selector(leftAction:)];
}
- (void)leftAction:(UIBarButtonItem *)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    pagNumber = 1;
    self.dataArray = @[].mutableCopy;
    
    [self dataRequest];
    [self setUpBase];
    [self is_navigation];
}

// 数据处理
- (void)dataRequest {

    [JXNetworkRequest asyncAhuipage:[NSString stringWithFormat:@"%ld",(long)pagNumber] completed:^(NSDictionary *messagedic) {
        
        
        for (NSDictionary *infodic in messagedic[@"info"]) {
            JXHomepagModel *model = [[JXHomepagModel alloc] init];
            [model setValuesForKeysWithDictionary:infodic];
            [self.dataArray addObject:model];
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
    return 1;
}
//item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.dataArray.count;
    
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    JXHomepagModel *model;
    if (self.dataArray.count >0) {
        model = self.dataArray[indexPath.row];
    }
    
    JXAhuiGoodsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kcellgoodIdentifier forIndexPath:indexPath];
    [cell setMode:model];
    cell.SnapClickBlock = ^(JXHomepagModel *model) {
        [JXPodOrPreVc buyGoodsModel:model navigation:self.navigationController];
    };
    return cell;
    
    
}

//定义每个UICollectionViewCell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(self.view.bounds.size.width, 115+10);
    
}

//定义每个Section 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);//分别为上、左、下、右
    
}

//每个section中不同的行之间的行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

//选择了某个cell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    JXHomepagModel *model = self.dataArray[indexPath.row];
    [JXPodOrPreVc buyGoodsModel:model navigation:self.navigationController];
//    ViewGoodsdetailsController *jxorder = [[ViewGoodsdetailsController alloc] init];
//    
//    [self.navigationController pushViewController:jxorder animated:YES];
    
}
//每个item之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
    
}

//-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
//{
//    UICollectionReusableView *reusableView = nil;
//    if (indexPath.section == 0) {
//#pragma mark -- 定制头部视图的内容
//        if (kind == UICollectionElementKindSectionHeader) {
//            JXAhuiCollectionReusableView *headerV = (JXAhuiCollectionReusableView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kheaderIdentifier forIndexPath:indexPath];
//            [self s_sdcycScrollview:headerV];
//            reusableView = headerV;
//        }
//    }
//    return reusableView;
//}

////返回头headerView的大小
//-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
//    if (section == 0) {
//        CGSize size = CGSizeMake([[UIScreen mainScreen] bounds].size.width, 8*NPWidth/15);
//        return size;
//    }else {
//        CGSize size = CGSizeMake(0, 0);
//        return size;
//    }
//}

#pragma mark - SDCycleScrollViewDelegate 轮播代理
- (void)s_sdcycScrollview:(UICollectionReusableView *)headervc {
    
    [self.cycleScrollView removeFromSuperview];
    CGFloat w = self.view.bounds.size.width;
    NSMutableArray *arrays = @[].mutableCopy;
    
    [arrays addObject:@"http://7xshvf.com2.z0.glb.qiniucdn.com/reading/img/00/D2/rBACHlXAh2mARoJgAAB3J_XSUb8472.jpg"];
    self.cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, w, 8*NPWidth/15) delegate:self placeholderImage:[UIImage imageNamed:@"img_图片加载"]];
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



//#pragma mark --- 代理 tag 0-综合 1-销量 2-价格 3-九宫
//- (void)sortinggood:(NSInteger)btTag boolclick:(BOOL)boolclick {
//
//    switch (btTag) {
//        case 0:
//        {
//            NSLog(@"0");
//        }
//            break;
//        case 1:
//        {
//            if (boolclick)
//            {
//                NSLog(@"1");
//            }
//            else
//            {
//                NSLog(@"2");
//            }
//        }
//            break;
//        case 2:
//        {
//            if (boolclick)
//            {
//                NSLog(@"3");
//            }
//            else
//            {
//                NSLog(@"4");
//            }
//        }
//            break;
//        case 3:
//        {
//            isLayoutbool = boolclick;
//            
//            [self.collectionView reloadData];
//        }
//            break;
//            
//        default:
//            break;
//    }
//
//}
























@end
