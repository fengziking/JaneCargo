//
//  ContentStartTableViewCell.h
//  Evaluation
//
//  Created by 鹏 on 2017/9/14.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RefreshTextFieldDelegate <NSObject>

- (void)refreshtextFieldIndex:(NSIndexPath *)indexPath text:(NSString *)text;
- (void)startTypingToEvaluate;
- (void)completeInput;

@end

@interface ContentStartTableViewCell : UITableViewCell <UITextFieldDelegate>
+ (instancetype)cellWithTable;

@property (weak, nonatomic) IBOutlet UITextField *contentTextField;

@property (nonatomic, assign)id<RefreshTextFieldDelegate>refreshdelegate;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, assign) BOOL is_select;
@property (nonatomic, strong) NSString *contentText;



@end
