//
//  JXGenderTableViewCell.h
//  JaneCargo
//
//  Created by cxy on 2017/7/6.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JXGenderTableViewCell : UITableViewCell

+ (instancetype)cellWithTable;

@property (weak, nonatomic) IBOutlet UIImageView *iconImage;

@property (nonatomic, assign) BOOL hiddenLine;
@property (nonatomic, strong) NSString *title;
@end
