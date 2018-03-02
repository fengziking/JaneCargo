//
//  ShoppingCartTableViewCell.h
//  ShoppingCart
//
//  Created by 鹏 on 2017/7/11.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MKOrderListModel.h"
@class MKGoodsModel;


typedef void(^ChangeSpecification)(MKGoodsModel *models);

@protocol shopCarCellDelegate <NSObject>

- (void)shopCellSelectedClick :(NSInteger)shopCellTag;
- (void)shopCellEndEditerClick :(NSInteger)shopCellTag beforeBuyNum:(float)beforeBuyNum;
- (void)goodsCatrIncreaseOrDecrease:(NSString *)goodNumber model:(MKGoodsModel *)model;
// 库存不足
- (void)goodsOutofstock:(NSString *)stock;

@end

@interface ShoppingCartTableViewCell : UITableViewCell


// 增加 递减
@property (weak, nonatomic) IBOutlet UIButton *increasebt;
@property (weak, nonatomic) IBOutlet UIButton *diminishingbt;

+ (instancetype)cellWhiTable;
@property (weak, nonatomic) IBOutlet UIView *specificationsView;
@property (weak, nonatomic) IBOutlet UIImageView *specificationsImage;
@property (nonatomic,weak)id <shopCarCellDelegate>shopDelegate;
@property (nonatomic ,strong)MKGoodsModel *goodsModel;

@property (weak, nonatomic) IBOutlet UIButton *selectSpecification;

@property (nonatomic, copy) ChangeSpecification changspec;

@end
