//
//  JXMenuCollectionViewController.m
//  JaneCargo
//
//  Created by cxy on 2017/6/29.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXMenuCollectionViewController.h"
#import "JXRightMenuCollectionViewCell.h"
#import "JXShuffingCollectionViewCell.h"
#import "JXRightMenuReusableView.h"
// 下单界面
//#import "JXOrderViewController.h"
#import "ViewGoodsdetailsController.h"


@interface JXMenuCollectionViewController ()


@end

@implementation JXMenuCollectionViewController

static NSString * const reuseIdentifier = @"Cell";
static NSString * const reuseIdentifiershu = @"Cellshu";
static NSString * const headerIIdentifer = @"headerIIdentifer";

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated ];
    
//    [self clearNavigation];
    
}
- (void)clearNavigation {
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [[[self.navigationController.navigationBar subviews]objectAtIndex:0] setAlpha:1];
}




// SelectRightTable
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([JXRightMenuCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([JXShuffingCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:reuseIdentifiershu];

    [self.collectionView registerClass:[JXRightMenuReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerIIdentifer];
    [self.collectionView setBackgroundColor:kUIColorFromRGB(0xf2f2f2)];
    
    // Do any additional setup after loading the view.
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.dateArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    JXRightMenuCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    [cell.layer setBorderWidth:0.5];
    [cell.layer setBorderColor:[kUIColorFromRGB(0xe3e3e3) CGColor]];
    [self rightListcellcell:cell indexPath:indexPath];
    return cell;
}

- (void)rightListcellcell:(JXRightMenuCollectionViewCell *)cell indexPath:(NSIndexPath *)indexPath {

    JXHomepagModel *model;
    if (!kArrayIsEmpty(self.dateArray)) {
        model = self.dateArray[indexPath.row];
    }
    [cell setBackgroundColor:[UIColor whiteColor]];
    [cell hidenViewWithLine:indexPath];
    [cell setModel:model];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    JXHomepagModel *model = self.dateArray[indexPath.row];
    [JXPodOrPreVc hiddenTabbarbuyGoodsModel:model navigation:self.navigationController];
    
}


//定义每个UICollectionViewCell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((self.collectionView.frame.size.width-20)/2, ((self.collectionView.frame.size.width-20)/2)*53/44);
}
//定义每个Section 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(12.5, 10, 12.5, 10);//分别为上、左、下、右
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableView = nil;
#pragma mark -- 定制头部视图的内容
    if (kind == UICollectionElementKindSectionHeader) {
        JXRightMenuReusableView *headerV = (JXRightMenuReusableView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerIIdentifer forIndexPath:indexPath];
        if ( self.lTitleArray.count >0) {
            headerV.title = self.lTitleArray[_left_selectIndex];
        }
        reusableView = headerV;
    }
    //    if (kind == UICollectionElementKindSectionFooter) {
    //        ExperocenceFootCollectionReusableView *headerV = (ExperocenceFootCollectionReusableView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:kfootIdentifier forIndexPath:indexPath];
    //        [headerV setBackgroundColor:[UIColor whiteColor]];
    //        reusableView = headerV;
    //
    //        headerV.upgradblock = ^(){
    //
    //            [self showPayViews];
    //        };
    //    }
    return reusableView;
}

////返回头headerView的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    CGSize size = CGSizeMake([[UIScreen mainScreen] bounds].size.width, 15+12);
    return size;
}
////返回头footerView的大小
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
//{
//    CGSize size={320,45};
//    return size;
//}
//每个section中不同的行之间的行间距 minimumInteritemSpacing
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
// 行之间的上下间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}





#pragma mark <UICollectionViewDelegate>
/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
