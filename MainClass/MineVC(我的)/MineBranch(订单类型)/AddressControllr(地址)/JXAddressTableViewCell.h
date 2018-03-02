//
//  JXAddressTableViewCell.h
//  JaneCargo
//
//  Created by 鹏 on 2017/7/10.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JXAddressModel;
// 选中
typedef void(^Selectdot)(NSInteger tag);
// 编辑 删除
typedef void(^EditorOrdelete)(NSString *start, NSInteger tag,JXAddressModel *model);

@interface JXAddressTableViewCell : UITableViewCell

+ (instancetype)cellWithTable;
@property (nonatomic, copy)Selectdot select;
@property (nonatomic, copy)EditorOrdelete editordelete;
@property (nonatomic, assign) NSInteger addressbtTag;
@property (nonatomic, strong) NSString *selectImageStr;
@property (nonatomic, strong) JXAddressModel *model;

@end
