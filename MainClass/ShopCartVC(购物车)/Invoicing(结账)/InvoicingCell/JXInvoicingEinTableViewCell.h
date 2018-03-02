//
//  JXInvoicingEinTableViewCell.h
//  JaneCargo
//
//  Created by 鹏 on 2017/7/31.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol InvoicingTextFieldDelegate <NSObject>

- (void)invoicingText:(NSString *)text tag:(NSInteger)tag;
- (void)idnumberIsWrong;

@end

@interface JXInvoicingEinTableViewCell : UITableViewCell

+ (instancetype)cellWithTable;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *placeText;
@property (nonatomic, strong) NSIndexPath *index_row;
- (void)setTextTag:(NSInteger)tag;
@property (nonatomic, assign) id<InvoicingTextFieldDelegate>invoicdelegate;

@end
