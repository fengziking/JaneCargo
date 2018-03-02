//
//  JXFillNewAddressViewController.h
//  JaneCargo
//
//  Created by cxy on 2017/7/11.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SaveAddressDelegate <NSObject>

- (void)saveaddress;

@end


@interface JXFillNewAddressViewController : UIViewController

@property (nonatomic, assign)id<SaveAddressDelegate>saveaddressdelegate;
// 区分编辑、填写
@property (nonatomic, strong) NSString *editor_str;
@property (nonatomic, strong) JXAddressModel *model;

@end
