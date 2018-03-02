//
//  JXNewProductHomeCell.h
//  JaneCargo
//
//  Created by 鹏 on 2017/10/9.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^Classification)(NSInteger typebutton);

@interface JXNewProductHomeCell : UITableViewCell


@property (nonatomic, copy) Classification ification;
+ (instancetype)cellWithTable;

@end
