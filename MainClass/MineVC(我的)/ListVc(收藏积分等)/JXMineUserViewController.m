//
//  JXMineUserViewController.m
//  JaneCargo
//
//  Created by 鹏 on 17/6/23.
//  Copyright © 2017年 鹏. All rights reserved.
//

#define DCHeadImageTopY 0

#import "JXMineUserViewController.h"
#import "JXIconTableViewCell.h"
#import "JXMineOrderTableViewCell.h"
#import "JXMineCourierTableViewCell.h"
#import "JXMinePlistTableViewCell.h"

#import "JXMineNumberTableViewCell.h"
#import "JXMineArrowTableViewCell.h"
#import "JXMineExitTableViewCell.h"
// 设置
//#import "JXSetUpTableViewController.h"
#import "JXSetUpViewController.h"
// 全部订单
#import "JXAllOrderViewController.h"
// 自定义导航
#import "DCHoverNavView.h"
// 退货
#import "JXReturnGoodFormineViewController.h"
#import "JXAddressViewController.h"
// 优惠券
//#import "JXCouponsViewController.h"

#define NAVBAR_COLORCHANGE_POINT (IMAGE_HEIGHT - NAV_HEIGHT*2)
#define IMAGE_HEIGHT 250
#define NAV_HEIGHT 64


@interface JXMineUserViewController ()<UITableViewDelegate,UITableViewDataSource,LoginDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,LogOutDelegate> {

    BOOL is_dropdown;
    NSInteger is_pay;
    NSInteger is_send;
    NSInteger is_goods;
    NSInteger is_comtent;
}

@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) NSArray *titleArray;
// 头部View
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIImageView *imageIcon;
// 自定义导航
@property (strong , nonatomic)DCHoverNavView *hoverNavView;

@end

static NSInteger offsetY_;

@implementation JXMineUserViewController

static const CGFloat MJDuration = 0.5;

- (NSArray *)titleArray {
    return @[@"帮助中心",@"分享有礼",@"关于我们",@"客服电话"];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self is_userinfoMessage];
}

#pragma mark - 导航栏
- (void)setUpNav {
    
    _hoverNavView = [[DCHoverNavView alloc] init];
    _hoverNavView.titleLabel.text = @"个人中心";
    [self.view insertSubview:_hoverNavView atIndex:1];
    _hoverNavView.frame = CGRectMake(0, DCHeadImageTopY, NPWidth, 64);
    __weak typeof(self)weakSelf = self;
    [_hoverNavView leftAndrightImageleft:@"icon_设置" right:@"icon_消息"];
    _hoverNavView.leftItemClickBlock = ^{
        [weakSelf settingItemClick];
    };
    _hoverNavView.rightItemClickBlock = ^{
        [weakSelf messageItemClick];
    };
}

#pragma mark - 设置
- (void)settingItemClick
{
    // 判断用户是否登录
    BOOL loginbool = [JXUserDefaultsObjc onlineStatus];
    if (loginbool)
    {
        JXSetUpViewController *setUp = [[JXSetUpViewController alloc] init];
        setUp.hidesBottomBarWhenPushed = true;
        setUp.logoutdelegate = self;
        [self.navigationController pushViewController:setUp animated:YES];
    }
    else
    {
        JXLoginViewController *login = [[JXLoginViewController alloc] init];
        login.logindelegate = self;
        [self presentViewController:[[UINavigationController alloc] initWithRootViewController:login] animated:YES completion:nil];
    }
}

#pragma mark - 消息
- (void)messageItemClick {
    
    JXPushMessageViewController *jxpush = [[JXPushMessageViewController alloc] init];
    [self.navigationController pushViewController:jxpush animated:YES];
    
}

#pragma mark - 判断当前ScrollView是上拉还是下拉BeginDragging，BeginDecelerating
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    offsetY_ = scrollView.contentOffset.y;
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    __weak typeof(self)weakSlef = self;
    [UIView animateWithDuration:0.3 animations:^{
        if (scrollView.contentOffset.y < offsetY_){
            weakSlef.hoverNavView.originY = DCHeadImageTopY - 70;
        }
    }completion:^(BOOL finished) {
        weakSlef.hoverNavView.originY = -100;
        [UIView animateWithDuration:0.4 animations:^{
            weakSlef.hoverNavView.originY = DCHeadImageTopY;
        }];
    }];
}

//#pragma 设置StatusBar为白色
//- (UIStatusBarStyle)preferredStatusBarStyle
//{
//    return UIStatusBarStyleLightContent;
//}
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



- (void)viewDidLoad {
    [super viewDidLoad];
    [self table];
    // 退出登录
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logOutResultsAction:) name:@"LogOut" object:nil];
}


// 退出登录
- (void)logOut {
    
    is_pay = 0;
    is_goods = 0;
    is_send = 0;
    is_comtent = 0;
    [self.myTableView reloadData];
    
}
#pragma mark -- 退出登录
- (void)logOutResultsAction:(NSNotification *)objc {
    
    [self logOut];
    
}

#pragma mark - Table
- (void)table {
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, NPWidth, NPHeight-49) style:UITableViewStylePlain];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.showsVerticalScrollIndicator = NO;
    [self.myTableView setBackgroundColor:kUIColorFromRGB(0xf2f2f2)];
    self.myTableView.separatorStyle = UITableViewCellEditingStyleNone;
    [self.view addSubview:self.myTableView];
    if (@available(iOS 11.0, *)) {
        self.myTableView.contentInsetAdjustmentBehavior =UIScrollViewContentInsetAdjustmentNever;
        self.myTableView.contentInset =UIEdgeInsetsMake(0,0,0,0);//64和49自己看效果，是否应该改成0
        self.myTableView.scrollIndicatorInsets =self.myTableView.contentInset;
    }
    
    [self setUpNav];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // 空值隐藏结算
    return 6;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 5) {
        return 4;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0)
    { // 头像
        JXIconTableViewCell *cell = [JXIconTableViewCell cellWithtable];
        [cell setBackgroundColor:kUIColorFromRGB(0x000000)];
        // 登录
        __weak typeof(self)root = self;
        cell.login = ^{ // 判断登录状态
            [root is_login:^{
                [self asyncUpLoadPortait];
            }];
        };
        return cell;
    }
   else if (indexPath.section == 1)
    { // 我的订单
        JXMineOrderTableViewCell *cell = [JXMineOrderTableViewCell cellWithTable];
        return cell;
    }
   else if (indexPath.section == 2)
   { // 订单详情列表
       JXMineCourierTableViewCell *cell = [JXMineCourierTableViewCell cellWithTable];
       [cell setDelivery:[NSString stringWithFormat:@"%ld",(long)is_send]];
       [cell setPayment:[NSString stringWithFormat:@"%ld",(long)is_pay]];
       [cell setGoodslabel:[NSString stringWithFormat:@"%ld",(long)is_goods]];
       [cell setComment:[NSString stringWithFormat:@"%ld",(long)is_comtent]];
       __weak typeof(self)root = self;
        cell.courier = ^(NSInteger type){
            
            [root is_login:^{
                if (type == 4) { // 退货
                    JXReturnGoodFormineViewController *roder = [[JXReturnGoodFormineViewController alloc] init];
                    roder.hidesBottomBarWhenPushed = true;
                    [self.navigationController pushViewController:roder animated:YES];
                }else {
                    JXAllOrderViewController *roder = [[JXAllOrderViewController alloc] init];
                    roder.hidesBottomBarWhenPushed = true;
                    roder.indexController = type+1;
                    [self.navigationController pushViewController:roder animated:YES];
                }
            }];
            
        };
        return cell;
    }
   else if (indexPath.section == 3)
   { // 收藏列表
        JXMinePlistTableViewCell *cell = [JXMinePlistTableViewCell cellWithTable];
       __weak typeof(self)root = self;
        cell.clickplist = ^(NSInteger type) {
            [root is_login:^{
                [root listVCWithType:type];
            }];
        };
        return cell;
    }
   else if (indexPath.section == 4)
   { // 清除缓存
       JXMineNumberTableViewCell *cell = [JXMineNumberTableViewCell cellWithTable];
//       NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
      // [cell setCache:[NSString stringWithFormat:@"%.fM",[self folderSizeAtPath:cachePath]]];
        return cell;
    }
   else
   { //中心 关于我们 客服
       if (indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 2) {
            JXMineArrowTableViewCell *cell = [JXMineArrowTableViewCell cellWithTable];
            [cell setTitle:self.titleArray[indexPath.row]];
            return cell;
        }else {
            JXMineNumberTableViewCell *cell = [JXMineNumberTableViewCell cellWithTable];
            [cell setTitle:self.titleArray[indexPath.row]];
            NSDictionary *user = [JXUserDefaultsObjc loginUserInfo];
            [cell setCache:user[@"tel"]];
            return cell;
        }
    }
}

#pragma mark -- 登录状态
- (void)is_login:(void(^)())notlogged {

    [JXJudgeStrObjc is_login:^(NSInteger message) {
        if (message == 200) {
            notlogged();
        }else if (message == 400) {
            JXLoginViewController *login = [[JXLoginViewController alloc] init];
            login.logindelegate = self;
            [self presentViewController:[[UINavigationController alloc] initWithRootViewController:login] animated:YES completion:nil];
        }
    }];
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    if (section == 0) {
        return 0;
    }else if (section == 1) {
        return 0;
    }else if (section == 2) {
        return 0;
    }else if (section == 3) {
        return 10;
    }else if (section == 4) {
        return 10;
    }else {
        return 10;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    CGFloat width;
    if (section == 0||section == 1||section ==2) {
        width =0;
    }else {
        width =10;
        
    }
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, NPWidth, width)];
    return view;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1) { // 订单
        __weak typeof(self)root = self;
        [root is_login:^{
            JXAllOrderViewController *roder = [[JXAllOrderViewController alloc] init];
            roder.hidesBottomBarWhenPushed = true;
            roder.indexController = 0;
            [self.navigationController pushViewController:roder animated:YES];
        }];
    }
    if (indexPath.section == 4)
    {
        
        NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
        KDLOG(@"%f",[self folderSizeAtPath:cachePath]);
        if ([self folderSizeAtPath:cachePath] == 0)
        { // 没缓存
            [self showHint:@"暂无缓存文件"];
        }
        else
        {
            [JXEncapSulationObjc choseAlerController:self alerTitle:@"清理缓存" contentTitle:@"是否确认清理缓存文件" cancel:@"取消" confirm:@"确认" block:^(id responseCode) {
                
            } choseBlock:^(id choesbk) {
                [self clearCache:cachePath];
                [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
            }];
        }
    }
    if (indexPath.section == 5) {
        switch (indexPath.row) {
            
            case 0: {// 帮助中心 JXHelpCenterViewController
                
                [JXPodOrPreVc barpodVc:@"JXHelpCenterViewController" vcController:self hidesBar:YES];
            }
                break;
            case 1: { // JXShareViewController
                
                [JXPodOrPreVc barpodVc:@"JXShareViewController" vcController:self hidesBar:YES];
            }
                break;
            case 2: {
               [JXPodOrPreVc barpodVc:@"JXAboutUsViewController" vcController:self hidesBar:YES];
                
            }
                break;
            case 3: {
                [self is_login:^{
                    NSDictionary *user = [JXUserDefaultsObjc loginUserInfo];
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",user[@"tel"]]]];
                }];
                
            }
                break;
            default:
                break;
        }
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        return 194;
    }else if (indexPath.section == 1){
        return TableViewControllerCell_Height;
    }else if (indexPath.section == 2) {
        return 70;
    }else if (indexPath.section == 3) {
        return 180;
    }else if (indexPath.section == 6) {
        return TableViewControllerCell_Height+15;
    }else {
        return TableViewControllerCell_Height;
    }
}

#pragma mark --- 登录代理 （获取用户信息更新界面）
- (void)loginSuccessful:(JXLoginViewController *)login {
    [self is_userinfoMessage];
}

- (void)is_userinfoMessage{

    dispatch_queue_t queue = dispatch_get_main_queue();
    
    dispatch_async(queue, ^{
        // 获取sid
        NSDictionary *sidic = [JXUserDefaultsObjc loginUserSid];
        NSString *sid = sidic[@"info"];
        [JXNetworkRequest asyncUserInfomationsid:sid is_Cache:NO refreshCache:NO completed:^(NSDictionary *messagedic) {
            if (![[NSString stringWithFormat:@"%@",messagedic[@"info"][@"wait_send"]] isEqualToString:@"<null>"]) {
                is_send = [messagedic[@"info"][@"wait_send"] integerValue];
                is_pay = [messagedic[@"info"][@"wait_pay"] integerValue];
                is_goods = [messagedic[@"info"][@"wait_accpet"] integerValue];
                is_comtent = [messagedic[@"info"][@"wait_assess"] integerValue];
            }
        } statisticsFail:^(NSDictionary *messagedic) {
            
        } fail:^(NSError *error) {
            
        }];
    });
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
            [self.myTableView reloadData];
        } statisticsFail:^(NSDictionary *messagedic) {
            
        } fail:^(NSError *error) {
            
        }];
    });
}

#pragma mark ----- 收藏 地址 浏览记录 我的积分 开票 问答
- (void)listVCWithType:(NSInteger)type {
    
    switch (type) {
        case 0:
        { // 收藏
            [JXPodOrPreVc barpodVc:@"JXListCollectionViewController" vcController:self hidesBar:YES];
        }
            break;
        case 1:
        { // 地址
//            [JXPodOrPreVc barpodVc:@"JXAddressViewController" vcController:self hidesBar:YES];
            JXAddressViewController *address = [[JXAddressViewController alloc] init];
            address.typeaddres = @"1";
            address.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:address animated:YES];
        }
            break;
        case 2:
        { // 浏览记录 JXBrowseViewController
            [JXPodOrPreVc barpodVc:@"JXBrowseViewController" vcController:self hidesBar:YES];
        }
            break;
        case 3:
        {  // 资金管理  JXManagementViewController

            [JXPodOrPreVc barpodVc:@"JXManagementViewController" vcController:self hidesBar:YES];
        }
            break;
        case 4:
        { // 开票 JXInvoiceViewController
            [JXPodOrPreVc barpodVc:@"JXInvoiceViewController" vcController:self hidesBar:YES];
        }
            break;
        case 5:
        { // 问答 JXAnswerViewController
            [JXPodOrPreVc barpodVc:@"JXAnswerViewController" vcController:self hidesBar:YES];
        }
            break;
        default:
            break;
    }
}


#pragma mark --- 清理缓存
/**
 *  单个文件的大小
 *
 *  @param filePath 文件路径
 *
 *  @return 返回文件大小
 */
- (long long) fileSizeAtPath:(NSString*) filePath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}

/**
 *  遍历文件夹获得文件夹大小，返回多少M
 *
 *  @param folderPath 文件夹路径
 *
 *  @return 返回M
 */

- (float ) folderSizeAtPath:(NSString*) folderPath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) return 0;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize/(1024.0*1024.0);
}
- (void)clearCache:(NSString *)path{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childerFiles=[fileManager subpathsAtPath:path];
        for (NSString *fileName in childerFiles) {
            //过滤掉不想删除的文件
            if ([fileName rangeOfString:[NSString stringWithFormat:@"chat_"]].location == NSNotFound) {
                NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
                [fileManager removeItemAtPath:absolutePath error:nil];
            }
        }
    }
    [[SDImageCache sharedImageCache] cleanDisk];
    [self showHint:@"缓存清理成功"];
}

#pragma mark -- 打开相机、
- (void)asyncUpLoadPortait{
    
    [JXEncapSulationObjc setAlerController:self actionTilte:@"拍照" choseAction:@"相册"  cancel:@"取消" block:^(id responseCode) {
        [self showImagePickerForSourceType:UIImagePickerControllerSourceTypeCamera andCameraCaptureMode:UIImagePickerControllerCameraCaptureModePhoto];
    } choseBlock:^(id choesbk) {
        [self showImagePickerForSourceType:UIImagePickerControllerSourceTypePhotoLibrary andCameraCaptureMode:0];
    }];
}

- (void)showImagePickerForSourceType:(UIImagePickerControllerSourceType)sourceType andCameraCaptureMode:(UIImagePickerControllerCameraCaptureMode)mode{
    
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    //这是 VC 的各种 modal 形式
    imagePickerController.modalPresentationStyle = UIModalPresentationFullScreen;
    imagePickerController.sourceType = sourceType;
    //支持的摄制类型,拍照或摄影,此处将本设备支持的所有类型全部获取,并且同时赋值给imagePickerController的话,则可左右切换摄制模式
    imagePickerController.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
    imagePickerController.delegate = self;
    //允许拍照后编辑
    imagePickerController.allowsEditing = YES;
    //设置导航栏背景颜色
    
    imagePickerController.navigationBar.barTintColor = [UIColor blackColor];
    //设置右侧取消按钮的字体颜色
    imagePickerController.navigationBar.tintColor = [UIColor whiteColor];
    
    //显示默认相机 UI, 默认为yes--> 显示
    //    imagePickerController.showsCameraControls = NO;
    if (sourceType == UIImagePickerControllerSourceTypeCamera) {
        //设置模式-->拍照/摄像
        imagePickerController.cameraCaptureMode = mode;
        //开启默认摄像头-->前置/后置
        imagePickerController.cameraDevice = UIImagePickerControllerCameraDeviceRear;
        //设置默认的闪光灯模式-->开/关/自动
        imagePickerController.cameraFlashMode = UIImagePickerControllerCameraFlashModeAuto;
        
        UIImage *img = [UIImage imageNamed:@"085625KMV.jpg"];
        UIImageView *iv = [[UIImageView alloc] initWithImage:img];
        iv.width = 300;
        iv.height = 200;
        imagePickerController.cameraOverlayView = iv;
    }
//    [self presentViewController:imagePickerController animated:YES completion:NULL];
    [self presentViewController:imagePickerController animated:YES completion:^{
//        UIViewController *controller = imagePickerController.viewControllers.lastObject;
//        UIBarButtonItem *imagepickCancelbt = [controller valueForKey:@"imagePickerCancelButton"];
//        UIButton *button = [imagepickCancelbt valueForKey:@"view"];
//        [button setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    }];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    NSString *mediaType = info[UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:@"public.image"]) { // 判断类型（拍摄还是照片）
        UIImage *edit = [info objectForKey:UIImagePickerControllerEditedImage];  // 获取到的相片

        NSString *imagestrs = [self imageToString:edit];
        
        [self baseImage:imagestrs];
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (NSString *)imageToString:(UIImage *)image {
//    NSData *imagedata = UIImagePNGRepresentation(image);
    NSData *imagedata = UIImageJPEGRepresentation(image, 1);
    float index = 1.0;
    while (imagedata.length > 1024*500) {
        imagedata = UIImageJPEGRepresentation(image, index);
        index = index - 0.1;
    }
    NSString *image64 = [imagedata base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    return image64;
}
- (UIImage *)nstringforbase:(NSString *)encodedImageStr {

    NSData *decodedImageData = [[NSData alloc]
                                
                                initWithBase64EncodedString:encodedImageStr options:NSDataBase64DecodingIgnoreUnknownCharacters];
    
    UIImage *decodedImage = [UIImage imageWithData:decodedImageData];
    
    return decodedImage;
}


- (void)baseImage:(NSString *)imagestr {

    [JXNetworkRequest asyncphoto:imagestr completed:^(NSDictionary *messagedic) {
        [self showHint:@"上传成功"];
        [self is_userinfoMessage];
    } statisticsFail:^(NSDictionary *messagedic) {
        [self showHint:@"上传失败"];
    } fail:^(NSError *error) {
        [self showHint:@"网络连接失败"];
    }];
}

//- (void)updatephoto:(UIImage *)photo {
//
//    [UploadManager uploadImagesWith:[NSArray arrayWithObject:photo] uploadFinish:^{
//        [self is_userinfoMessage];
//    } success:^(NSDictionary *imgDic, int idx) {
//        
//    } failure:^(NSError *error, int idx) {
//        
//    }];
//  
//}

#pragma mark --
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat contentOffset = scrollView.contentOffset.y;
    if (!is_dropdown && contentOffset < -60) {
        is_dropdown = YES;
        [self s_dropdownMJRefresh];
    }
}


#pragma mark UITableView + 下拉刷新 默认
- (void)s_dropdownMJRefresh { // dropdown
    __unsafe_unretained __typeof(self) weakSelf = self;
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadNewData];
        
    }];
    // 马上进入刷新状态
    [self.myTableView.mj_header beginRefreshing];
}
- (void)loadNewData {

    // 刷新表格
    
    // 直接控制下拉时间避免等待时间过长
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(MJDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self is_login:^{
            [self is_userinfoMessage];
        }];
        
        [self endofthedropdown];
        
    });
}
#pragma mark -- 下拉结束
- (void)endofthedropdown {
    // 拿到当前的下拉刷新控件，结束刷新状态
    [self.myTableView.mj_header endRefreshing];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
