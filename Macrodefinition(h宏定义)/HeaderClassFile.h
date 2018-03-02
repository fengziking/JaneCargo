//
//  HeaderClassFile.h
//  JaneCargo
//
//  Created by 鹏 on 2017/9/1.
//  Copyright © 2017年 鹏. All rights reserved.
//

#ifndef HeaderClassFile_h
#define HeaderClassFile_h

// 推送
// 引入JPush功能所需头文件
#import "JPUSHService.h"
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
// 如果需要使用idfa功能所需要引入的头文件（可选）
#import <AdSupport/AdSupport.h>
// 讯飞语音
#import "iflyMSC/IFlyMSC.h"


// 微信
#import "WXApiObject.h"
#import "WXApi.h"
#define APP_ID          @"wx052aad8d310ebcf3"
#define APP_SECRET      @"40dd048ecd620acc270acfa7134b3da8"

//  支付宝
#import "Order.h"
#import "APAuthV2Info.h"
#import "RSADataSigner.h"
#import <AlipaySDK/AlipaySDK.h>


// QQ第三方
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/TencentApiInterface.h>
#import <TencentOpenAPI/TencentMessageObject.h>
#import <TencentOpenAPI/QQApiInterfaceObject.h>
#import <TencentOpenAPI/QQApiInterface.h>



// 加密
#import "RSAEncryptor.h"
#import "Base64.h"

#define WXAPP_ID @"wxaf042719dcb882c0"
#define WXAPP_SECRET @"0f94057bc7a1130487e6da8218b785af"  // 需要改

#import "UIViewController+HUD.h"

// 第三方
#import "UIView+SCFrame.h"
#import "UIImage+SCImage.h"
#import "UIImage+GIF.h"
#import "UIImageView+WebCache.h"
#import "SDCycleScrollView.h"
#import "ShapedCard.h"
#import "JSONKit.h"
#import "Listener.h"
#import "Masonry.h"
// 动画
#import "JXGoodsdetailViewController.h"
#import "XWInteractiveTransition.h"
#import "XWPresentOneTransition.h"
// 购物详情
#import "ViewGoodsdetailsController.h"
#import "JXCompletedetailsViewController.h"
// 第三方
#import "AFHTTPSessionManager.h"
//#import "AFHTTPRequestOperation.h"
#import "AFNetworking.h"

#import "MJRefresh.h"
// 缓存
#import "ZYNetWorking.h"
#import "JXNetworkRequest.h"
#import "JXCustomHudview.h"
// 无网状态
#import "JXOffNetView.h"
#import "JXOffNetTableViewCell.h"

#import "JXPodOrPreVc.h"

// 控制不同手机字体大小
#import "JXContTextObjc.h"

// 登录
#import "JXLoginViewController.h"
#import "JXBindingPhototNumberViewController.h"
// 坐标
#import "UIView+Location.h"

#import "ShowMaskView.h"
// model
#import "MJExtension.h"
#import "JXHomepagModel.h"
#import "MKOrderListModel.h"
#import "MKGoodsModel.h"
#import "JXStoreModel.h"
#import "JXAddressModel.h"
#import "JXStoreMore.h"
// 方法集
#import "JXEncapSulationObjc.h"
// 正则
#import "JXRegular.h"
#import "RegularExpressionsBySyc.h"
// 保存用户信息
#import "JXUserDefaultsObjc.h"

// 推荐商品
#import "JXPromotionTitleCell.h"
#import "JXPromotionTableViewCell.h"
#import "JXHomePageLayOut.h"
#import "JXHomePageCollectionViewController.h"
// 推送消息
#import "JXPushMessageViewController.h"

// 结账
#import "JXInvoicingViewController.h"
// objc
#import "JXJudgeStrObjc.h"

#import "JXConstantText.h"
// runtime
//#import "XTSafeCollection.h"
#import "UploadManager.h"
// 语音
#import <Speech/Speech.h>
#import <AVFoundation/AVFoundation.h>
// 协议
#import "JXWebAgreementViewController.h"
// 菊花
#import "JXRotating.h"
//分类
#import "NSArray+cate.h"
#import "UIButton+Block.h"
#import "UIButton+touch.h"
#import "UIButton+EnlargeEdge.h"
#import "UIView+viewController.h"
#import "UIViewController+Dealloc.h"
#import "NSDictionary+NilSafe.h"
#endif /* HeaderClassFile_h */
