//
//  JXEncapSulationObjc.m
//  JaneCargo
//
//  Created by cxy on 2017/6/27.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXEncapSulationObjc.h"

@implementation JXEncapSulationObjc

- (instancetype)initWithCodeNum:(NSInteger)num {
    
    if (self = [super init]) {
        _codeNum = num;
    }
    return self;
}

- (NSString *)description {
    
    return [NSString stringWithFormat:@"%ld",_codeNum];
}
- (NSComparisonResult)compareUsingcodeNum:(JXEncapSulationObjc *)cnum { // 倒序
    
    if (_codeNum < [cnum conum]) { //返回1
        return NSOrderedDescending;
    }else if(_codeNum == [cnum conum]){ //返回0
        return NSOrderedSame;
    }else{        //返回-1
        return NSOrderedAscending;
    }
}

- (NSComparisonResult)compareUsingcodeblood:(JXEncapSulationObjc *)blood { // 正序
    
    if (_codeNum > [blood conum]) { //返回1
        return NSOrderedDescending;
    }else if(_codeNum == [blood conum]){ //返回0
        return NSOrderedSame;
    }else{        //返回-1
        return NSOrderedAscending;
    }
}

- (NSInteger)conum {
    
    return _codeNum;
}




//#pragma mark -- 处理时间并排序
//+ (NSMutableArray *)processingTime:(NSMutableDictionary *)date {
//    
//    NSMutableArray *timeArray = @[].mutableCopy;
//    for (NSString *key in date) {
//        [timeArray addObject:key];
//    }
//    // 排序
//    [timeArray sortUsingFunction:dateSort context:NULL];
//    return timeArray;
//}
//
//NSInteger dateSort(id dict1, id dict2, void* context){
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];
//    NSDate *date1 = [formatter dateFromString:dict1];
//    NSDate *date2 = [formatter dateFromString:dict2];
//    return [date1 compare:date2];
//}


#pragma mark ---- 自适应宽度
+ (CGFloat)stringWidth:(NSString *)aString maxSize:(CGFloat)size fontSize:(CGFloat)fontSize {
    CGRect r = [aString boundingRectWithSize:CGSizeMake(size, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil];
    return r.size.width;
}
#pragma mark ---- 自适应高度
+ (CGFloat)hightForContent:(NSString *)content maxHeight:(CGFloat)heightSize fontSize:(CGFloat)fontSize {
    CGSize size = [content boundingRectWithSize:CGSizeMake(heightSize, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil].size;
    return size.height;
}

#pragma mark --- 导航颜色
+ (void)clearNavigation:(UIViewController*)contreller {
    
    [contreller.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [[[contreller.navigationController.navigationBar subviews]objectAtIndex:0] setAlpha:0];
}

+ (void)blackNavigation:(UIViewController*)contreller color:(UIColor *)color{
    [contreller.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [[[contreller.navigationController.navigationBar subviews]objectAtIndex:0] setAlpha:1];
    contreller.navigationController.navigationBar.barTintColor = color;
}
/**
 *  加载图片
 *
 *  @param url   NSURL
 *  @param click button
 */
+ (void)setURLImage:(NSURL *)url clickBt:(UIButton *)click{
    __block UIImage *images = nil;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *imageData = [NSData dataWithContentsOfURL:url];
        images = [UIImage imageWithData:imageData];
        dispatch_async(dispatch_get_main_queue(), ^{
            [click setImage:images forState:(UIControlStateNormal)];
        });
    });
}


// 对图片进行拉伸
+ (UIImage *)resizableImage:(NSString *) imageName {
    UIImage *image = [UIImage imageNamed:imageName];
    // 取图片中部的1 x 1进行拉伸
    UIEdgeInsets insets = UIEdgeInsetsMake(image.size.height/2, image.size.width/2, image.size.height/2 + 1, image.size.width/2 + 1);
    return [image resizableImageWithCapInsets:insets];
}

/**
 *  计算九宫行数便于计算cell的高度
 *
 *  @param arrayNum 数组的总数
 *  @param single   单行限制的个数
 *
 *  @return 返回行数
 */
+ (NSUInteger)s_calculateNumberArrayNum:(NSUInteger)arrayNum singleNumber:(NSUInteger)single{
    
    if (arrayNum % single < single && arrayNum % single != 0) {
        return  arrayNum/single +1;
    }else {
        return arrayNum/single;
    }
}

#pragma mark -- 改变label字体的大小
+ (void)changeWordSize:(UILabel *)label size:(CGFloat)size{
    
    NSMutableAttributedString *content = [[NSMutableAttributedString alloc]initWithString:label.text];
    [content addAttribute:NSFontAttributeName
     
                    value:[UIFont systemFontOfSize:size]
     
                    range:NSMakeRange(0, 1)];
    label.attributedText = content;
    
}

// 防止controller重复加载
+ (void)selectViewAbout:(UITableViewCell *)cell {
    for (UIView *contes in cell.contentView.subviews) {
        [contes removeFromSuperview];
    }
}


+ (void)addGradientColorView:(UIView *)view cgrectMake:(CGRect)frame colors:(NSArray *)colors{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
//    gradientLayer.colors = @[(id)[UIColor redColor].CGColor, (id)[UIColor blueColor].CGColor,(id)[UIColor greenColor].CGColor];
    gradientLayer.colors = colors;
    gradientLayer.locations = @[@0, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 0);
    gradientLayer.frame = frame;
    [view.layer addSublayer:gradientLayer];
}


/**
 *  AlerController(AlerSheet)
 *
 *  @param alerController UIViewController && UITableViewController
 *  @param action         点击事件
 *  @param chose          点击事件
 *  @param cancel         取消
 *  @param block          block (第一个点击事件处理)
 *  @param choseBlock     choseBlock (第二个点击事件处理)
 */
+ (void)setAlerController:(UIViewController *)alerController actionTilte:(NSString *)action choseAction:(NSString *)chose  cancel:(NSString *)cancel block:(void(^)(id responseCode))block choseBlock:(void(^)(id choesbk))choseBlock {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertController * alertController = [UIAlertController alertControllerWithTitle: nil                                                                             message: nil                                                                       preferredStyle:UIAlertControllerStyleActionSheet];
        [alertController addAction: [UIAlertAction actionWithTitle:action style: UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            block(action);
        }]];
        [alertController addAction: [UIAlertAction actionWithTitle:chose style: UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            choseBlock(action);
        }]];
        
        [alertController addAction: [UIAlertAction actionWithTitle:cancel style: UIAlertActionStyleCancel handler:nil]];
        
        [alerController presentViewController: alertController animated: YES completion: nil];
    });
}

/**
 *  AlerController
 *
 *  @param alerController UIViewController && UITableViewController
 *  @param alerTitle      标题
 *  @param contentTitle   内容
 *  @param cancel         取消
 *  @param confirm        确认
 *  @param block          block description (第一个点击事件处理)
 *  @param choseBlock     choseBlock description (第二个点击事件处理)
 */
+ (void)choseAlerController:(UIViewController *)alerController alerTitle:(NSString *)alerTitle contentTitle:(NSString *)contentTitle cancel:(NSString *)cancel confirm:(NSString *)confirm block:(void(^)(id responseCode))block choseBlock:(void(^)(id choesbk))choseBlock{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        UIAlertController *aler = [UIAlertController alertControllerWithTitle:alerTitle message:contentTitle preferredStyle:(UIAlertControllerStyleAlert)];
        [alerController presentViewController:aler animated:true completion:nil];
        UIAlertAction *action = [UIAlertAction actionWithTitle:cancel style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
            block(action);
        }];
        UIAlertAction *actions = [UIAlertAction actionWithTitle:confirm style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            choseBlock(action);
        }];
        [aler addAction:action];
        [aler addAction:actions];
    });
}


#pragma mark -- 倒计时
+ (void)setCountdownTimeStart:(void(^)(int time))start timeend:(void(^)())end{


    __block int timeout = 59;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                end();
                
            });
        }else{
            
            int seconds = timeout % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                start(seconds);
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}




+ (UIView *)setTrunAround:(UIView *)view frame:(CGRect)frame{ // CGRectMake(NPWidth/2-Image_Width/2, NPHeight/2-Image_Hight, Image_Width, Image_Hight)
    
    CGFloat Image_Width = 40;
    CGFloat Image_Hight = 40;
    UIView *backgroundImage = [[UIView alloc] initWithFrame:frame];
    [backgroundImage setBackgroundColor:[UIColor clearColor]];
//    [backgroundImage setAlpha:0.7];
//    [backgroundImage.layer setMasksToBounds:true];
//    [backgroundImage.layer setCornerRadius:5.0];
    [view addSubview:backgroundImage];
    [view bringSubviewToFront:backgroundImage];
    
    NSString  *name = @"timg.gif";
    NSString  *filePath = [[NSBundle bundleWithPath:[[NSBundle mainBundle] bundlePath]] pathForResource:name ofType:nil];
    NSData  *imageData = [NSData dataWithContentsOfFile:filePath];
    UIImageView *loadingImageView = [[UIImageView alloc]init];
    loadingImageView.backgroundColor = [UIColor clearColor];
    loadingImageView.image = [UIImage sd_animatedGIFWithData:imageData];
    loadingImageView.frame = CGRectMake(0, 0, Image_Width, Image_Hight);
    [backgroundImage addSubview:loadingImageView];

    return backgroundImage;
}



















@end
