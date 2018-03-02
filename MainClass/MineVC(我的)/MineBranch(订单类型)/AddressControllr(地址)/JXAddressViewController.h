//
//  JXAddressViewController.h
//  JaneCargo
//
//  Created by 鹏 on 2017/7/10.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  SelectAddressdelegate <NSObject>

- (void)selectaddressModel:(JXAddressModel *)model;

@end

@interface JXAddressViewController : UIViewController

@property (nonatomic,assign)id<SelectAddressdelegate>selectdelegate;

@property (nonatomic, copy) void(^SelectaddressBlock)(JXAddressModel *model);
@property (nonatomic, strong) NSString *addressid;

@property (nonatomic, strong) NSString *typeaddres;

@end
