//
//  JXEncapSulationObjc.h
//  JaneCargo
//
//  Created by cxy on 2017/6/27.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JXEncapSulationObjc : NSObject {
    
    NSInteger _codeNum;  // 编码
    
}



- (instancetype)initWithCodeNum:(NSInteger)num;
- (NSComparisonResult)compareUsingcodeNum:(JXEncapSulationObjc *)cnum;   // 排序
- (NSComparisonResult)compareUsingcodeblood:(JXEncapSulationObjc *)blood;   // 排序
- (NSInteger)conum;

#pragma mark -- 处理时间并排序
//+ (NSMutableArray *)processingTime:(NSMutableDictionary *)date;
#pragma mark --- 导航颜色
+ (void)clearNavigation:(UIViewController*)contreller;
+ (void)blackNavigation:(UIViewController*)contreller color:(UIColor *)color;

#pragma mark ---- 自适应宽度
+ (CGFloat)stringWidth:(NSString *)aString maxSize:(CGFloat)size fontSize:(CGFloat)fontSize;

#pragma mark ---- 自适应高度
+ (CGFloat)hightForContent:(NSString *)content maxHeight:(CGFloat)heightSize fontSize:(CGFloat)fontSize;
/**
 *  加载图片
 *
 *  @param url   NSURL
 *  @param click button
 */
+ (void)setURLImage:(NSURL *)url clickBt:(UIButton *)click;
// 对图片进行拉伸
+ (UIImage *)resizableImage:(NSString *) imageName;
/**
 *  计算九宫行数便于计算cell的高度
 *
 *  @param arrayNum 数组的总数
 *  @param single   单行限制的个数
 *
 *  @return 返回行数
 */
+ (NSUInteger)s_calculateNumberArrayNum:(NSUInteger)arrayNum singleNumber:(NSUInteger)single;
#pragma mark -- 改变label字体的大小
+ (void)changeWordSize:(UILabel *)label size:(CGFloat)size;
// 防止controller重复加载
+ (void)selectViewAbout:(UITableViewCell *)cell;
// 渐变颜色
+ (void)addGradientColorView:(UIView *)view cgrectMake:(CGRect)frame colors:(NSArray *)colors;
// 提示
+ (void)setAlerController:(UIViewController *)alerController actionTilte:(NSString *)action choseAction:(NSString *)chose  cancel:(NSString *)cancel block:(void(^)(id responseCode))block choseBlock:(void(^)(id choesbk))choseBlock;
+ (void)choseAlerController:(UIViewController *)alerController alerTitle:(NSString *)alerTitle contentTitle:(NSString *)contentTitle cancel:(NSString *)cancel confirm:(NSString *)confirm block:(void(^)(id responseCode))block choseBlock:(void(^)(id choesbk))choseBlock;
+ (void)setCountdownTimeStart:(void(^)(int time))start timeend:(void(^)())end;
// 旋转
+ (UIView *)setTrunAround:(UIView *)view frame:(CGRect)frame;









@end
