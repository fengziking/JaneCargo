//
//  JXRefundImageTableViewCell.h
//  JaneCargo
//
//  Created by 鹏 on 2017/8/5.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^UploadPicBlock)();


@interface JXRefundImageTableViewCell : UITableViewCell
+ (instancetype)cellWithTable;

@property (nonatomic, copy) UploadPicBlock upblock;
- (void)adduploadImage:(UIImage *)image;

@end
