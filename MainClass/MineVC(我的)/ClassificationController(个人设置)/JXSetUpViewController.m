//
//  JXSetUpViewController.m
//  JaneCargo
//
//  Created by 鹏 on 2017/7/24.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXSetUpViewController.h"
#import "JXSetUpTableViewCell.h"
#import "JXSetUpContactTableViewCell.h"

#import "JXGenderTableViewController.h"
// QQ
#import "JXPhotoViewController.h"
// 邮箱 修改 绑定
#import "JXEmailViewController.h"
#import "JXBindEmailViewController.h"
// 实名认证
#import "JXRealNameViewController.h"
#import "JXIsRealNameViewController.h"
// 修改密码
#import "JXModifyPassWordViewController.h"
// 修改手机号
#import "JXChangePhotoViewController.h"

#import "JXMineExitTableViewCell.h"
// 自定义导航
#import "DCHoverNavView.h"

@interface JXSetUpViewController ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate,GenderDelegate>{ // ,BindEmailDelegate,ModifyEmailDelegate GenderDelegate,MessagesDelegate,

    NSInteger is_certification;
    BOOL is_dropdown;
}


@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) UITableView *setTableView;
@property (nonatomic, strong) NSMutableArray *dateArray;
@property (nonatomic, strong) NSMutableArray *certificationArray;
// 旋转
//@property (nonatomic, strong) UIView *loading;
@property (nonatomic, strong) JXRotating *loading;

// 自定义导航
@property (strong , nonatomic)DCHoverNavView *hoverNavView;

@end

@implementation JXSetUpViewController
static const CGFloat MJDuration = 0.5;


#pragma mark - LifeCyle
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
     [self is_userinfoMessage];
    [self.navigationController setNavigationBarHidden:YES];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}



- (NSArray *)titleArray {
    return @[@"手机号码",@"QQ",@"邮箱",@"性别"];
}


- (void)is_userinfoMessage{
    

    self.loading = [JXRotating initWithRotaing];
    [self.view addSubview:self.loading];
    [JXNetworkRequest asyncAllUserInfomationIs_Cache:NO refreshCache:NO completed:^(NSDictionary *messagedic) {
        // 保存用户信息
        NSMutableDictionary *userdic = @{}.mutableCopy;
        for (NSString *content in messagedic[@"info"]) {
            
            NSString *value = [NSString stringWithFormat:@"%@",[messagedic[@"info"] objectForKey:content]];
            if (![value isEqualToString:@"<null>"]) {
                [userdic setObject:value forKey:content];
            }
        }
        [self endofthedropdown];
        [JXUserDefaultsObjc storageLoginUserInfo:[NSDictionary dictionaryWithDictionary:userdic]];
        [self dateArray_date];
    } statisticsFail:^(NSDictionary *messagedic) {
        [self endofthedropdown];
    } fail:^(NSError *error) {
        [self endofthedropdown];
    }];
}

// 处理数据
- (void)dateArray_date {
    // 实名认证 0-未认证  1-认证
    _dateArray = @[].mutableCopy;
    _certificationArray = @[].mutableCopy;
    NSDictionary *user = [JXUserDefaultsObjc loginUserInfo];
    if (!kDictIsEmpty(user)) {
        NSString *photo = [JXJudgeStrObjc judgestr:user[@"phone"]];
        NSString *qq = [JXJudgeStrObjc judgestr:user[@"qq"]];
        NSString *email = [JXJudgeStrObjc judgestr:user[@"email"]];
//        NSString *billname = [JXJudgeStrObjc judgestr:user[@"billname"]];
        NSString *sex = [JXJudgeStrObjc judgestr:user[@"sex"]];
        [_dateArray addObject:photo];
        [_dateArray addObject:qq];
        [_dateArray addObject:email];
//        [_dateArray addObject:billname];
        [_dateArray addObject:sex];
        
        NSString *certification = [JXJudgeStrObjc judgestr:[NSString stringWithFormat:@"%@",user[@"is_cid"]]];
        NSString *certification_str;
        if ([certification integerValue] == 0) {
            certification_str = @"未认证";
        }else if ([certification integerValue] == 1) {
            certification_str = @"已认证";
        }
        is_certification = [certification integerValue];
        [_certificationArray addObject:certification_str];
    }
    
    [self.setTableView reloadData];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    [self table];
    [self.view setBackgroundColor:kUIColorFromRGB(0xf2f2f2)];
}



- (void)table {
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.setTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, NPWidth, NPHeight) style:UITableViewStylePlain];
    self.setTableView.delegate = self;
    self.setTableView.dataSource = self;
    self.setTableView.showsVerticalScrollIndicator = NO;
    [self.setTableView setBackgroundColor:kUIColorFromRGB(0xf2f2f2)];
    self.setTableView.separatorStyle = UITableViewCellEditingStyleNone;
    [self.view addSubview:self.setTableView];
    if (@available(iOS 11.0, *)) {
        self.setTableView.contentInsetAdjustmentBehavior =UIScrollViewContentInsetAdjustmentNever;
        self.setTableView.contentInset =UIEdgeInsetsMake(0,0,0,0);//64和49自己看效果，是否应该改成0
        self.setTableView.scrollIndicatorInsets =self.setTableView.contentInset;
        [JXEncapSulationObjc clearNavigation:self];
    }
    [self aboutNagivation];
}

- (void)aboutNagivation {
    
//    UILabel * titleLabel =[[UILabel alloc]init];
//    titleLabel.text = @"用户信息";
//    [titleLabel sizeToFit];
//    titleLabel.textColor = [UIColor whiteColor];
//    self.navigationItem.titleView = titleLabel;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.setTableView.separatorStyle = UITableViewCellEditingStyleNone;
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_后退_白色"] style:(UIBarButtonItemStylePlain) target:self action:@selector(leftAction:)];
    
    _hoverNavView = [[DCHoverNavView alloc] init];
     [self.view bringSubviewToFront:_hoverNavView];
    _hoverNavView.titleLabel.text = @"用户信息";
    [_hoverNavView leftAndrightImageleft:@"icon_后退_白色" right:@""];
    _hoverNavView.frame = CGRectMake(0, 0, NPWidth, 64);
    [self.view addSubview:_hoverNavView];
    __weak typeof(self)weakSelf = self;
    
    _hoverNavView.leftItemClickBlock = ^{
        [weakSelf leftActionbt];
    };
    _hoverNavView.rightItemClickBlock = ^{
        
    };
}

- (void)leftActionbt {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}



- (void)leftAction:(UIBarButtonItem *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 1) {
        return 4;
    }
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        JXSetUpTableViewCell *cell = [JXSetUpTableViewCell cellWithTable];
        [cell setBackgroundColor:[UIColor redColor]];
        return cell;
    }else if (indexPath.section == 4) {
        JXMineExitTableViewCell *cell = [JXMineExitTableViewCell cellWithTable];
        [cell setBackgroundColor:[UIColor whiteColor]];
        return cell;
    
    }else {
        
        JXSetUpContactTableViewCell *cell = [JXSetUpContactTableViewCell cellWithTable];
        if (indexPath.section == 1) {
            [cell setTitle:[self titleArray][indexPath.row]];
            if (self.dateArray.count > 0) {
                [cell setNumber:self.dateArray[indexPath.row] row:indexPath.row];
            }
        }else if (indexPath.section == 2) {
            [cell setTitle:@"实名认证"];
            if (self.certificationArray.count>0) {
                [cell setNumber:self.certificationArray[indexPath.row] row:indexPath.row];
            }
        }else {
            [cell setTitle:@"修改密码"];
        }
        return cell;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) { // 上传头像s
        
        [self asyncUpLoadPortait];
        
    }else if (indexPath.section == 1){ // 选择
        
        switch (indexPath.row) {
            case 0: { // 手机号码
//                JXChangePhotoViewController *chang = [[JXChangePhotoViewController alloc] init];
//                if (_dateArray.count>0) {
//                    chang.photoStr = _dateArray[indexPath.row];
//                }
//                [self.navigationController pushViewController:chang animated:YES];
            }
                break;
            case 1: { // QQ
                JXPhotoViewController *photo = [[JXPhotoViewController alloc] init];
//                photo.messagedelegate = self;
                if (_dateArray.count>0) {
                    photo.qq_str = _dateArray[indexPath.row];
                }
                photo.navigationTitle = @"QQ";
                [self.navigationController pushViewController:photo animated:YES];
            }
                break;
            case 2: { // 电子邮箱
                NSString *emailStr;
                if (_dateArray.count>indexPath.row-1) {
                    emailStr = _dateArray[indexPath.row];
                }
                if (emailStr.length>6) {
                    JXEmailViewController *emial = [[JXEmailViewController alloc] init];
//                  emial.modifymaildelegate = self;
                    emial.email_str = emailStr;
                    [self.navigationController pushViewController:emial animated:YES];
                    
                }else { // 绑定
                    JXBindEmailViewController *emial = [[JXBindEmailViewController alloc] init];
//                    emial.bindemaildelegate = self;
                    [self.navigationController pushViewController:emial animated:YES];
                }
            }
                break;
//            case 3: { // 发票抬头
//                JXPhotoViewController *photo = [[JXPhotoViewController alloc] init];
//                photo.messagedelegate = self;
//                photo.navigationTitle = @"发票抬头";
//                [self.navigationController pushViewController:photo animated:YES];
//            }
//                break;
            case 3: { // 性别
                
                JXGenderTableViewController *gender = [[JXGenderTableViewController alloc] init];
                gender.genderdelegate = self;
                KDLOG(@"%@",self.dateArray);
                if (!kStringIsEmpty(self.dateArray[indexPath.row])) {
                    gender.sexNum = [self.dateArray[indexPath.row] integerValue];
                    
                }
                
                [self.navigationController pushViewController:gender animated:YES];
            }
                break;
            default:
                break;
        }
        
    }else if (indexPath.section == 2) { // 实名认证
        
        if (is_certification == 0)
        {
            // 未认证
            JXRealNameViewController *realName = [[JXRealNameViewController alloc] init];
            [self.navigationController pushViewController:realName animated:YES];
        }
        else if (is_certification == 1)
        {
            // 认证过的
            JXIsRealNameViewController *isrealName = [[JXIsRealNameViewController alloc] init];
            [self.navigationController pushViewController:isrealName animated:YES];
        }
        
        
     }else if (indexPath.section == 3){ // 修改密码
        
        JXModifyPassWordViewController *password = [[JXModifyPassWordViewController alloc] init];
        [self.navigationController pushViewController:password animated:YES];
        
        
    }else if (indexPath.section == 4) {
        // 退出登录
        [self exitLogin];
    }
    
}
#pragma mark -- 退出登录
- (void)exitLogin {

    [JXNetworkRequest asyncExitcompleted:^(NSDictionary *messagedic) {
        // 退出登录
        [JXUserDefaultsObjc deletegoos_idForsid];
        [JXUserDefaultsObjc deletegoos_idForCart];
        [JXUserDefaultsObjc changeLoginStrat];
        [JXUserDefaultsObjc deleteAddress];
        [JXUserDefaultsObjc deleteUserInfo];
        if ([_logoutdelegate respondsToSelector:@selector(logOut)]) {
            [_logoutdelegate logOut];
        }
        [self showHint:@"退出成功"];
        [self.navigationController popViewControllerAnimated:YES];
    } statisticsFail:^(NSDictionary *messagedic) {
        [self showHint:@"退出失败"];
    } fail:^(NSError *error) {
        
    }];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        return 140;
    }else {
        return TableViewControllerCell_Height;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        return 0;
    }else {
        return 10;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, NPWidth, 10)];
    return view;
    
}
#pragma mark -- 性别代理 1男2女
- (void)returnGender:(JXGenderTableViewController *)gender sex:(NSInteger)sex {
    
//    [self is_userinfoMessage];
}
//#pragma mark -- QQ 发票抬头  1是QQ
//- (void)returnMessage:(JXPhotoViewController *)gender content:(NSString *)content type:(NSInteger)type{
//    
//    [self is_userinfoMessage];
//}
//
//#pragma mark --- 邮箱绑定 修改代理
//- (void)bindingSuccessEmail {
//    [self is_userinfoMessage];
//}
//- (void)modifySuccessEmail {
//    [self is_userinfoMessage];
//}






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
    [self presentViewController:imagePickerController animated:YES completion:NULL];
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
    self.setTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadNewData];
        
    }];
    // 马上进入刷新状态
    [self.setTableView.mj_header beginRefreshing];
}
- (void)loadNewData {
    
    [self.dateArray removeAllObjects];
    [self.certificationArray removeAllObjects];
    // 刷新过程中停止交互
    self.setTableView.scrollEnabled = NO;
    // 刷新表格
    
    // 直接控制下拉时间避免等待时间过长
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(MJDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self is_userinfoMessage];
        
    });
}
#pragma mark -- 下拉结束
- (void)endofthedropdown {
    // 拿到当前的下拉刷新控件，结束刷新状态
    [self.setTableView.mj_header endRefreshing];
    self.setTableView.scrollEnabled = YES;
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
