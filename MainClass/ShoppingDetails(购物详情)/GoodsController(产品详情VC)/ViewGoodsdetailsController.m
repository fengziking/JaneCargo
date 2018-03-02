//
//  ViewGoodsdetailsController.m
//  GoodsdetailsAnimation
//
//  Created by 鹏 on 2017/7/19.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "ViewGoodsdetailsController.h"
#import "loopImageView.h"
// 购物车
#import "JXShopCartViewController.h"
// 详细
#import "JXGoodDetailedViewController.h"
#import "JXOrderCommentsViewController.h"
#import "JXSlash.h"
#import "JXOrderTableViewCellA.h"
#import "JXCourierTableViewCell.h"
// 促销
#import "JXPromotionTableViewCell.h"
// 快递包邮
#import "JXCourierChangTableViewCell.h"
// 选中的商品
#import "JXSelectTableViewCell.h"
// 评论
#import "JXCommentTableViewCell.h"
// 购物View
#import "ShoppingView.h"
// 商品详情标题头
#import "XWAddShopCarTitleView.h"

#import "ZYTagLabelsViewController.h"

#import "JXShopHomeViewController.h"
#import "JXMessageSearchView.h"
#import "JXTransparentView.h"

#define NAVBAR_COLORCHANGE_POINT (IMAGE_HEIGHT - NAV_HEIGHT*2)
#define IMAGE_HEIGHT 220
#define NAV_HEIGHT 64


@interface ViewGoodsdetailsController ()<UITableViewDelegate,
UITableViewDataSource,
loopImageViewFooterDelegate,
XWPresentedOneControllerDelegate,
XWAddShopCarTitleViewDelegate,
LoginDelegate,
Shopdetailsdelegate> {

    UILabel * numberLabel;
    BOOL is_showRight;
    // 是否已关注 0未关注 1已关注
    NSInteger is_Focus;
    // 加入购物车的商品数量
    NSInteger add_goodsNumber;
}
@property (nonatomic, strong) NSString *p_qqstr;
@property (nonatomic, strong) JXMessageSearchView *messageView;
// 遮罩
@property (nonatomic, strong) JXTransparentView *showmask;
// 旋转
@property (nonatomic, strong) JXRotating *loading;
@property(nonatomic,strong)UITableView * mainTableView;
// 轮播图片
@property(nonatomic,strong)NSArray * netDataArray;
//轮播View
@property(nonatomic,strong)UIView  * loopIV;
@property(nonatomic,strong)UIView  * loopBackView;
@property(nonatomic,strong)UIView  * animalView;

// 数据存储的数组
// 商品内容
@property (nonatomic, strong) NSMutableArray *goodsArray;
// 轮播相册
@property (nonatomic, strong) NSMutableArray *good_picArray;
// 产品规格
@property (nonatomic, strong) NSMutableArray *spec_priceArray;
// 产品参数
@property (nonatomic, strong) NSMutableArray *attr_goodArray;
@property (nonatomic, strong) XWInteractiveTransition *interactivePush;
@property(strong, nonatomic) UIScrollView * detailBaseView;
/*
 * 导航头部视图
 */
@property(strong, nonatomic) XWAddShopCarTitleView * titleView;

// 底部购物车
@property (nonatomic, strong) ShoppingView *headView;

// 推荐
@property (nonatomic,strong) NSMutableArray *recommendedArray;
// 评论
@property (nonatomic, strong) NSMutableArray *good_assessArray;
// 网络
@property (nonatomic, strong) JXOffNetView *offview;

@end
static CGFloat loopimageHeight = 283;
@implementation ViewGoodsdetailsController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated ];
    [JXEncapSulationObjc clearNavigation:self];
}

#pragma mark - 推荐商品
- (void)y_dateRequest {
    
    [JXNetworkRequest asyncRecommendedcompleted:^(NSDictionary *messagedic) {
        NSArray *infoArray = messagedic[@"info"];
        for (NSDictionary *infodic in infoArray) {
            JXHomepagModel *model = [[JXHomepagModel alloc] init];
            [model setValuesForKeysWithDictionary:infodic];
            [self.recommendedArray addObject:model];
        }
        [self.mainTableView reloadData];
    } statisticsFail:^(NSDictionary *messagedic) {
        
    } fail:^(NSError *error) {
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.goodsArray = @[].mutableCopy;
    self.good_picArray = @[].mutableCopy;
    self.spec_priceArray = @[].mutableCopy;
    self.attr_goodArray = @[].mutableCopy;
    self.recommendedArray = @[].mutableCopy;
    self.good_assessArray = @[].mutableCopy;
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self requestDate];
    [self CreatDetailBaseView];
    [self setNavigationBar];
    [self y_dateRequest];
    // 网络监测
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(havingNetworking:) name:@"AFNetworkReachabilityStatusYes" object:nil];
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark 实时检测网络
-(void)havingNetworking:(NSNotification *)isNetWorking {
    
    NSString *sender = isNetWorking.object;
    if (![sender boolValue]) { // 无网
        [self offNetWork];
    }else {
        [self.offview removeFromSuperview];
    }
}

- (void)offNetWork {
    
    NSArray *nibContents = [[NSBundle mainBundle] loadNibNamed:@"JXOffNetView" owner:nil options:nil];
    self.offview = [nibContents lastObject];
    self.offview.frame = CGRectMake(0, 64, [[UIScreen mainScreen] bounds].size.width, NPHeight-64);
    [self.view addSubview:self.offview];
    __weak typeof(self)root = self;
    self.offview.UpdateRequest = ^{
        [root y_reloaddate];
    };
}

- (void)y_reloaddate{

    [self.goodsArray removeAllObjects];
    [self.good_picArray removeAllObjects];
    [self.spec_priceArray removeAllObjects];
    [self.attr_goodArray removeAllObjects];
    [self.recommendedArray removeAllObjects];
    [self.good_assessArray removeAllObjects];
    [self requestDate];
}


#pragma mark ---- 该产品具体数据处理 评论
- (void)requestDate {

    self.loading = [JXRotating initWithRotaing];
    [self.view addSubview:self.loading];
    dispatch_queue_t queue = dispatch_queue_create("test.queue", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{
        [JXNetworkRequest asyncGoodsdetails:[NSString stringWithFormat:@"%@",_goodsid] is_Cache:NO refreshCache:NO completed:^(NSDictionary *messagedic) {
            self.p_qqstr = messagedic[@"info"][@"qq"];
            // 商品评论
            NSArray *goodassessArray = messagedic[@"info"][@"assess"][@"info"];
            for (NSDictionary *goodassessdic in goodassessArray) {
                JXHomepagModel *model = [[JXHomepagModel alloc] init];
                [model setValuesForKeysWithDictionary:goodassessdic];
                [self.good_assessArray addObject:model];
            }
            // 商品内容
            NSMutableDictionary *gooddic = messagedic[@"info"][@"good"][@"info"];
            JXHomepagModel *model = [[JXHomepagModel alloc] init];
            [model setValuesForKeysWithDictionary:gooddic];
            [self.goodsArray addObject:model];
            // 轮播相册
            NSArray *goodpicArray = messagedic[@"info"][@"good_pic"][@"info"];
            for (NSDictionary *picdic in goodpicArray) {
                [self.good_picArray addObject:picdic[@"img"]];
            }
            // 产品规格 good_number
            NSArray *goodspeArray = messagedic[@"info"][@"spec_price"][@"info"];
            for (NSDictionary *spedic in goodspeArray) {
                JXHomepagModel *model = [[JXHomepagModel alloc] init];
                [model setValuesForKeysWithDictionary:spedic];
                [self.spec_priceArray addObject:model];
            }
            // 产品参数
            NSArray *attrdic = messagedic[@"info"][@"attr"][@"info"];//[@"info"];
            for (NSDictionary *goodattrdic in attrdic) {
                JXHomepagModel *model = [[JXHomepagModel alloc] init];
                [model setValuesForKeysWithDictionary:goodattrdic];
                [self.attr_goodArray addObject:model];
            }
            
            is_Focus = [messagedic[@"info"][@"keeps"][@"info"] integerValue];
            [self loopImageview];
            
            [self setViewWithBuycart];
            [self y_collection];
            [_mainTableView reloadData];
        } statisticsFail:^(NSDictionary *messagedic) {
            
        } fail:^(NSError *error) {
            
        }];
    });
}

- (void)checkgoodNumber {

    [JXNetworkRequest asynccommentsgood:nil completed:^(NSDictionary *messagedic) {
        NSArray *infoarray = messagedic[@"info"];
        NSDictionary *numberdic = infoarray[0];
        if (![[NSString stringWithFormat:@"%@",numberdic[@"number"]] isEqualToString:@"<null>"]) {
            add_goodsNumber = [numberdic[@"number"] integerValue];
            self.headView.number = [NSString stringWithFormat:@"%ld",add_goodsNumber];
        }
     } statisticsFail:^(NSDictionary *messagedic) {
        
    } fail:^(NSError *error) {
        
    }];
}

#pragma mark ---- 底部购物view
- (void)setViewWithBuycart {
    
    NSArray *nibContents = [[NSBundle mainBundle] loadNibNamed:@"ShoppingView" owner:nil options:nil];
    self.headView = [nibContents lastObject];
    self.headView.frame = CGRectMake(0, NPHeight-50, NPWidth, 50);
    self.headView.backgroundColor = [UIColor whiteColor];
    __weak typeof(self)root = self;
    self.headView.buyCart = ^(NSInteger type,BOOL is_select){
        if (type == 0)
        {  // 店铺
            JXHomepagModel *model = root.goodsArray[0];
            JXShopHomeViewController *shop = [[JXShopHomeViewController alloc] init];
            shop.seller_id = model.seller_id;
            [root.navigationController pushViewController:shop animated:YES];
        }
        else if (type == 1)
        { // 购物车
            JXShopCartViewController *shop = [[JXShopCartViewController alloc] init];
            shop.typeNavigate = @"次页面";
            shop.shopdetaildelegate = root;
            [root.navigationController pushViewController:shop animated:YES];
        }
        else if (type == 2)
        { // 关注
            
            
            if (is_Focus == 0) // is_select
            {   // 关注商品
                [root.headView.focusButton setEnabled:NO];
                NSArray *goodidArray = [NSArray arrayWithObjects:root.goodsid, nil];
                [JXNetworkRequest asyncCollectionShoppingCartspecificationsgood_id:goodidArray completed:^(NSDictionary *messagedic) {
                    is_Focus = 1;
                    root.headView.focusImage.image = [UIImage imageNamed:@"icon_已关注_selected"];
                    root.headView.focusLabel.text = @"已关注";
                    [root showHint:messagedic[@"msg"]];
                    [root.headView.focusButton setEnabled:YES];
                } statisticsFail:^(NSDictionary *messagedic) {
                    [root is_login:messagedic];
                    [root showHint:messagedic[@"msg"]];
                    [root.headView.focusButton setEnabled:YES];
                } fail:^(NSError *error) {
                    [root.headView.focusButton setEnabled:YES];
                }];
            }
            else
            {   // 取消关注
                [root.headView.focusButton setEnabled:NO];
                [JXNetworkRequest asyncdeleteCollectionShoppingCartspecificationsgood_id:[NSArray arrayWithObject:[NSString stringWithFormat:@"%@",root.goodsid]] completed:^(NSDictionary *messagedic) {
                    is_Focus = 0;
                    root.headView.focusImage.image = [UIImage imageNamed:@"icon_加关注"];
                    root.headView.focusLabel.text = @"关注";
                    [root showHint:messagedic[@"msg"]];
                    [root.headView.focusButton setEnabled:YES];
                } statisticsFail:^(NSDictionary *messagedic) {
                    [root is_login:messagedic];
                    [root showHint:messagedic[@"msg"]];
                    [root.headView.focusButton setEnabled:YES];
                } fail:^(NSError *error) {
                    [root.headView.focusButton setEnabled:YES];
                }];
            }
            
        }else { // 加入购物车
            
            JXGoodsdetailViewController *new = [[JXGoodsdetailViewController alloc] init];
            new.delegate = root;
            new.seleType = 1;
            new.goodsInformationArray = [NSArray arrayWithArray:root.goodsArray];
            new.goodsspecificationsArray = [NSArray arrayWithArray:root.spec_priceArray];
            [root presentViewController:new animated:YES completion:nil];
            
        }
    };
    if (is_Focus == 1) {
        root.headView.focusImage.image = [UIImage imageNamed:@"icon_已关注_selected"];
    }
    
    [self.view addSubview:self.headView];
    
    [JXJudgeStrObjc is_login:^(NSInteger message) {
        if (message == 200) {
            [self checkgoodNumber];
        }
    }];
    
    
    // QQ
    self.headView.QQcontactblock = ^{
        
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqq://"]]) {
            if (root.p_qqstr.length!=0) {
                
                NSString *openQQUrl = [NSString stringWithFormat:@"mqq://im/chat?chat_type=wpa&uin=%@&version=1&src_type=web",root.p_qqstr];
                NSURL *url = [NSURL URLWithString:openQQUrl];
                [[UIApplication sharedApplication] openURL:url];
            }else {
                [root showHint:@"商户未留下QQ联系号码"];
            }
            
        }else {
            
            [root showHint:@"未安装QQ"];
        }
    };
    
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
    [self is_userinfoMessage];
}

- (void)is_userinfoMessage{
    
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    dispatch_async(queue, ^{
        
        [JXNetworkRequest asyncAllUserInfomationIs_Cache:NO refreshCache:NO completed:^(NSDictionary *messagedic) {
            // 保存用户信息
            NSMutableDictionary *userdic = @{}.mutableCopy;
            for (NSString *content in messagedic[@"info"]) {
                
                NSString *value = [NSString stringWithFormat:@"%@",[messagedic[@"info"] objectForKey:content]];
                if (![value isEqualToString:@"<null>"]) {
                    [userdic setObject:value forKey:content];
                }
            }
            [JXUserDefaultsObjc storageLoginUserInfo:[NSDictionary dictionaryWithDictionary:userdic]];
            // 刷新页面
        } statisticsFail:^(NSDictionary *messagedic) {
            
        } fail:^(NSError *error) {
            
        }];
    });
}
#pragma mark -- 购物车返回代理
- (void)shopdetailsdegatereload {
    
    [self checkgoodNumber];
}

#pragma mak ---  导航
- (void)setNavigationBar {
    
    _titleView = [XWAddShopCarTitleView wxAddshopcarttitleArray:@[@"商品",@"详细",@"评论"]];
    [_titleView setHidden:YES];
    self.navigationItem.titleView = _titleView;
    _titleView.delegate = self;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_消息拷贝"] style:(UIBarButtonItemStylePlain) target:self action:@selector(rightAction:)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_back"] style:(UIBarButtonItemStylePlain) target:self action:@selector(leftAction:)];
}
// 消息
- (void)rightAction:(UITabBarItem *)sender {
    
    is_showRight = !is_showRight;
    if (is_showRight) {
        is_showRight = YES;
        self.showmask = [JXTransparentView showMaskViewWith:^{
            is_showRight = NO;
            [self.messageView removeFromSuperview];
        }];
        
        [[[UIApplication  sharedApplication] keyWindow] addSubview:self.showmask];
        self.messageView = [[JXMessageSearchView alloc] initWithFrame:CGRectMake(NPWidth-130-10, 64, 130, 77)];
        [[[UIApplication  sharedApplication] keyWindow] addSubview:self.messageView];
        
    }else {
        is_showRight = NO;
        [self.showmask removeFromSuperview];
        [self.messageView removeFromSuperview];
    }
}

- (void)leftAction:(UITabBarItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mak ---  轮播代理 (放大滑动后返回  直接滑动返回)
- (void)loopImageContentoffset:(NSInteger)indexItem {
    [numberLabel setText:[NSString stringWithFormat:@"%ld",(long)indexItem+1]];
}
- (void)loopImageViewFooterTranster:(CGFloat)angle AndIndexPath:(NSInteger)indexpath AndTotal:(NSInteger)total{
    
    [numberLabel setText:[NSString stringWithFormat:@"%ld",indexpath+1]];
}
#pragma mark- 导航标题切换代理
-(void)XWAddShopCarTitleView:(XWAddShopCarTitleView *)View ClickTitleWithTag:(NSInteger)tag andButton:(UIButton *)sender
{
    // scroll水平方向偏移
    self.detailBaseView.contentOffset = CGPointMake(tag*NPWidth, 0);
}
- (CATransform3D)roundViewTransformAngel:(CGFloat)angle {
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = 1.0/-900;
    transform = CATransform3DRotate(transform, -angle *M_PI, 0, 1, 0);
    return transform;
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 7;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    JXHomepagModel *model;
    if (self.goodsArray.count>0) {
        model = self.goodsArray[indexPath.row];;
    }
    if (indexPath.section == 0)
    {
        JXOrderTableViewCellA *cell = [JXOrderTableViewCellA cellWithTable];
        [cell setSelectionStyle:(UITableViewCellSelectionStyleNone)];
        [cell setBackgroundColor:[UIColor whiteColor]];
        [cell setModel:model];
        return cell;
    }
    else if (indexPath.section == 1)
    { // 销量
        JXCourierTableViewCell *cell = [JXCourierTableViewCell cellWithTable];
        [cell setSelectionStyle:(UITableViewCellSelectionStyleNone)];
        [cell setModel:model];
        return cell;
    }
    else if (indexPath.section == 2)
    { // 退货等
        
        JXCourierChangTableViewCell *cell = [JXCourierChangTableViewCell cellWithTable];
        [cell setSelectionStyle:(UITableViewCellSelectionStyleNone)];
        [cell setBackgroundColor:kUIColorFromRGB(0xf7f6f6)];
        return cell;
    }
    else if (indexPath.section == 3) // 规格
    {
        JXHomepagModel *speModel;
        JXSelectTableViewCell *cell = [JXSelectTableViewCell cellWithTable];
        if (self.spec_priceArray.count>0) { // 无规格状态下
            speModel = self.spec_priceArray[indexPath.row];
            [cell setModel:speModel];
        }else {
            for (JXHomepagModel *model in self.goodsArray) {
                if (model.good_number!=nil) {
                    [cell setTitle:[NSString stringWithFormat:@"产品库存(%@)",model.good_number]];
                }else {
                    [cell setTitle:@"产品暂无库存"];
                }
            }
        }
        return cell;
    }
    else if (indexPath.section == 4)
    { // 评论 good_assessArray
        JXCommentTableViewCell *cell = [JXCommentTableViewCell cellWithTable];
        JXHomepagModel *assessmodel;
        if (self.good_assessArray.count>0) {
            assessmodel = self.good_assessArray[0];;
            [cell setModel:assessmodel];
        }else {
            for (UIView *view in cell.subviews) {
                [view removeFromSuperview];
            }
        }
        [cell setSelectionStyle:(UITableViewCellSelectionStyleNone)];
        return cell;
    }
    else if (indexPath.section == 5) // 推荐产品
    {
        JXPromotionTitleCell *cell = [JXPromotionTitleCell cellWithTable];
        [cell setSelectionStyle:(UITableViewCellSelectionStyleNone)];
        [cell setBackgroundColor:kUIColorFromRGB(0xf2f2f2)];
        cell.gradientLabel.text = @"看了又看";
        return cell;
    }
    else
    {
        JXPromotionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"pros" forIndexPath:indexPath];
        [cell setSelectionStyle:(UITableViewCellSelectionStyleNone)];
        [JXEncapSulationObjc selectViewAbout:cell];
        [self showPromotion:cell];
        return cell;
        
    }
}
#pragma mark ---- 进入规格动画
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 3) { // 动画
        JXGoodsdetailViewController *new = [[JXGoodsdetailViewController alloc] init];
        new.delegate = self;
        new.seleType = 1;
        new.goodsInformationArray = [NSArray arrayWithArray:self.goodsArray];
        new.goodsspecificationsArray = [NSArray arrayWithArray:self.spec_priceArray];
        [self presentViewController:new animated:YES completion:nil];
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JXHomepagModel *model;;
    if (self.goodsArray.count>0) {
        model = self.goodsArray[indexPath.row];
    }
    NSInteger line = [JXEncapSulationObjc s_calculateNumberArrayNum:self.recommendedArray.count singleNumber:2];
    if (indexPath.section == 0) return model.cellHeight;
    if (indexPath.section == 1) return TableViewControllerCell_Height;
    if (indexPath.section == 2) return 75;
    if (indexPath.section == 3) return 44+10;
    if (indexPath.section == 4) {
        if (self.good_assessArray.count<=0) {
            return 0;
        }else {
            return 110+10;
        }
    }
    if (indexPath.section == 5) return TableViewControllerCell_Height;
    return line * BranchOrder_Collection_Height;;
}


// 展示促销产品
- (void)showPromotion:(UITableViewCell *)cell {
    
    [JXPodOrPreVc recommendednumberArray:self.recommendedArray.count lines:2 datearray:self.recommendedArray viewController:self tablecell:cell];
}

#pragma  mark --- 动画代理
- (void)presentedOneControllerPressedDissmiss{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (id<UIViewControllerInteractiveTransitioning>)interactiveTransitionForPresent{
    return _interactivePush;
}

#pragma mark- UIScrollViewdelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    // 头部轮播动画过度
    CGRect frame = self.loopBackView.frame;
    frame.size.height = (scrollView.contentOffset.y) + loopimageHeight;
    self.loopBackView.frame = frame;
    self.loopIV.center = self.loopBackView.center;
    [self.mainTableView insertSubview:self.loopBackView atIndex:0];
    
    CGFloat offsetY = scrollView.contentOffset.y;
    // 防止冲突
    if ([self.mainTableView isEqual:scrollView]) {
        if (offsetY > 20)
        {
            [_titleView setHidden:NO];
            [JXEncapSulationObjc blackNavigation:self color:[UIColor whiteColor]];
        }
        else
        {
            [_titleView setHidden:YES];
            [JXEncapSulationObjc clearNavigation:self];
        }
    }
}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // 设置偏移
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
}

// 减速完成调用（scrollView的contentOffSet是确定的）
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    //    if ([self.detailBaseView isEqual:scrollView]) {
    //        // 索引
    //        NSInteger index = scrollView.contentOffset.x / scrollView.width;
    //        // 修改导航选中标题
    //        [self.titleView  updataSelectTitleWithTag:index];
    //    }
}



#pragma mark -- 创建布局 详情 评论
-(void)CreatDetailBaseView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.detailBaseView =[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, NPWidth, NPHeight)];
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
    self.detailBaseView.contentSize = CGSizeMake(NPWidth*3, NPHeight);
    // 商品
    [self createMainTableView];
}

#pragma mark -- 详情评价
- (void)y_collection {
    
    JXGoodDetailedViewController *goods = [[JXGoodDetailedViewController alloc] init];
    goods.goods_id = [NSString stringWithFormat:@"%@",_goodsid];
    goods.goodparameterArray = [NSArray arrayWithArray:self.attr_goodArray];
    [self addChildViewController:goods];
    [self.detailBaseView addSubview:goods.view];
    [goods didMoveToParentViewController:self];
    
    JXOrderCommentsViewController *comment = [[JXOrderCommentsViewController alloc] init];
    comment.goodsid = _goodsid;
    [self addChildViewController:comment];
    [self.detailBaseView addSubview:comment.view];
    [comment didMoveToParentViewController:self];
}

- (void)createMainTableView{
    
    self.mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, NPWidth, self.detailBaseView.frame.size.height-50) style:UITableViewStylePlain];
    self.mainTableView.delegate =self;
    self.mainTableView.dataSource =self;
    self.mainTableView.rowHeight = UITableViewAutomaticDimension;
    self.mainTableView.separatorStyle = UITableViewCellEditingStyleNone;
    [self.detailBaseView addSubview:self.mainTableView];
    
    [self.mainTableView registerClass:[JXPromotionTableViewCell class] forCellReuseIdentifier:@"pros"];
}

- (void)loopImageview{
    
   // if (self.good_picArray.count > 0) {
        
        self.netDataArray = [NSArray arrayWithArray:self.good_picArray];
        self.loopBackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, NPWidth, loopimageHeight)];
        self.mainTableView.tableHeaderView = self.loopBackView;
        
        [self.mainTableView insertSubview:self.loopBackView atIndex:0];
        
        loopImageView * loopvc = [[loopImageView alloc]initWithFrame:CGRectMake(0, 0, NPWidth, loopimageHeight) AnddataArray:self.netDataArray];
        self.loopIV = loopvc;
        loopvc.delegate =self;
        [self.loopBackView addSubview:loopvc];
        [self performSelector:@selector(roundViewForCurrentImage) withObject:self afterDelay:0.2];
   // }
}

#pragma mark 创建圆形页脚
- (void)roundViewForCurrentImage{
    
    _animalView = [[UIView alloc] initWithFrame:CGRectMake(NPWidth-40-20, loopimageHeight-40-20, 40, 40)];
    [_animalView setBackgroundColor:kUIColorFromRGB(0x000000)];
    [_animalView setAlpha:0.2];
    [_animalView.layer setMasksToBounds:true];
    [_animalView.layer setCornerRadius:40/2];
    [self.loopIV addSubview:_animalView];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(NPWidth-40-20, loopimageHeight-40-20, 40, 40)];
    [view.layer setMasksToBounds:true];
    [view.layer setCornerRadius:40/2];
    [self.loopIV addSubview:view];
    // 斜度
    JXSlash *line = [[JXSlash alloc] init];
    line.backgroundColor = [UIColor clearColor];
    line.frame = self.view.frame;
    [view addSubview:line];
    
    numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 3, 20, 20)];
    [numberLabel setTextAlignment:NSTextAlignmentCenter];
    [numberLabel setText:@"1"];
    [numberLabel setTextColor:kUIColorFromRGB(0xfffefe)];
    [numberLabel setFont:[UIFont systemFontOfSize:16.0f]];
    [view addSubview:numberLabel];
    
    UILabel *allnumber = [[UILabel alloc] initWithFrame:CGRectMake(15, 18, 20, 20)];
    [allnumber setTextAlignment:NSTextAlignmentCenter];
    [allnumber setText:[NSString stringWithFormat:@"%ld",(unsigned long)self.netDataArray.count]];
    [allnumber setTextColor:kUIColorFromRGB(0xfffefe)];
    [allnumber setFont:[UIFont systemFontOfSize:16.0f]];
    [view addSubview:allnumber];
    
}
// 修改规格
- (void)refreshGoodCart{}
// 加入购物车
- (void)returnGoods_number:(NSInteger)number{

    self.headView.number = [NSString stringWithFormat:@"%ld",add_goodsNumber+number];

}


@end
