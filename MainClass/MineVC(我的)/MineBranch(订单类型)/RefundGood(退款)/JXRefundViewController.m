//
//  JXRefundViewController.m
//  JaneCargo
//
//  Created by 鹏 on 2017/8/5.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXRefundViewController.h"
#import "JXRefundProcessCell.h"
#import "JXRefundTextFieldTableViewCell.h"
#import "JXRefundImageTableViewCell.h"
#import "JXReasonRefundViewController.h"
#import "JXArowImageTableViewCell.h"
#import "JXReturnGoodFormineViewController.h"

@interface JXRefundViewController ()<UITableViewDelegate,UITableViewDataSource,RefundTextDelegate,ReasonRefundTextContentDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITextFieldDelegate> {
    
    UITableView *refundTable;
    // 区分退款、退货
    NSInteger is_menoyOrGoods;
    // 记录显示选中的Image
    NSInteger is_selectImagef;
    NSInteger is_selectImages;
    
    // 退款类型 2 我要退款 1 我要退货
    NSString *refund_Type;
    // 退款状态 1 已收到货 0 未收到货
    NSString *refund_Strat;
    // 退款金额
    NSString *refund_Money;
    // 退款说明
    NSString *refund_Instructions;
    // 退款原因
    NSString *refund_menoyStr;
    // 上传退款图片
    UIImage *refund_Image;
    NSString *refund_Imagebase;
}
// 退款类型
@property (nonatomic, strong) NSArray *refundTypeArray;
// 退款原因
@property (nonatomic, strong) NSArray *refundWhyArray;
// 退款金额
@property (nonatomic, strong) NSArray *refundWMoneyArray;
// 退款说明
@property (nonatomic, strong) NSArray *refundInstructionsArray;
@property (nonatomic, assign) BOOL canEditing;
// 遮罩
@property (nonatomic, strong) ShowMaskView *showmask;
@property (nonatomic, strong) JXReasonRefundViewController *reason;


@end

@implementation JXRefundViewController

- (NSArray *)refundTypeArray {
    
    return @[@"退款类型",@"我要退款 (无需退货)",@"我要退货",@"收货状态 *",@"未收到货",@"已收到货"];
}
- (NSArray *)refundWhyArray {
    
    return @[@"退款原因 *"];
}
- (NSArray *)refundWMoneyArray {
    return @[@"退款金额 *"];
}
- (NSArray *)refundInstructionsArray {
    
    return @[@"退款说明 (可不填)"];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    is_menoyOrGoods = 100;
    is_selectImagef = 100;
    is_selectImages = 100;
    refund_menoyStr = @"请选择退款原因";
    
    
    UILabel * titleLabel =[[UILabel alloc]init];
    titleLabel.text = @"退款";
    [titleLabel sizeToFit];
    titleLabel.textColor = [UIColor blackColor];
    self.navigationItem.titleView = titleLabel;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_back"] style:(UIBarButtonItemStylePlain) target:self action:@selector(leftAction:)];
    [self layoutTempTable];
}

- (void)leftAction:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)layoutTempTable {
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    refundTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, NPWidth, NPHeight)];
    refundTable.separatorStyle = UITableViewCellEditingStyleNone;
    refundTable.delegate = self;
    refundTable.dataSource = self;
    refundTable.backgroundColor = kUIColorFromRGB(0xf2f2f2);
    [refundTable setShowsVerticalScrollIndicator:NO];
    [self.view addSubview:refundTable];
    
    UIButton *bt = [[UIButton alloc] initWithFrame:CGRectMake(0, NPHeight-50, NPWidth, 50)];
    [bt addTarget:self action:@selector(btAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [bt setBackgroundColor:kUIColorFromRGB(0xe82b48)];
    [bt setTitle:@"提交申请" forState:(UIControlStateNormal)];
    [self.view addSubview:bt];
    
}

#pragma mark -- 提交申请
- (void)btAction:(UIButton *)sender {
    
    if (kStringIsEmpty(refund_Type)) {
        [self showHint:@"请选择退款类型"];
        return;
    }
    if ([refund_Type isEqualToString:@"2"]&&kStringIsEmpty(refund_Strat)) {
        [self showHint:@"请选择收货状态"];
        return;
    }
    if ([refund_menoyStr isEqualToString:@"请选择退款原因"]) {
        [self showHint:@"请选择退款原因"];
        return;
    }
    if (kStringIsEmpty(refund_Money)) {
        [self showHint:@"请输入退款金额"];
        return;
    }else if ([refund_Money floatValue]>[_model.total floatValue]) {
        [self showHint:@"输入的金额大于物品的总金额"];
        return;
    }
    // 退款类型is_good 2 我要退款 1 我要退货 收货状态 is_accpect 1 已收到货 0 未收到货 退货金额 money  退货原因 content1 退货说明 decs 图片 imgs 是数组
    [JXNetworkRequest asyncreturn_good:_model.ordersn is_good:refund_Type is_accpect:refund_Strat money:refund_Money content1:refund_menoyStr decs:refund_Instructions imgs:refund_Imagebase completed:^(NSDictionary *messagedic) {
//        [self.navigationController popViewControllerAnimated:YES];
        // 退换货
        JXReturnGoodFormineViewController *roder = [[JXReturnGoodFormineViewController alloc] init];
        [self.navigationController pushViewController:roder animated:YES];
        
    } statisticsFail:^(NSDictionary *messagedic) {
        
    } fail:^(NSError *error) {
        
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableVie {
    
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0)
    {
        if (is_menoyOrGoods == 1) {
            return 6;
        }else {
            return 3;
        }
    }
    else if (section == 1)
    {
        return 2;
    }
    else if (section == 2)
    {
        return 2;
    }
    else
    {
        return 3;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) // 退款类型
    {
        JXRefundProcessCell *cell = [JXRefundProcessCell cellWithTable];
        
        [cell setTitle:[self refundTypeArray][indexPath.row]];
        if (indexPath.row == 0 || indexPath.row == 3)
        {
            [cell setFontSize:16.0f];
            [cell setBackgroundColor:kUIColorFromRGB(0xf2f2f2)];
            [cell setSelectionStyle:(UITableViewCellSelectionStyleNone)];
        }
        else
        {
            [cell setFontSize:14.0f];
        }
        if (indexPath.row == 1) {
            [cell setLinecolor:kUIColorFromRGB(0xe3e3e3)];
            [cell changeLabelFontSize:14 sizeRange:NSMakeRange(0, 0) color:kUIColorFromRGB(0x999999) colorRange:NSMakeRange(4, 7)];
        }else if (indexPath.row == 3) {
            [cell changeLabelFontSize:16 sizeRange:NSMakeRange(0, 0) color:kUIColorFromRGB(0xef5b4c) colorRange:NSMakeRange(5, 1)];
        }else if (indexPath.row == 4) {
            [cell setLinecolor:kUIColorFromRGB(0xe3e3e3)];
        }
        if (is_selectImagef != indexPath.row && indexPath.row<3) {
            [cell setArowImage_str:@""];
        }else if (is_selectImagef == indexPath.row) {
            [cell setArowImage_str:@"icon_选择"];
        }
        if (is_selectImages != indexPath.row && is_selectImagef>3) {
            [cell setArowImage_str:@""];
        }else if (is_selectImages == indexPath.row) {
            [cell setArowImage_str:@"icon_选择"];
        }
        return cell;
    }
    else if (indexPath.section == 1) // 退款原因
    {
        
        if (indexPath.row == 0) {
            JXRefundProcessCell *cell = [JXRefundProcessCell cellWithTable];
            [cell setTitle:[self refundWhyArray][indexPath.row]];
            [cell setFontSize:16.0f];
            [cell setBackgroundColor:kUIColorFromRGB(0xf2f2f2)];
            [cell setSelectionStyle:(UITableViewCellSelectionStyleNone)];
            [cell changeLabelFontSize:16 sizeRange:NSMakeRange(0, 0) color:kUIColorFromRGB(0xef5b4c) colorRange:NSMakeRange(5, 1)];
            return cell;
        }else {
            JXArowImageTableViewCell *cell = [JXArowImageTableViewCell cellWithTable];
            [cell setTitle:refund_menoyStr];
            return cell;
        }
        
    }
    else if (indexPath.section == 2) // 退款金额
    {
        if (indexPath.row == 0)
        {
            JXRefundProcessCell *cell = [JXRefundProcessCell cellWithTable];
            [cell setFontSize:16.0f];
            [cell setBackgroundColor:kUIColorFromRGB(0xf2f2f2)];
            [cell setTitle:[self refundWMoneyArray][indexPath.row]];
            [cell setSelectionStyle:(UITableViewCellSelectionStyleNone)];
            [cell changeLabelFontSize:16 sizeRange:NSMakeRange(0, 0) color:kUIColorFromRGB(0xef5b4c) colorRange:NSMakeRange(5, 1)];
            return cell;
        }
        else
        {
            JXRefundTextFieldTableViewCell *cell = [JXRefundTextFieldTableViewCell cellWithTable];
            cell.refundtextdelegate = self;
            [cell setIndex:indexPath];
            cell.is_type = @"退款金额";
            if (_canEditing) {
                refund_Money = [NSString stringWithFormat:@"%@",_model.total];
                cell.refundTextField.text = [NSString stringWithFormat:@"%@元",_model.total];
            }else {
                cell.refundTextField.placeholder = [NSString stringWithFormat:@"请输入退款金额(最大金额为%@)",_model.total];
            }
            [cell setCanEditing:_canEditing];
            return cell;
        }
    }
    else  // 退款说明
    {
        if (indexPath.row == 0) {
            JXRefundProcessCell *cell = [JXRefundProcessCell cellWithTable];
            [cell setFontSize:16.0f];
            [cell setTitle:[self refundInstructionsArray][indexPath.row]];
            [cell setBackgroundColor:kUIColorFromRGB(0xf2f2f2)];
            [cell setSelectionStyle:(UITableViewCellSelectionStyleNone)];
            [cell changeLabelFontSize:12 sizeRange:NSMakeRange(4, 6) color:kUIColorFromRGB(0x999999) colorRange:NSMakeRange(4, 6)];
            return cell;
        }else if (indexPath.row == 1) {
            JXRefundTextFieldTableViewCell *cell = [JXRefundTextFieldTableViewCell cellWithTable];
            cell.refundtextdelegate = self;
            cell.is_type = @"退款说明";
            cell.refundTextField.placeholder = @"请输入退款说明";
            if (is_menoyOrGoods == 1) {
                [cell.refundTextField setContentVerticalAlignment:UIControlContentVerticalAlignmentTop];
                [cell.refundTextField setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
            }else {
                [cell.refundTextField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
                [cell.refundTextField setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
            }
            return cell;
        }else {
            
            JXRefundImageTableViewCell *cell = [JXRefundImageTableViewCell cellWithTable];
            [cell setBackgroundColor:kUIColorFromRGB(0xf2f2f2)];
            __weak typeof(self)root = self;
            cell.upblock = ^{
                [root asyncUpLoadPortait];
            };
            [cell adduploadImage:refund_Image];
            return cell;
        }
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        return TableViewControllerCell_Height;
    }else if (indexPath.section == 1) {
        return TableViewControllerCell_Height;
    }else if (indexPath.section == 2) {
        
        return TableViewControllerCell_Height;
    }else if (indexPath.section == 3) {
        
        if (indexPath.row ==0) {
            return TableViewControllerCell_Height;
        }else if (indexPath.row == 1){
            if (is_menoyOrGoods == 1) {
                return 99;
            }else {
                return TableViewControllerCell_Height;
            }
        }else {
            return 59;
        }
    }else {
        return 0;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0)
    {
        if (indexPath.row == 1 || indexPath.row == 2) {
            
            if (indexPath.row == 1) { // 退款
                refund_Type = @"2";
            }
            if (indexPath.row == 2) { // 退货
                refund_Type = @"1";
            }
            is_selectImagef = indexPath.row;
            is_menoyOrGoods = indexPath.row;
            NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:0];
            [refundTable reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
            
            NSIndexSet *sindexSet=[[NSIndexSet alloc]initWithIndex:3];
            [refundTable reloadSections:sindexSet withRowAnimation:UITableViewRowAnimationAutomatic];
            
        }else if (indexPath.row == 4 || indexPath.row == 5) {
            if (indexPath.row == 4) {
                refund_Strat = @"0";
            }
            if (indexPath.row == 5) {
                refund_Strat = @"1";
            }
            is_selectImages = indexPath.row;
            NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:0];
            [refundTable reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
        }
        
        if (indexPath.row == 4) {// 未收到货 退款全额 退款金额不可用户输入
            
            _canEditing = YES;
            NSIndexSet *sindexSet=[[NSIndexSet alloc]initWithIndex:2];
            [refundTable reloadSections:sindexSet withRowAnimation:UITableViewRowAnimationAutomatic];
        }else {
            _canEditing = NO;
            NSIndexSet *sindexSet=[[NSIndexSet alloc]initWithIndex:2];
            [refundTable reloadSections:sindexSet withRowAnimation:UITableViewRowAnimationAutomatic];
        }
        
        
        
    }
    else if (indexPath.section == 1)
    {
        if (indexPath.row == 1) // 退款原因
        {
            [self aRefundReason_view];
        }
    }
    else if (indexPath.section == 2)
    {
        NSLog(@"1");
    }
    else if (indexPath.section == 3)
    {
        NSLog(@"2");
    }
}

#pragma mark -- 点击退款原因
- (void)aRefundReason_view {
    

    self.showmask = [ShowMaskView showMaskViewWith:^{
        
    }];
    [[[UIApplication  sharedApplication] keyWindow] addSubview:self.showmask];
    
    self.reason = [[JXReasonRefundViewController alloc] init];
    
    [self.reason.view setBackgroundColor:[UIColor whiteColor]];
    self.reason.reasond_delegate = self;
    self.reason.select_title = refund_menoyStr;
    [self.reason.view.layer setMasksToBounds:true];
    [self.reason.view.layer setCornerRadius:5.0];
    CGFloat reasonHeight = 0;
    if ([refund_Type isEqualToString:@"2"]&&[refund_Strat isEqualToString:@"0"]) {//未收到货
        self.reason.retweetType = 0;
        reasonHeight = 44*7;
    }else if ([refund_Type isEqualToString:@"2"]&&[refund_Strat isEqualToString:@"1"]){//已收到货
        self.reason.retweetType = 1;
        reasonHeight = 44*11;
    }else if ([refund_Type isEqualToString:@"1"]){ // 退货
        self.reason.retweetType = 2;
        reasonHeight = 44*11;
    }else {
        [self showHint:@"请选择退货原因"];
        [self.showmask removeFromSuperview];
        return;
    };
    [self.reason.view setFrame:CGRectMake(20, (NPHeight-reasonHeight)/2, NPWidth-40, reasonHeight)];
    [self.showmask addSubview:self.reason.view];
}
#pragma mark --- 选择退款原因代理
- (void)reasonRefund_content:(NSString *)content {
     // 空值不操作
    if (!kStringIsEmpty(content)) {
        refund_menoyStr = content;
        // 隐藏弹窗
        [self.showmask removeFromSuperview];
        NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:1];
        [refundTable reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    
}


#pragma mark ---  退款金额 退款说明
- (void)refundTextContent:(NSString *)content type:(NSString *)type{

    if ([type isEqualToString:@"退款金额"])
    {
        refund_Money = content;
    }
    else if ([type isEqualToString:@"退款说明"])
    {
        refund_Instructions = content;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 3) {
        return 50+64;
    }else {
        return 0;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, NPWidth, 50+64)];
    [view setBackgroundColor:kUIColorFromRGB(0xf2f2f2)];
    return view;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
    //显示默认相机 UI, 默认为yes--> 显示
    //    imagePickerController.showsCameraControls = NO;
    
    if (sourceType == UIImagePickerControllerSourceTypeCamera) {
        //设置模式-->拍照/摄像
        imagePickerController.cameraCaptureMode = mode;
        //开启默认摄像头-->前置/后置
        imagePickerController.cameraDevice = UIImagePickerControllerCameraDeviceFront;
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
        refund_Image = edit;
        NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:3];
        [refundTable reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
//        NSData *data = UIImageJPEGRepresentation(edit, 1.0f);
//        NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
//        KDLOG(@"----:%@",encodedImageStr);
        NSString *imagestrs = [self imageToString:edit];
        refund_Imagebase = imagestrs;
        
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
