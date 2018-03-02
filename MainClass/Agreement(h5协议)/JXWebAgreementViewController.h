//
//  JXWebAgreementViewController.h
//  JaneCargo
//
//  Created by 鹏 on 2017/10/14.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, AgreementType) {
    RegisteredAgreement = 0, ///< 注册协议
    PrivacyAgreement,      ///< 隐私
    StatementAgreement,    ///< 声明
    authenticationAgreement, // 实名认证
    
    
};


@interface JXWebAgreementViewController : UIViewController

@property (nonatomic, assign) AgreementType retweetType;


@end
