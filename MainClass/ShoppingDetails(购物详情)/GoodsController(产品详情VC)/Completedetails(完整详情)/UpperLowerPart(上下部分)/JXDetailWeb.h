//
//  JXDetailWeb.h
//  JaneCargo
//
//  Created by 鹏 on 2017/9/26.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JXDetailWeb : UIWebView
@property (nonatomic,strong)UILabel *headLabel;
- (void)setUpUrl_goodsid:(NSString *)good_id;
@end
