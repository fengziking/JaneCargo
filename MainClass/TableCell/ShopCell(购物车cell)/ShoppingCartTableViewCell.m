//
//  ShoppingCartTableViewCell.m
//  ShoppingCart
//
//  Created by 鹏 on 2017/7/11.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "ShoppingCartTableViewCell.h"
#import "MKGoodsModel.h"


@interface ShoppingCartTableViewCell  ()

@property (weak, nonatomic) IBOutlet UIImageView *imageDot;
@property (weak, nonatomic) IBOutlet UIButton *dotButton;
@property (weak, nonatomic) IBOutlet UIImageView *goodsImage;
@property (weak, nonatomic) IBOutlet UILabel *goodsContent;
@property (weak, nonatomic) IBOutlet UIButton *shopdotButton;

// 规格
@property (weak, nonatomic) IBOutlet UILabel *specificationsLabel;


@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *priceHeight;


@property (weak, nonatomic) IBOutlet UILabel *goodsNumber;
@property (weak, nonatomic) IBOutlet UIView *lines;


@property (weak, nonatomic) IBOutlet UIView *linet;

@end


@implementation ShoppingCartTableViewCell


+ (instancetype)cellWhiTable {
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ShoppingCartTableViewCell class]) owner:self options:nil] lastObject];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    [_selectSpecification setEnabled:NO];
    [_lines setBackgroundColor:kUIColorFromRGB(0xe3e3e3)];
    [_linet setBackgroundColor:kUIColorFromRGB(0xe3e3e3)];
    [_goodsImage.layer setBorderWidth:0.5];
    [_goodsImage.layer setBorderColor:[kUIColorFromRGB(0xe3e3e3) CGColor]];
    
}

- (IBAction)shopdotAction:(UIButton *)sender {
    
    _goodsModel.isSelected = !_goodsModel.isSelected;
    _shopdotButton.selected = !_shopdotButton.selected;
    if ([self.shopDelegate respondsToSelector:@selector(shopCellSelectedClick:)]) {
        [self.shopDelegate shopCellSelectedClick:self.tag];
    }
    
}

- (IBAction)dotAction:(UIButton *)sender {
    _goodsModel.isSelected = !_goodsModel.isSelected;
    _shopdotButton.selected = !_shopdotButton.selected;
    
    
    if ([self.shopDelegate respondsToSelector:@selector(shopCellSelectedClick:)]) {
        [self.shopDelegate shopCellSelectedClick:self.tag];
    }
}


// 增加 递减
- (IBAction)increaseAction:(UIButton *)sender {
    // 保存之前值
    float beforeBuyNum = _goodsModel.number;
    if ([self.shopDelegate respondsToSelector:@selector(shopCellEndEditerClick:beforeBuyNum:)]) {
        [self.shopDelegate shopCellEndEditerClick:self.tag beforeBuyNum:beforeBuyNum];
    }
    //
    [self goodsCatrIncrease:[NSString stringWithFormat:@"%.f",_goodsNumber.text.floatValue + 1] model:_goodsModel type:@"+" beforeBuyNum:beforeBuyNum indextag:self.tag];
}


- (IBAction)diminAction:(UIButton *)sender {
    
    // 保存之前值
    float beforeBuyNum = _goodsModel.number;
    // 判断不能小于0.0
    
    if (_goodsNumber.text.floatValue == 1) {
        return;
    }
    if ([self.shopDelegate respondsToSelector:@selector(shopCellEndEditerClick:beforeBuyNum:)]) {
        [self.shopDelegate shopCellEndEditerClick:self.tag beforeBuyNum:beforeBuyNum];
    }
    [self goodsCatrIncrease:[NSString stringWithFormat:@"%.f",_goodsNumber.text.floatValue - 1] model:_goodsModel type:@"-" beforeBuyNum:beforeBuyNum indextag:self.tag];
}


#pragma mark -- 代理 商品的增减
- (void)goodsCatrIncrease:(NSString *)goodNumber model:(MKGoodsModel *)model type:(NSString *)type beforeBuyNum:(CGFloat)beforeBuyNum indextag:(NSInteger)indextag{
    
    [_increasebt setEnabled:NO];
    [_diminishingbt setEnabled:NO];
    [JXNetworkRequest goodsCartIncreaseOrDecrease:goodNumber goodid:[NSString stringWithFormat:@"%@",model.id] completed:^(NSDictionary *messagedic) {
        [JXJudgeStrObjc addgoods_idCart:[NSString stringWithFormat:@"%@",model.good_id]];
        
        [_increasebt setEnabled:YES];
        [_diminishingbt setEnabled:YES];
        KDLOG(@"00000:%@",messagedic[@"msg"]);
        
        if ([type isEqualToString:@"+"]) {
            _goodsModel.number = _goodsNumber.text.floatValue;
            /// 修改模型数据
            _goodsNumber.text = [NSString stringWithFormat:@"%.f",_goodsNumber.text.floatValue + 1];
            
        }else if ([type isEqualToString:@"-"]) {
            
            /// 修改模型数据
            _goodsModel.number = _goodsNumber.text.floatValue;
            _goodsNumber.text = [NSString stringWithFormat:@"%.f",_goodsNumber.text.floatValue - 1];
         }
        
        
        if ([self.shopDelegate respondsToSelector:@selector(goodsCatrIncreaseOrDecrease:model:)]) {
            [self.shopDelegate goodsCatrIncreaseOrDecrease:[NSString stringWithFormat:@"%.f",_goodsModel.number] model:_goodsModel];
        }
        
    } statisticsFail:^(NSDictionary *messagedic) {
        [_increasebt setEnabled:YES];
        [_diminishingbt setEnabled:YES];
        
        if ([self.shopDelegate respondsToSelector:@selector(goodsOutofstock:)]) {
            [self.shopDelegate goodsOutofstock:messagedic[@"msg"]];
        }
        
    } fail:^(NSError *error) {
        [_increasebt setEnabled:YES];
        [_diminishingbt setEnabled:YES];
    }];
    
}


- (void)setGoodsModel:(MKGoodsModel *)goodsModel {
    
    _goodsModel = goodsModel;
    _shopdotButton.selected = _goodsModel.isSelected;
    _goodsContent.text = [NSString stringWithFormat:@"%@",goodsModel.good_name]; // 设置商品名称
    _priceLabel.text = [NSString stringWithFormat:@"¥%.2f",goodsModel.good_price];// 设置商品价格
    _goodsNumber.text = [NSString stringWithFormat:@"%.f",goodsModel.number];
    
    [self.goodsImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Image_Url,goodsModel.good_img]] placeholderImage:[UIImage imageNamed:@"img_图片加载_小"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
    
    if (goodsModel.key_name!=nil) { // f2f2f2
        
        _specificationsLabel.textColor = kUIColorFromRGB(0x999999);
        _specificationsLabel.text = [NSString stringWithFormat:@"%@/¥%.2f",goodsModel.key_name,goodsModel.price];
        [self layoutIfNeeded];
        _goodsModel.cellHeight = CGRectGetMaxY(self.goodsImage.frame)+30;
    }else {
        
        [_specificationsView setHidden:YES];
        _priceHeight.constant = 22;
        [self layoutIfNeeded];
        _goodsModel.cellHeight = CGRectGetMaxY(self.goodsImage.frame)+20;
    }
}


- (IBAction)selectSpecificationAction:(UIButton *)sender {
    
    _changspec(_goodsModel);
    
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
