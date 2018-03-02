//
//  JXInvoicingReturnTableViewCell.h
//  JaneCargo
//
//  Created by 鹏 on 2017/7/28.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JXInvoicingReturnTableViewCell : UITableViewCell

+ (instancetype)cellWithTable;
- (void)setTitle:(NSString *)title price:(NSString *)price;
@end
