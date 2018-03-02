//
//  JXBranchOrderViewController.h
//  JaneCargo
//
//  Created by cxy on 2017/7/7.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
// 订单详情
#import "JXOrderDetailViewController.h"
#import "JXBranchOrderTableViewCell.h"
#import "JXBranchGoodsTableViewCell.h"
#import "JXSettlementTableViewCell.h"
#import "JXBranchPayTableViewCell.h"
// 没有订单
#import "JXNoOrderTableViewCell.h"

@protocol FunctionScrdelegate <NSObject>

// 返回当前的滑动
- (void)wxPayscrollectiongIndex:(NSInteger)index;

@end

@interface JXBranchOrderViewController : UITableViewController


// 全部数据源
@property (nonatomic,strong) NSMutableArray *dateArray;
// 待付款
@property (nonatomic,strong) NSMutableArray *paymentArray;
// 待发货
@property (nonatomic,strong) NSMutableArray *deliveryArray;
// 待收货
@property (nonatomic,strong) NSMutableArray *goodsArray;
// 去评论
@property (nonatomic,strong) NSMutableArray *commentsArray;
// 退换货
@property (nonatomic,strong) NSMutableArray *returnArray;
// 回收站
@property (nonatomic,strong) NSMutableArray *stationArray;
// 推荐
@property (nonatomic,strong) NSMutableArray *recommendedArray;

//@property (nonatomic, assign) NSInteger indexType;


- (void)jumpInterface:(MKOrderListModel *)model type:(NSInteger)type;
- (void)orderMessageModel:(MKOrderListModel *)model;
- (void)showPromotion:(UITableViewCell *)cell;

@property (nonatomic, assign)id<FunctionScrdelegate>funcdelegate;



@end
