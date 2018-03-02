//
//  JXShareTableViewCells.m
//  JaneCargo
//
//  Created by 鹏 on 2018/1/26.
//  Copyright © 2018年 鹏. All rights reserved.
//

#import "JXShareTableViewCells.h"


@interface JXShareTableViewCells ()

@property (weak, nonatomic) IBOutlet UIView *backview;
@property (weak, nonatomic) IBOutlet UILabel *titlelabelf;
@property (weak, nonatomic) IBOutlet UILabel *titlelabels;
@property (weak, nonatomic) IBOutlet UILabel *titlelabelt;
@property (weak, nonatomic) IBOutlet UIView *line;

@end


@implementation JXShareTableViewCells


+ (instancetype)cellwithTable {
    
    return  [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JXShareTableViewCells class]) owner:self options:nil] lastObject];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setSelectionStyle:(UITableViewCellSelectionStyleNone)];
    self.backgroundColor = kUIColorFromRGB(0xf2f2f2);
    [self.backview.layer setMasksToBounds:true];
    [self.backview.layer setCornerRadius:5.0];
    
    [self.line setBackgroundColor:kUIColorFromRGB(0xe3e3e3)];
    [self.titlelabels setTextColor:kUIColorFromRGB(0x999999)];
    [self.titlelabelt setTextColor:kUIColorFromRGB(0x999999)];
    
    [JXContTextObjc changelabelColor:self.titlelabels range:NSMakeRange(3, 10) color:[UIColor redColor]];
    [JXContTextObjc changelabelColor:self.titlelabelt range:NSMakeRange(3, 10) color:[UIColor redColor]];
    
    
}


- (void)setModel:(JXHomepagModel *)model {
    
    _model = model;
    [_titlelabelf setText:[NSString stringWithFormat:@"缴纳%@元的保证金，升级为邀请账户",model.money]];
    if (iPhone4||iPhone5) {
        [_titlelabelf setFont:[UIFont systemFontOfSize:15]];
    }
    [JXContTextObjc changelabelColor:self.titlelabelf range:NSMakeRange(2, 4) color:[UIColor redColor]];
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    
}

@end
