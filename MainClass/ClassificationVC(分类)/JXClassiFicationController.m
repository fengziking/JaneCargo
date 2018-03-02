//
//  JXClassiFicationController.m
//  JaneCargo
//
//  Created by 鹏 on 2017/8/18.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXClassiFicationController.h"
#import "JXFicationTopView.h"
#import "JXFicationLeftView.h"
#import "JXMenuCollectionViewController.h"
@interface JXClassiFicationController () {

    BOOL is_showTitle;
    BOOL is_clickleft;
}
// 旋转
@property (nonatomic, strong) JXRotating *loading;
@property (nonatomic, strong) JXFicationTopView *y_topTitle;
@property (nonatomic, strong) JXFicationLeftView *y_leftTitle;
@property (nonatomic, strong) JXMenuCollectionViewController *collecotiongy;
// 记录内容
@property (nonatomic, strong) NSMutableArray *dateArray;
// 标题数量
@property (nonatomic, strong) NSMutableArray *titleArray;
// 侧面标题
@property (nonatomic, strong) NSMutableArray *sideArray;
// 记录选中的top顶部标题id
@property (nonatomic, assign) NSInteger top_selectGoodid;
// 记录选中的left左侧标题index
@property (nonatomic, assign) NSInteger left_selectIndex;

@property (nonatomic, strong) JXOffNetView *offview;

@end

@implementation JXClassiFicationController


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    is_clickleft = YES;
    [self.y_topTitle setColorviewwidht];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    is_clickleft = YES;
    self.dateArray = @[].mutableCopy;
    self.titleArray = @[].mutableCopy;
    self.sideArray = @[].mutableCopy;
    [self y_navigationTitle];
    [self y_topTitleView];
    [self shupdate];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(havingNetworking:) name:@"AFNetworkReachabilityStatusYes" object:nil];
}

#pragma mark 实时检测网络
-(void)havingNetworking:(NSNotification *)isNetWorking {
    
    NSString *sender = isNetWorking.object;
    if (![sender boolValue]) { // 无网
        is_clickleft = YES;
        [self.offview removeFromSuperview];
        [self offNetWork];
    }else {
        [self.offview removeFromSuperview];
        [self shupdate];
    }
}

- (void)y_navigationTitle {

    UILabel * titleLabel =[[UILabel alloc]init];
    titleLabel.text = @"分类";
    [titleLabel sizeToFit];
    titleLabel.textColor = [UIColor blackColor];
    self.navigationItem.titleView = titleLabel;
    [self.view setBackgroundColor:[UIColor whiteColor]];
}

#pragma mark --- 头部标题 左侧标题
- (void)y_topTitleView {

    NSArray *nibContents = [[NSBundle mainBundle] loadNibNamed:@"JXFicationTopView" owner:nil options:nil];
    self.y_topTitle = [nibContents lastObject];
    self.y_topTitle.frame = CGRectMake(0, 64, [[UIScreen mainScreen] bounds].size.width, 40);
    [self.view addSubview:self.y_topTitle];
    __weak typeof(self)root = self;
    self.y_topTitle.TopTitleblock = ^(NSInteger index) {
        
        is_clickleft = YES;
        root.left_selectIndex = 0;
        NSMutableArray *topgood_idArray = @[].mutableCopy;
        for (JXHomepagModel *model in root.titleArray) {
            [topgood_idArray addObject:model.id];
        }
        if (topgood_idArray.count>index) {
            root.top_selectGoodid = [topgood_idArray[index] integerValue];
        }
        [root removeDateRequestArray];
        [root removeViewForTitle];
        if (topgood_idArray.count>index) {
            [root dateRequestdateTopgoodid:[topgood_idArray[index] integerValue] leftgoodid:0 selectIndex:0];
        }
        
    };
    // 左侧标题
    self.y_leftTitle = [[JXFicationLeftView alloc] initWithFrame:CGRectMake(0, 40+65, 100, NPHeight-49-40-64)];
    [self.view addSubview:self.y_leftTitle];
    self.y_leftTitle.LeftTitleblock = ^(NSInteger index) {
        
        is_clickleft = NO;
        root.left_selectIndex = index;
        NSMutableArray *topgood_idArray = @[].mutableCopy;
        for (JXHomepagModel *model in root.sideArray) {
            [topgood_idArray addObject:model.id];
        }
        [root removeDateRequestArray];
        if (topgood_idArray.count>index) {
            [root dateRequestdateTopgoodid:root.top_selectGoodid leftgoodid:[topgood_idArray[index] integerValue] selectIndex:index];
        }
        
    };
    // 显示首次数据
    [self dateRequestdateTopgoodid:0 leftgoodid:0 selectIndex:0];
}


// 无网 JXOffNetView
- (void)offNetWork {
    
    NSArray *nibContents = [[NSBundle mainBundle] loadNibNamed:@"JXOffNetView" owner:nil options:nil];
    self.offview = [nibContents lastObject];
    self.offview.frame = CGRectMake(0, 64, [[UIScreen mainScreen] bounds].size.width, NPHeight-64);
    [self.view addSubview:self.offview];
    __weak typeof(self)root = self;
    self.offview.UpdateRequest = ^{
        [root shupdate];
    };
}

- (void)shupdate {
    
    is_showTitle = NO;
    [self.y_leftTitle removeFromSuperview];
    [self.y_topTitle removeFromSuperview];
    [self removeDateRequestArray];
    [self y_topTitleView];
}


- (void)removeViewForTitle {

    for (UIView *view in self.y_leftTitle.subviews) {
        [view removeFromSuperview];
    }
}

- (void)removeDateRequestArray {
    
    [self.dateArray removeAllObjects];
    [self.titleArray removeAllObjects];
    [self.sideArray removeAllObjects];
}

- (void)dateRequestdateTopgoodid:(NSInteger)topgoodid leftgoodid:(NSInteger)leftgoodid selectIndex:(NSInteger)selectIndex{

    self.loading = [JXRotating initWithRotaing];
    [self.view addSubview:self.loading];
    [JXNetworkRequest asyncClassificationGood_type_id:topgoodid son_good_type_id:leftgoodid is_Cache:NO refreshCache:NO completed:^(NSDictionary *messagedic) {
        // 内容
        NSArray *messageArray = messagedic[@"info"][@"good"][@"info"];
        // 顶部标题
        NSArray *titleArray = messagedic[@"info"][@"good_type"][@"info"];
        // 侧面标题
        NSArray *sideArray = messagedic[@"info"][@"good_type_son"][@"info"];
        
        for (NSMutableDictionary *contentdic in messageArray) {
            JXHomepagModel *model = [[JXHomepagModel alloc] init];
            [model setValuesForKeysWithDictionary:contentdic];
            [self.dateArray addObject:model];
        }
        for (NSMutableDictionary *titledic in titleArray) {
            JXHomepagModel *model = [[JXHomepagModel alloc] init];
            [model setValuesForKeysWithDictionary:titledic];
            [self.titleArray addObject:model];
        }
       
        for (NSMutableDictionary *sidedic in sideArray) {
            JXHomepagModel *model = [[JXHomepagModel alloc] init];
            [model setValuesForKeysWithDictionary:sidedic];
            [self.sideArray addObject:model];
        }
        
        if (self.titleArray.count==0) {
            [self removeDateRequestArray];
            [self dateRequestdateTopgoodid:0 leftgoodid:0 selectIndex:0];
            return ;
        }
        if (!is_showTitle) { // 顶部标题只显示一次 不需要刷新
            is_showTitle = YES;
            if (self.titleArray.count>0) {
                [self.y_topTitle setupTitle:self.titleArray];
            }
        }
        // 刷新左侧视图
        if (self.sideArray.count>0) {
            if (is_clickleft) {
                is_clickleft = NO;
                [self.y_leftTitle setupTitle:self.sideArray selectIndex:selectIndex];
            }
            
        }
        [self addRightMenu];
    } statisticsFail:^(NSDictionary *messagedic) {
    } fail:^(NSError *error) {
        [self offNetWork];
    }];
}

// 获取对应值 通知刷新数据
- (void)addRightMenu{
    
    [_collecotiongy willMoveToParentViewController:nil];
    [_collecotiongy.view removeFromSuperview];
    [_collecotiongy removeFromParentViewController];
    NSMutableArray *stitleArrays = @[].mutableCopy;
    for (JXHomepagModel *model in self.sideArray) {
        [stitleArrays addObject:model.name];
    }
    _collecotiongy = [[JXMenuCollectionViewController alloc] initWithNibName:NSStringFromClass([JXMenuCollectionViewController class]) bundle:nil];
    [_collecotiongy.view setFrame:CGRectMake(100, 64+41,NPWidth-100, self.view.frame.size.height-64-40)];
    _collecotiongy.dateArray = self.dateArray;
    _collecotiongy.lTitleArray = stitleArrays;
    _collecotiongy.left_selectIndex = self.left_selectIndex;
    [self addChildViewController:_collecotiongy];
    [self.view addSubview:_collecotiongy.view];
    [_collecotiongy didMoveToParentViewController:self];
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
