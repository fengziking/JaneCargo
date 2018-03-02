//
//  JXRefundTextFieldTableViewCell.h
//  JaneCargo
//
//  Created by 鹏 on 2017/8/5.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RefundTextDelegate <NSObject>

- (void)refundTextContent:(NSString *)content type:(NSString *)type;

@end

@interface JXRefundTextFieldTableViewCell : UITableViewCell <UITextFieldDelegate>
+ (instancetype)cellWithTable;

@property (weak, nonatomic) IBOutlet UITextField *refundTextField;

@property (nonatomic, assign) id <RefundTextDelegate>refundtextdelegate;
@property (nonatomic, strong) NSString *is_type;
@property (nonatomic, assign) BOOL canEditing;
@property (nonatomic, strong) NSIndexPath *index;
@end
