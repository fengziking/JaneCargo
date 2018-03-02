//
//  JXSpecificationLabelTableViewCell.h
//  JaneCargo
//
//  Created by 鹏 on 2017/9/12.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JXSpecificationLabelTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *labelView;
+ (instancetype)cellWithTable;
@end
