//
//  JXNetworkRequest.h
//  JaneCargo
//
//  Created by 鹏 on 2017/8/12.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JXNetworkRequest : NSObject

#pragma mark -- 首页接口
+ (void)asyncHomePageIs_Cache:(BOOL)is_Cache refreshCache:(BOOL)refreshCache completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail;
#pragma mark -- 搜索
+ (void)asyncSearchForHotis_Cache:(BOOL)is_Cache refreshCache:(BOOL)refreshCache completed:(void(^)(NSDictionary *messagedic))completed fail:(void(^)(NSError *error))fail;
+ (void)asyncSearchRecordsis_Cache:(BOOL)is_Cache refreshCache:(BOOL)refreshCache localdata:(void(^)(NSArray *messagedic))localdata completed:(void(^)(NSDictionary *messagedic))completed fail:(void(^)(NSError *error))fail;
// 清除搜索记录
+ (void)asyncDeleteSearchRecordsis_Cache:(BOOL)is_Cache refreshCache:(BOOL)refreshCache completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail;
+ (void)asyncSearchGoodkeywords:(NSString *)keyWords pagNumber:(NSInteger)pagNumber ordernum:(NSInteger)ordernum orderprice:(NSInteger)orderprice is_Cache:(BOOL)is_Cache refreshCache:(BOOL)refreshCache completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail;
#pragma mark -- 分类列表
+ (void)asyncClassificationGood_type_id:(NSInteger)good_type_id son_good_type_id:(NSInteger)son_good_type_id is_Cache:(BOOL)is_Cache refreshCache:(BOOL)refreshCache completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail;

#pragma mark -- 商品详情接口
+ (void)asyncGoodsdetails:(NSString*)goodsid is_Cache:(BOOL)is_Cache refreshCache:(BOOL)refreshCache completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail;

#pragma mark -- 商品评论接口
+ (void)asyncGoodseValuation:(NSString*)goodsid page:(NSInteger)page is_Cache:(BOOL)is_Cache refreshCache:(BOOL)refreshCache completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail;

#pragma mark -- 注册接口
+ (void)asyncRegisteredUserName:(NSString *)userName password:(NSString *)password phoneNumber:(NSString *)phoneNumber verificationCode:(NSString *)verification status:(NSString *)status is_Cache:(BOOL)is_Cache refreshCache:(BOOL)refreshCache completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail;

#pragma mark --- 账户查询（账户是否已经存在）
+ (void)asyncUserqueryStatus:(NSString*)status value:(NSString *)value is_Cache:(BOOL)is_Cache refreshCache:(BOOL)refreshCache completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail;

#pragma mark --- 短信验证
+ (void)asyncVerificationCodeStatus:(NSString*)status phoneNumber:(NSString *)phone is_Cache:(BOOL)is_Cache refreshCache:(BOOL)refreshCache completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail;

#pragma mark --- 获取用户信息
+ (void)asyncUserInfomationsid:(NSString*)sid is_Cache:(BOOL)is_Cache refreshCache:(BOOL)refreshCache completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail;

#pragma mark --- 账户密码登录
+ (void)asyncUserLoginUsername:(NSString*)username password:(NSString *)password completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail;

#pragma mark -- 退出登录
+ (void)asyncExitcompleted:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail;

#pragma mark --- 第三方登录 1-qq 2-wx 3-ali
+ (void)asyncThirdPartyLoginToken:(NSString*)token openId:(NSString *)openId is_login:(NSInteger)is_login completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail;

#pragma mark --- 加入购物车
+ (void)asyncJoinGoodsCartsession_id:(NSString*)session_id good_id:(NSString *)good_id goods_number:(NSInteger)goods_number spec_id:(NSString *)spec_id completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail;

#pragma mark ----- 购物车列表
+ (void)asyncGoodsCartcompleted:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail;


#pragma mark --- 第三方登录绑定手机获取验证-- 完善信息
// 获取验证
+ (void)asyncThirVerificationphoneNumber:(NSString*)phoneNumber completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail;
// 绑定手机号
+ (void)asyncThirBindingphoneNumber:(NSString*)phoneNumber phonecode:(NSString *)phonecode thitrLoginType:(NSInteger)thitrLoginType openid:(NSString *)openid completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail;
// 设置账户密码
+ (void)asyncSetUpPassWord:(NSString*)passWord username:(NSString *)username uid:(NSString *)uid completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail;
#pragma mark ----- 忘记密码
+ (void)asyncForgetPassWord:(NSString*)passWord phone:(NSString *)phone phonecode:(NSString *)phonecode completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail;

#pragma mark --- 获取购物车产品规格
+ (void)asyncShoppingCartspecificationsgood_id:(NSNumber*)good_id completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail;

#pragma mark -- 修改购物车产品规格
+ (void)asyncChangShoppingCartspecificationsgood_id:(NSNumber*)good_id spec_id:(NSNumber*)spec_id completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail;

#pragma matk -- 删除购物车产品
+ (void)asyncdeleteShoppingCartspecificationsgood_id:(NSArray*)good_id completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail;

#pragma mark -- 收藏商品
+ (void)asyncCollectionShoppingCartspecificationsgood_id:(NSArray*)good_id completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail;

#pragma mark -- 删除收藏的商品
+ (void)asyncdeleteCollectionShoppingCartspecificationsgood_id:(NSArray*)good_id completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail ;

#pragma mark -- 收藏列表
+ (void)asyncdeleteCollectionListShoppingCartspecificationsPag:(NSString*)pag completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail;

#pragma mark --- 付款
+ (void)asyncPaymentaddress_id:(NSString*)address_id cart_id:(NSArray *)cart_id content:(NSString *)content pay_id:(NSString *)pay_id is_bill:(NSInteger)is_bill rise:(NSString *)rise tax:(NSString *)tax completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail;

#pragma mark-- 用户地址
// 地址列表 sid
+ (void)asyncAddressOftheUserCompleted:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail;
// 上传地址
+ (void)asyncAddtheAddressIs_default:(NSString *)is_default name:(NSString *)name phone:(NSString *)phone address:(NSString *)address s_province:(NSString *)s_province s_city:(NSString *)s_city s_county:(NSString *)s_county completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail;
// 删除地址
+ (void)asyncDeletetheAddressadress_id:(NSString *)adress_id completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail;
// 编辑地址
+ (void)asyncEditorAddressIs_default:(NSString *)is_default address_id:(NSString *)address_id name:(NSString *)name phone:(NSString *)phone address:(NSString *)address s_province:(NSString *)s_province s_city:(NSString *)s_city s_county:(NSString *)s_county completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail;
#pragma mark --- 用户订单
+ (void)asyncuser_orderStatus:(NSString *)status ordersn:(NSString *)ordersn completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail;
#pragma mark -- 购物车数量增减
+ (void)goodsCartIncreaseOrDecrease:(NSString *)goodsnumber goodid:(NSString *)goodid completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail ;
#pragma mark -- 店铺列表
+ (void)goodsListFoeShop:(NSString *)pag completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail;
#pragma mark -- 店铺浏览
+ (void)asyncGoodsListForbrowse:(NSString *)pag completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail ;
#pragma mark -- 积分
+ (void)asyncUserIntegral:(NSString *)pag completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail;
#pragma mark -- 问答 提问
+ (void)asyncQuestionAndAnswer:(NSString *)pag completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail;
+ (void)asyncAskQuestions:(NSString *)content completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail;
#pragma mark --- 关注商家
+ (void)asyncFocusOnBusiness:(NSString *)shop_id completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail;
+ (void)asyncCancelFocusOnBusiness:(NSString *)shop_id completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail;
#pragma mark --- 取消订单
+ (void)asyncCanceltheOrder:(NSString *)ordersn completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail;
#pragma mark --- 提醒发货
+ (void)asyncRemindthedeliveryOrder:(NSString *)ordersn completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail;
#pragma mark --- 确认收货
+ (void)asyncConfirmtheGoodsOrder:(NSString *)ordersn completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail ;
#pragma mark --- 删除订单
+ (void)asyncDeleteOrder:(NSString *)ordersn completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail;
#pragma mark --- 取消退款
+ (void)asynccancelTheRefundOrder:(NSString *)ordersn completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail;

#pragma mark -- 推荐
+ (void)asyncRecommendedcompleted:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail;
#pragma mark --- 邮箱验证码获取 绑定 修改
+ (void)asyncVerificationCodeforemail:(NSString *)email completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail;
+ (void)asyncSetUpemail:(NSString *)email email_code:(NSString *)email_code completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail;
+ (void)asyncModifyemail:(NSString *)email email_code:(NSString *)email_code completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail;
#pragma mark --- 修改用户信息 1性别 2QQ 3手机号
+ (void)asyncsave_info:(NSString *)type value:(NSString *)value completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail;
#pragma mark --- 实名认证
+ (void)asyncCertification:(NSString *)realname noid:(NSString *)noid completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail;
+ (void)asyncObtainCertificationCompleted:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail;
#pragma mark --- 获取用户信息
+ (void)asyncAllUserInfomationIs_Cache:(BOOL)is_Cache refreshCache:(BOOL)refreshCache completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail;
#pragma mark --- 修改密码
+ (void)asyncChangethePassword:(NSString *)password npassword:(NSString *)npassword completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail;
#pragma mark -- 店铺数据
+ (void)asyncStoreseller_id:(NSString *)seller_id completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail;
#pragma mark -- 首页商品更多产品信息
+ (void)asyncMoreGoodsid:(NSString *)goodsid buy_num:(NSString *)buy_num good_price:(NSString *)good_price page:(NSString *)page completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail;
#pragma mark --- 首页新品
+ (void)asyncNewGoodbuy_num:(NSString *)buy_num good_price:(NSString *)good_price page:(NSString *)page completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail;
#pragma mark --- 详情页商品数量查询
+ (void)asynccommentsgood:(NSString *)good_id completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail;
#pragma mark --- 上传相册
+ (void)asyncphoto:(NSString *)basephoto completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail;

#pragma mark --- 物流信息
+ (void)asynclogisticsExpress_number:(NSString *)express_number completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail;

#pragma mark --- 去支付信息
+ (void)asyncPayOrdersn:(NSString *)order completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail;
+ (void)asyncAhuipage:(NSString *)page completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail;
+ (void)asyncEvaluationOrdersn:(NSString *)ordersn arr:(NSString *)arr con:(NSString *)con completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail;
#pragma mark -- 热销
+ (void)asynchotCakesbuy_num:(NSString *)buy_num good_price:(NSString *)good_price page:(NSString *)page completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail;
#pragma mark -- 删除商品浏览记录
+ (void)asyncdeleteGoodsListForbrowse:(NSString *)goodid completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail;
#pragma mark --- 退款
+ (void)asyncrefundorderCompleted:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail;
#pragma mark --- 退款
+ (void)asyncreturn_good:(NSString *)ordersn is_good:(NSString *)is_good is_accpect:(NSString *)is_accpect money:(NSString *)money content1:(NSString *)content1 decs:(NSString *)decs imgs:(NSString *)imgs completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail;
#pragma mark --- 联系商家
+ (void)asyncOrdersn:(NSString *)ordersn completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail;
#pragma mark -- 填写快递单号
+ (void)asyncCourierNumberordersn:(NSString *)ordersn ex_num:(NSString *)ex_num ex_name:(NSString *)ex_name completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail;
#pragma mark -- 开票记录user_bill
+ (void)asyncRecordsofmakeoutanInvoice:(NSString *)pager completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail;
#pragma mark -- 推送内容
+ (void)asyncPushmessagecompleted:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail;
#pragma mark -- 跳转APPstore评价
+ (void)asyncJumpAppStoreCompleted:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail;
#pragma mark -- 快递费
+ (void)asyncForCourierfeeaddress_id:(NSString *)address_id good_ids:(NSArray *)good_ids completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail;
#pragma mark -- 快递名称
+ (void)asyncCouriercompleted:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail;

#pragma mark --- 批发
+ (void)asyncWholesalecompleted:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail;
#pragma mark ---提现金额 滞留金额
+ (void)asyncWithdrawalcompleted:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail ;
+ (void)asyncStrandedgoldcompleted:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail ;
+ (void)asyncZfPaycompleted:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail ;
#pragma mark --- 提现
+ (void)asyncWithdrawalpay_type:(NSString *)pay_type realname:(NSString *)realname alipay_no:(NSString *)alipay_no bank:(NSString *)bank bank_no:(NSString *)bank_no count_money:(NSString *)count_money completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail;
#pragma mark --- 分享
+ (void)asyncShareUrlcompleted:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail;
+ (void)asyncSharepay:(NSString *)pay_id completed:(void(^)(NSDictionary *messagedic))completed statisticsFail:(void(^)(NSDictionary *messagedic))statisticsFail fail:(void(^)(NSError *error))fail ;








@end
