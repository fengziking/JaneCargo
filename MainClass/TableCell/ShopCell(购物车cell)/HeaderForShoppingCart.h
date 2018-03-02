//
//  HeaderForShoppingCart.h
//  ShoppingCart
//
//  Created by 鹏 on 2017/7/11.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MKOrderListModel.h"

@protocol headerViewDelegate <NSObject>

- (void)headerSelectedBtnClick: (NSInteger)section;
- (void)storeSelectedBtnClick: (NSInteger)section;

@end

@interface HeaderForShoppingCart : UITableViewHeaderFooterView


@property (nonatomic,strong)UIButton *headerBtn;
@property (nonatomic,strong)UIImageView *storeImage;
@property (nonatomic,strong)UILabel *sectionLabel;
@property (nonatomic,strong)UIImageView *arrowImage;


@property (nonatomic,strong)MKOrderListModel* orderListModel;

@property(nonatomic,weak)id <headerViewDelegate>headerDelegate;

//@property (nonatomic, copy) void(^StoreBlock)(NSInteger index);



@end
