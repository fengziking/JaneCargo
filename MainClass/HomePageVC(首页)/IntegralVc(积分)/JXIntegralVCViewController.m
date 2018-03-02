//
//  JXIntegralVCViewController.m
//  JaneCargo
//
//  Created by 鹏 on 2017/8/10.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXIntegralVCViewController.h"
#import "JXComprehensiveView.h"


#import "JXGoodsTiedCollectionViewCell.h"
static NSString *gcellIdentifier = @"collectionCellIDg";

@interface JXIntegralVCViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UIView *back_View;

@property (weak, nonatomic) IBOutlet UILabel *comprehensiveLabel;
@property (weak, nonatomic) IBOutlet UIImageView *comprehensiveImage;
@property (weak, nonatomic) IBOutlet UIButton *comprehensivebt;



@property (weak, nonatomic) IBOutlet UILabel *salesLabel;
@property (weak, nonatomic) IBOutlet UIImageView *salesImage;
@property (weak, nonatomic) IBOutlet UIButton *salesbt;

@property (weak, nonatomic) IBOutlet UILabel *integralLabel;
@property (weak, nonatomic) IBOutlet UIImageView *integralImage;
@property (weak, nonatomic) IBOutlet UIButton *integralbt;


// 遮罩
//@property (nonatomic, strong) ShowMaskView *showmask;
//@property (nonatomic, strong) JXComprehensiveView *headView;

@property (weak, nonatomic) IBOutlet UICollectionView *IntegralCollection;


@end

@implementation JXIntegralVCViewController
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [JXEncapSulationObjc blackNavigation:self color:[UIColor whiteColor]];
    
}
- (IBAction)comprehensiveAction:(UIButton *)sender { // icon_筛选向下
    
    
    
    sender.selected = !sender.selected;
//    if (sender.selected) { // icon_筛选向下
//        
//        [self changeColorRed:self.comprehensiveLabel whitelabel:self.salesLabel swhitelabel:self.integralLabel];
//        [_comprehensiveImage setImage:[UIImage imageNamed:@"icon_筛选向下_selected"]];
//        [_salesImage setImage:[UIImage imageNamed:@"icon_价格筛选"]];
//        [_integralImage setImage:[UIImage imageNamed:@"icon_价格筛选"]];
//        
//        [self hiddenComprehensive:105];
//        self.showmask = [ShowMaskView showMaskViewWith:^{
//            [self hiddenComprehensive:0];
//            sender.selected = NO;
//        }];
//        [self.view addSubview:self.showmask];
//        [self.view sendSubviewToBack:self.showmask];
//        [self.view sendSubviewToBack:self.IntegralCollection];
//        
//    }else {
//        
//        [self hiddenComprehensive:0];
//        [self.showmask removeFromSuperview];
//    }
    
}

- (IBAction)salesAtion:(UIButton *)sender {
    
    [self changeColorRed:self.salesLabel whitelabel:self.comprehensiveLabel swhitelabel:self.integralLabel];
    sender.selected = !sender.selected;
    if (sender.selected) {
        [_salesImage setImage:[UIImage imageNamed:@"icon_价格筛选_倒序"]];
    }else {
        [_salesImage setImage:[UIImage imageNamed:@"icon_价格筛选_升序"]];
    }
    [_comprehensiveImage setImage:[UIImage imageNamed:@"icon_筛选向下"]];
    [_integralImage setImage:[UIImage imageNamed:@"icon_价格筛选"]];
}

- (IBAction)integralAction:(UIButton *)sender {
    
    [self changeColorRed:self.integralLabel whitelabel:self.comprehensiveLabel swhitelabel:self.salesLabel];
    sender.selected = !sender.selected;
    if (sender.selected) {
        [_integralImage setImage:[UIImage imageNamed:@"icon_价格筛选_倒序"]];
    }else {
        [_integralImage setImage:[UIImage imageNamed:@"icon_价格筛选_升序"]];
    }
    [_comprehensiveImage setImage:[UIImage imageNamed:@"icon_筛选向下"]];
    [_salesImage setImage:[UIImage imageNamed:@"icon_价格筛选"]];
    
}

- (void)changeColorRed:(UILabel *)redlabel whitelabel:(UILabel *)whiteLabel swhitelabel:(UILabel *)swhiteLabel {
    
    [redlabel setTextColor:[UIColor redColor]];
    [whiteLabel setTextColor:[UIColor blackColor]];
    [swhiteLabel setTextColor:[UIColor blackColor]];
    
}


- (void)is_showView {

    [self.back_View.layer setBorderWidth:0.5];
    [self.back_View.layer setBorderColor:[kUIColorFromRGB(0xcccccc) CGColor]];
    
//    NSArray *nibContents = [[NSBundle mainBundle] loadNibNamed:@"JXComprehensiveView" owner:nil options:nil];
//    _headView = [nibContents lastObject];
//    _headView.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 105);
//    [self.view addSubview:_headView];
//    
//    [self.view sendSubviewToBack:_headView];
//    [self.view sendSubviewToBack:self.showmask];
//    
//    __weak typeof(self)goods = self;
//    _headView.sequen = ^(NSInteger index) { // 点击综合的三个选项
//        
//        switch (index) {
//            case 0: {
//                
//            }
//                break;
//            case 1: {
//                
//            }
//                break;
//            case 2: {
//                
//            }
//                break;
//                
//            default:
//                break;
//        }
//        
//        [goods hidderComprehensiveView];
//    };
}

//// 隐藏--显示
//- (void)hiddenComprehensive:(CGFloat)framey {
//    
//    [UIView animateWithDuration:0.5 animations:^{
//        [_headView setFrame:CGRectMake(0, framey, [[UIScreen mainScreen] bounds].size.width, 105)];
//    }];
//}

//- (void)hidderComprehensiveView {
//    [self hiddenComprehensive:0];
//    [self.showmask removeFromSuperview];
//    self.comprehensivebt.selected = NO;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self is_navigation];
    [self is_showView];
    [self goodsCollection];
}




- (void)is_navigation {
    
    UILabel * titleLabel =[[UILabel alloc]init];
    titleLabel.text = @"积分兑换";
    [titleLabel sizeToFit];
    titleLabel.textColor = [UIColor blackColor];
    self.navigationItem.titleView = titleLabel;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_back"] style:(UIBarButtonItemStylePlain) target:self action:@selector(leftAction:)];
}

- (void)leftAction:(UIBarButtonItem *)sender {
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark ---- collection
- (void)goodsCollection {
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.IntegralCollection.dataSource = self;
    self.IntegralCollection.delegate = self;
    
    [self.IntegralCollection registerNib:[UINib nibWithNibName:NSStringFromClass([JXGoodsTiedCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:gcellIdentifier];
    
}

#pragma mark -CollectionView datasource
//section
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
//item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 10;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    JXGoodsTiedCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:gcellIdentifier forIndexPath:indexPath];
//    JXHomepagModel *model = self.dateArray[indexPath.row];
//    if (self.dateArray.count>0) {
//        [cell setModel:model];
//    }
    
    return cell;
}

//定义每个UICollectionViewCell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(self.IntegralCollection.frame.size.width/2, 16*self.IntegralCollection.frame.size.width/2/15);
    
    
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
//    
//    JXHomepagModel *model = self.dateArray[indexPath.row];
    ViewGoodsdetailsController *jxorder = [[ViewGoodsdetailsController alloc] init];
//    jxorder.hidesBottomBarWhenPushed = true;
//    jxorder.goodsid = model.id;
    [self.navigationController pushViewController:jxorder animated:YES];
    
}
//每个item之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    
    return 0;
}




















































































































@end
