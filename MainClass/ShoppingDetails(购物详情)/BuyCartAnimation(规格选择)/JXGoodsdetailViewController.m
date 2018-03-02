//
//  JXGoodsdetailViewController.m
//  JaneCargo
//
//  Created by cxy on 2017/6/30.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXGoodsdetailViewController.h"
#import "XWInteractiveTransition.h"
#import "XWPresentOneTransition.h"
#import "JXBuyCartAnimationView.h"
#import "MKGoodsModel.h"

#import "JXSpecificationNumberCell.h"
#import "JXSpecificationLabelTableViewCell.h"
#import "JXAddRemoveTableViewCell.h"

typedef void(^AZXHeightCallBack)(CGFloat height);


@interface JXGoodsdetailViewController ()<UIViewControllerTransitioningDelegate,UITableViewDelegate,UITableViewDataSource,LoginDelegate,UITextFieldDelegate> {

    UITableView *specificationTable;
    CGFloat labelcell_Height;
    
}
@property (nonatomic, strong) NSMutableArray *goodsPrice;

// 记录选中的规格改变bt状态
@property (nonatomic, strong) NSMutableArray *selectpecs;
@property (nonatomic, strong) NSMutableArray *spec_idArray;
// 商品id
@property (nonatomic, assign) NSString *good_id;
// 记录商品数量
@property (nonatomic, assign) NSInteger goodsNumber;
// 记录选中的规格 默认第一个
@property (nonatomic, assign) NSInteger goods_spe;

@property (nonatomic, strong) XWInteractiveTransition *interactiveDismiss;
@property (nonatomic, strong) XWInteractiveTransition *interactivePush;
// 透明黑色遮罩
@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong) NSMutableArray *specificationsArray;
@property (nonatomic, strong) NSMutableArray *labelbtArray;

@property (nonatomic, strong) JXBuyCartAnimationView *headView;

// 记录加入购物车的id
@property (nonatomic, strong) NSMutableArray *goods_idArray;
// 规格库存数量
@property (nonatomic, strong) NSMutableArray *inventoryNumArray;
// 产品库存
@property (nonatomic, strong) NSMutableArray *goodinventoryNumArray;
@end

@implementation JXGoodsdetailViewController

- (void)dealloc{
    
    NSLog(@"销毁了!!!!!");
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.transitioningDelegate = self;
        self.modalPresentationStyle = UIModalPresentationCustom;
    }
    return self;
}


- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)labelClick:(UITapGestureRecognizer *)tap {
    
    [self.maskView removeFromSuperview];
    if (_delegate && [_delegate respondsToSelector:@selector(presentedOneControllerPressedDissmiss)]) {
        [_delegate presentedOneControllerPressedDissmiss];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // 产品数量默认为1
    _goodsNumber = 1;
    self.labelbtArray = @[].mutableCopy;
    self.goodsPrice = @[].mutableCopy;
    self.specificationsArray = @[].mutableCopy;
    self.spec_idArray = @[].mutableCopy;
    self.selectpecs = @[].mutableCopy;
    self.inventoryNumArray = @[].mutableCopy;
    self.goodinventoryNumArray = @[].mutableCopy;
    
    if (_seleType == 1) {
        [self processTheData];
    }else if (_seleType == 2) {
        [self selectpec];
    }
    [self y_specificationsTable];
}


- (void)y_specificationsTable {

    self.automaticallyAdjustsScrollViewInsets = NO;
    specificationTable = [[UITableView alloc] initWithFrame:CGRectMake(0, NPHeight-(362-40-100)-50, NPWidth, 362-40-100)];
    specificationTable.separatorStyle = UITableViewCellEditingStyleNone;
    specificationTable.delegate = self;
    specificationTable.dataSource = self;
    specificationTable.backgroundColor = [UIColor whiteColor];
    [specificationTable setShowsVerticalScrollIndicator:NO];
    [self.headView addSubview:specificationTable];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_seleType == 1) {
        return 4;
    }else if (_seleType == 2) {
        return 3;
    }else {
        return 4;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        JXSpecificationNumberCell *cell = [JXSpecificationNumberCell cellWithTable];
        if (self.goodsspecificationsArray.count != 0) {
            [cell setTitle:@"规格选择"];
        }
        return cell;
    }else if (indexPath.row == 1) {
        JXSpecificationLabelTableViewCell *cell = [JXSpecificationLabelTableViewCell cellWithTable];
        __block CGFloat maskHeight  = 0;
        [self creatKeywordCubCellWithArray:[NSArray arrayWithArray:self.specificationsArray] toArray:self.labelbtArray specificationsView:cell.labelView heightCallBack:^(CGFloat height) {
            maskHeight = height;
        }];
        labelcell_Height = maskHeight;
        return cell;
    }else if (indexPath.row == 2) {
        JXSpecificationNumberCell *cell = [JXSpecificationNumberCell cellWithTable];
        if (_seleType != 2) {
            [cell setTitle:@"数量"];
        }
        return cell;
    
    }else {
        
        JXAddRemoveTableViewCell *cell = [JXAddRemoveTableViewCell cellWithTable];
        cell.goodnumberTf.delegate = self;
        cell.goodnumberTf.keyboardType = UIKeyboardTypeNumberPad;
        [cell.goodnumberTf addTarget:self action:@selector(accountTextField:) forControlEvents:UIControlEventEditingDidEnd];
        __weak typeof(self) weakSelf = self;
        cell.increse = ^(NSInteger type) {
            if (type == 0) { // 减
                weakSelf.goodsNumber--;
                if ( weakSelf.goodsNumber<=0) {
                    weakSelf.goodsNumber = 1;
                }
            }else if (type == 1) { // 加 _goods_spe
                
                if (self.inventoryNumArray.count>0) { // 有规格的情况下以规格库存为准
                    NSInteger goodsnumbers = [self.inventoryNumArray[_goods_spe] integerValue];
                    if (weakSelf.goodsNumber<goodsnumbers) {
                        weakSelf.goodsNumber++;
                    }else {
                        [self showHint:@"库存不足"];
                    }
                }else { // 无规格情况下 按照产品的库存
                    NSInteger goodsat = [self.goodinventoryNumArray[0] integerValue];
                    if (weakSelf.goodsNumber<goodsat) {
                        weakSelf.goodsNumber++;
                    }else {
                        [self showHint:@"库存不足"];
                    }
                }
                
                
            }
            NSIndexPath *indexPath=[NSIndexPath indexPathForRow:3 inSection:0];
            [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
        };
        [self cellWithwidth:cell];
        [cell.goodnumberTf setText:[NSString stringWithFormat:@"%ld",(long)self.goodsNumber]];
        cell.completeblock = ^{
            _headView.bottomheight.constant = 0;
            [specificationTable setFrame:CGRectMake(0, NPHeight-(362-40-100)-50, NPWidth, 362-40-100)];
        };
        return cell;
    }
}

- (void)cellWithwidth:(JXAddRemoveTableViewCell *)cell {
    
    if ([NSString stringWithFormat:@"%ld",(long)self.goodsNumber].length == 3) {
        cell.goodnumberWid.constant = 32;
    }else if ([NSString stringWithFormat:@"%ld",(long)self.goodsNumber].length == 4) {
        cell.goodnumberWid.constant = 40;
    }else if ([NSString stringWithFormat:@"%ld",(long)self.goodsNumber].length == 5) {
        cell.goodnumberWid.constant = 50;
    }
}
#pragma mark --- 当用户全部清空的时候的时候 会调用
-(BOOL)textFieldShouldClear:(UITextField *)textField {
    
    
    return true;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    KDLOG(@"走");
    _headView.bottomheight.constant = 150;
    
    [specificationTable setFrame:CGRectMake(0, NPHeight-(362-40-100)-50-150, NPWidth, 362-40-100)];
}
#pragma mark --- 填写数量
- (void)accountTextField:(UITextField *)textField  {
    
    if (textField.text.length>5) {
        [self showHint:@"已超过数量"];
        textField.text = @"1";
        return;
    }
    NSInteger textnumber = [textField.text integerValue];
    if (self.inventoryNumArray.count>0) { // 有规格的情况下以规格库存为准
        NSInteger goodsnumbers = [self.inventoryNumArray[_goods_spe] integerValue];
        if (textnumber<goodsnumbers) {
            self.goodsNumber = textnumber;
        }else {
            [self showHint:@"库存不足"];
        }
    }else {
        NSInteger goodsat = [self.goodinventoryNumArray[0] integerValue];
        if (textnumber<goodsat) {
            self.goodsNumber = textnumber;
        }else {
            [self showHint:@"库存不足"];
        }
        
    }
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:3 inSection:0];
    [specificationTable reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        if (self.goodsspecificationsArray.count == 0) {
            return 0;
        }else {
            return 49;
        }
    }else if (indexPath.row == 1) {
        return labelcell_Height;
    }else if (indexPath.row == 2){
        if (_seleType != 2) {
            return 49;
        }else {
            return 0;
        }
    }else {
        return 50;
    }
}

// 选规格
- (void)selectpec {

    // 获取规格
    for (JXHomepagModel *model in self.goodsspecificationsArray) {
        [self.specificationsArray addObject:[NSString stringWithFormat:@"%@/￥%@(库存:%@)",model.key_name,model.price,model.store_count]];
        [self.goodsPrice addObject:model.price];
        [self.spec_idArray addObject:model.spec_id];
        [self.selectpecs addObject:model.key_name];
        [self.inventoryNumArray addObject:model.store_count];
        
    }
    NSArray *nibContents = [[NSBundle mainBundle] loadNibNamed:@"JXBuyCartAnimationView" owner:nil options:nil];
    _headView = [nibContents lastObject];
    _headView.frame = self.view.bounds;
    _headView.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:_headView];
    
    
    
    
    [_headView setMkmodel:_mkMode];
    
    
    [self.headView.joinbt setTitle:@"确定" forState:(UIControlStateNormal)];
    
    CGFloat maskHeight  = 332-30;
    __weak typeof(self) weakSelf = self;
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC));
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        
        weakSelf.maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, NPHeight-maskHeight)];
        weakSelf.maskView.backgroundColor = [UIColor blackColor];
        weakSelf.maskView.alpha = 0.5;
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        CGRect maskRect = weakSelf.maskView.bounds;
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathAddRect(path, nil, maskRect);
        [maskLayer setPath:path];
        CGPathRelease(path);
        weakSelf.maskView.layer.mask = maskLayer;
        [weakSelf.maskView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClick:)]];
        [_headView addSubview:weakSelf.maskView];
        [_headView sendSubviewToBack:weakSelf.maskView];
    });
    
    // 关闭
    _headView.close = ^{
        
        [weakSelf.maskView removeFromSuperview];
        if (_delegate && [_delegate respondsToSelector:@selector(presentedOneControllerPressedDissmiss)])
        {
            [weakSelf.delegate presentedOneControllerPressedDissmiss];
        }
    };
    
    _headView.joinShop = ^{
        
        if ([weakSelf.mkMode.key_name isEqualToString:weakSelf.selectpecs[weakSelf.goods_spe]])
        { // 选择同一个规格的产品
            [weakSelf dismiss];
            
        }else {
            [JXNetworkRequest asyncChangShoppingCartspecificationsgood_id:weakSelf.mkMode.id spec_id:weakSelf.spec_idArray[weakSelf.goods_spe] completed:^(NSDictionary *messagedic) {
                [weakSelf showHint:@"修改成功"];
                [weakSelf dismiss];
                if ([weakSelf.delegate respondsToSelector:@selector(refreshGoodCart)])
                {
                    [weakSelf.delegate refreshGoodCart];
                }
            } statisticsFail:^(NSDictionary *messagedic) {
                [weakSelf showHint:messagedic[@"msg"]];
            } fail:^(NSError *error) {
                
            }];
        }
    };
}

// 选产品
- (void)processTheData {
    // 获取规格
    for (JXHomepagModel *model in self.goodsspecificationsArray) {
        [self.specificationsArray addObject:[NSString stringWithFormat:@"%@/￥%@(库存:%@)",model.key_name,model.price,model.store_count]];
        [self.spec_idArray addObject:model.spec_id];
        [self.goodsPrice addObject:model.price];
        [self.inventoryNumArray addObject:model.store_count];
    }
    NSArray *nibContents = [[NSBundle mainBundle] loadNibNamed:@"JXBuyCartAnimationView" owner:nil options:nil];
    _headView = [nibContents lastObject];
    _headView.frame = self.view.bounds;
    _headView.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:_headView];
    // 显示数据
    for (JXHomepagModel *model in self.goodsInformationArray) {
        [_headView setModel:model];
        _good_id = model.id;
        [self.goodinventoryNumArray addObject:model.good_number];
    }
    
    CGFloat maskHeight  = 332-30;
    __weak typeof(self) weakSelf = self;
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC));
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        
        weakSelf.maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, NPHeight-maskHeight)];
        weakSelf.maskView.backgroundColor = [UIColor blackColor];
        weakSelf.maskView.alpha = 0.5;
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        CGRect maskRect = weakSelf.maskView.bounds;
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathAddRect(path, nil, maskRect);
        [maskLayer setPath:path];
        CGPathRelease(path);
        weakSelf.maskView.layer.mask = maskLayer;
        [weakSelf.maskView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClick:)]];
        [_headView addSubview:weakSelf.maskView];
        [_headView sendSubviewToBack:weakSelf.maskView];
    });
    
    // 关闭
    _headView.close = ^{
        
        [weakSelf.maskView removeFromSuperview];
        if (_delegate && [_delegate respondsToSelector:@selector(presentedOneControllerPressedDissmiss)]) {
            [weakSelf.delegate presentedOneControllerPressedDissmiss];
        }
    };
    _goods_idArray = @[].mutableCopy;
    // 加入购物车
    __weak typeof(self)root = self;
    _headView.joinShop = ^{
        
        if (self.inventoryNumArray.count>0) { // 有规格的情况下以规格库存为准
            NSInteger goodsnumbers = [root.inventoryNumArray[root.goods_spe] integerValue];
            if (goodsnumbers<=0) {
                [root showHint:@"亲,没货了"];
                return ;
            }
        }else {
            if (root.goodinventoryNumArray.count!=0) {
                NSInteger indexnumber = [root.goodinventoryNumArray[0] integerValue];
                if (indexnumber<=0) {
                    [root showHint:@"亲,没货了"];
                    return ;
                }
            }
            
        }
        
        
        
        
        [JXJudgeStrObjc addgoods_idCart:[NSString stringWithFormat:@"%@",root.good_id]];
        NSDictionary *sidic = [JXUserDefaultsObjc loginUserSid];
        NSString *sid = sidic[@"info"];
        if (root.spec_idArray.count == 0) { // 没有规格的
            [JXNetworkRequest asyncJoinGoodsCartsession_id:sid good_id:[NSString stringWithFormat:@"%@",root.good_id] goods_number:root.goodsNumber spec_id:nil completed:^(NSDictionary *messagedic) {
                // 返回商品的数量
                
                if ([root.delegate respondsToSelector:@selector(returnGoods_number:)]) {
                    [root.delegate returnGoods_number:weakSelf.goodsNumber];
                }
                
                // 退出弹窗
                [root dismiss];
                [root showHint:messagedic[@"msg"]];
            } statisticsFail:^(NSDictionary *messagedic) {
                [root is_login:messagedic];
                [root showHint:messagedic[@"msg"]];
            } fail:^(NSError *error) {
                
            }];
            
        }else {
            
            [JXNetworkRequest asyncJoinGoodsCartsession_id:sid good_id:[NSString stringWithFormat:@"%@",root.good_id] goods_number:root.goodsNumber spec_id:root.spec_idArray[root.goods_spe] completed:^(NSDictionary *messagedic) {
                // 返回商品的数量
                if ([root.delegate respondsToSelector:@selector(returnGoods_number:)]) {
                    [root.delegate returnGoods_number:weakSelf.goodsNumber];
                }
                // 退出弹窗
                [root dismiss];
                [root showHint:messagedic[@"msg"]];
            } statisticsFail:^(NSDictionary *messagedic) {
                [root is_login:messagedic];
                [root showHint:messagedic[@"msg"]];
            } fail:^(NSError *error) {
                
            }];
            
        
        }
    };
    [specificationTable reloadData];
    
}
// 是否登录
- (void)is_login:(NSDictionary *)messagedic {

    if ([messagedic[@"status"] integerValue] == 600) {
        JXLoginViewController *login = [[JXLoginViewController alloc] init];
        login.logindelegate = self;
        [self presentViewController:[[UINavigationController alloc] initWithRootViewController:login] animated:YES completion:nil];
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





// 标签
- (void)creatKeywordCubCellWithArray :(NSArray *)keywordArray toArray :(NSMutableArray *)mutableArray specificationsView:(UIView *)specificationsView  heightCallBack :(AZXHeightCallBack)callBack
{
    [mutableArray removeAllObjects];

    //  关键词组流水布局
    for (int i = 0; i < keywordArray.count; i++) {
        //  设置参数
        CGFloat kKeywordMargin = 10;      // 关键词Btn间距
        CGFloat kBtnLeftMarginToCub = 15; //  按钮距屏幕左边距
        CGFloat kBtnRightMarginToCub = 15; // 按钮距屏幕右边距
        
        UIButton *btn = [[UIButton alloc] init];
        btn.tag = i;
        [btn addTarget:self action:@selector(hotArrayBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        if (_mkMode.key_name != nil || _mkMode.key_name.length>0) {
            
            if ([_mkMode.key_name isEqualToString:self.selectpecs[i]]) { // 选中的规格
                btn.layer.borderWidth = 0.5;
                btn.layer.borderColor = [UIColor redColor].CGColor;
                [btn setTitle:keywordArray[i] forState:(UIControlStateNormal)];
                [btn setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
            }else {
                btn.layer.borderWidth = 0.5;
                btn.layer.borderColor = kUIColorFromRGB(0xcccccc).CGColor;
                [btn setTitle:keywordArray[i] forState:(UIControlStateNormal)];
                [btn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
            }
        }else {
            //  边框
            if (i == 0)
            {
                btn.layer.borderWidth = 0.5;
                btn.layer.borderColor = [UIColor redColor].CGColor;
                [btn setTitle:keywordArray[i] forState:(UIControlStateNormal)];
                [btn setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
                
            }
            else
            {
                btn.layer.borderWidth = 0.5;
                btn.layer.borderColor = kUIColorFromRGB(0xcccccc).CGColor;
                [btn setTitle:keywordArray[i] forState:(UIControlStateNormal)];
                [btn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
                
            }
        }
        
        [btn.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
        //  设置btn宽度和高度
        [btn sizeToFit];
        btn.width += 20;
        btn.height = 30;
        btn.layer.cornerRadius = 3;
        btn.layer.masksToBounds = YES;
        
        btn.backgroundColor = [UIColor whiteColor];
        
        //    流水排布
        if (btn.width > specificationsView.width - 2 * kKeywordMargin)  // 设置Btn最大宽度
        {
            btn.width = specificationsView.width - 2 * kKeywordMargin;
        }
        //  计算Btn的frame
        UIButton *lastBtn = mutableArray.lastObject;
        if (lastBtn == nil)     //  第一个Btn位置
        {
            btn.left = kBtnLeftMarginToCub;
            btn.top = 0;
        }
        else
        {
            CGFloat widthPart = CGRectGetMaxX(lastBtn.frame) + kKeywordMargin;
            btn.left = specificationsView.width - widthPart - kBtnRightMarginToCub > btn.width ? widthPart : kBtnLeftMarginToCub;
            btn.top = specificationsView.width - widthPart - kBtnRightMarginToCub > btn.width ? lastBtn.frame.origin.y : CGRectGetMaxY(lastBtn.frame) + kKeywordMargin;
        }
    
        //  添加Btn
        [mutableArray addObject:btn];
        [specificationsView addSubview:btn];
    }
    UIButton *btn = mutableArray.lastObject;
    specificationsView.height = CGRectGetMaxY(btn.frame);
    if (callBack) {
        callBack(specificationsView.height);
    }
}

#pragma mark --- 规格按钮
- (void)hotArrayBtnClick :(UIButton *)btn {
    _goods_spe = btn.tag;
    NSString *price = self.goodsPrice[_goods_spe];
    _headView.goodprice.text = [NSString stringWithFormat:@"￥%@",price];
    //  返回索引号
    for (UIButton *bt in self.labelbtArray) {
        if (bt.tag == btn.tag) {
            bt.layer.borderWidth = 0.5;
            bt.layer.borderColor = [UIColor redColor].CGColor;
            [bt setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
        }else {
            bt.layer.borderWidth = 0.5;
            bt.layer.borderColor = kUIColorFromRGB(0xcccccc).CGColor;
            [bt setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        }
    }
    // 换规格重置数量
     _goodsNumber = 1;
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:0];
    [specificationTable reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


- (void)dismiss{
    [self.maskView removeFromSuperview];
    if (_delegate && [_delegate respondsToSelector:@selector(presentedOneControllerPressedDissmiss)]) {
        [_delegate presentedOneControllerPressedDissmiss];
    }
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return [XWPresentOneTransition transitionWithTransitionType:XWPresentOneTransitionTypePresent];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    return [XWPresentOneTransition transitionWithTransitionType:XWPresentOneTransitionTypeDismiss];
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator{
    return _interactiveDismiss.interation ? _interactiveDismiss : nil;
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id<UIViewControllerAnimatedTransitioning>)animator{
    XWInteractiveTransition *interactivePresent = [_delegate interactiveTransitionForPresent];
    return interactivePresent.interation ? interactivePresent : nil;
}

@end
