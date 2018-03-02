//
//  JXAddressTableViewCell.m
//  JaneCargo
//
//  Created by 鹏 on 2017/7/10.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXAddressTableViewCell.h"


@interface JXAddressTableViewCell ()

@property (weak, nonatomic) IBOutlet UIView *lines;
@property (weak, nonatomic) IBOutlet UIView *line;
@property (weak, nonatomic) IBOutlet UIImageView *selectImage;
@property (weak, nonatomic) IBOutlet UIButton *selectButton;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *photoNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@property (weak, nonatomic) IBOutlet UILabel *deleteLabel;
@property (weak, nonatomic) IBOutlet UILabel *editorLabel;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property (weak, nonatomic) IBOutlet UIButton *editorButton;
@property (weak, nonatomic) IBOutlet UILabel *defaultLabel;

@end

@implementation JXAddressTableViewCell

+ (instancetype)cellWithTable {

    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JXAddressTableViewCell class]) owner:self options:nil] lastObject];
}



- (void)awakeFromNib {
    [super awakeFromNib];
    
    [_line setBackgroundColor:kUIColorFromRGB(0xcccccc)];
    [_lines setBackgroundColor:kUIColorFromRGB(0xcccccc)];
    [_deleteLabel setTextColor:kUIColorFromRGB(0x999999)];
    [_editorLabel setTextColor:kUIColorFromRGB(0x999999)];
}

- (IBAction)selectAction:(UIButton *)sender {
    _select(sender.tag);
}

- (IBAction)deleteAction:(UIButton *)sender {
    _editordelete(@"删除",sender.tag,_model);
}
- (IBAction)editorAction:(UIButton *)sender {
    _editordelete(@"编辑",sender.tag,_model);
}
-  (void)setAddressbtTag:(NSInteger)addressbtTag {

    [_selectButton setTag:addressbtTag];
    [_deleteButton setTag:addressbtTag];
    [_editorButton setTag:addressbtTag];
}

- (void)setSelectImageStr:(NSString *)selectImageStr {
    [_selectImage setImage:[UIImage imageNamed:selectImageStr]];
}

- (void)setModel:(JXAddressModel *)model {

    _model = model;
    if ([model.is_default integerValue] == 1) {// icon_选中
        [self.defaultLabel setText:@"默认地址"];
    }
    self.nameLabel.text = model.name;
    self.photoNumberLabel.text = model.phone;
    
    NSString*prostr= [self procitycount:model.s_province];
    NSString*citystr= [self procitycount:model.s_city];
    NSString*countystr= [self procitycount:model.s_county];
    self.addressLabel.text = [NSString stringWithFormat:@"%@%@%@%@",prostr,citystr,countystr,model.address];
    
}

- (NSString *)procitycount:(NSString *)prostr {
    if (kStringIsEmpty(prostr)) {
        return @"";
    }else {
        return prostr;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
