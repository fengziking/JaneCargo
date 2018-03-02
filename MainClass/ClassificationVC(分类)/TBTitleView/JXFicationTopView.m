//
//  JXFicationTopView.m
//  JaneCargo
//
//  Created by 鹏 on 2017/8/18.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXFicationTopView.h"


@interface JXFicationTopView ()<UIScrollViewDelegate> {

    // 当前选中的tag
    NSInteger currentIndex;
}


@property (weak, nonatomic) IBOutlet UIView *linef;
@property (weak, nonatomic) IBOutlet UIView *lines;
//@property (weak, nonatomic) IBOutlet UIView *y_color;

@property (nonatomic, strong) NSMutableArray *contentSizeFrame;
// 记录每个label的宽度
@property (nonatomic, strong) NSMutableArray *labelwidth;
@property (nonatomic, strong) NSMutableArray *tableArray;
@property (nonatomic, strong) UIScrollView *topScrollView;
@property (nonatomic, strong) UIView *y_color;

@end

@implementation JXFicationTopView

- (void)awakeFromNib {
    [super awakeFromNib];
    [_linef setBackgroundColor:kUIColorFromRGB(0xcccccc)];
    [_lines setBackgroundColor:kUIColorFromRGB(0xcccccc)];
}



- (void)setupTitle:(NSArray *)titleArray {
    
    
    self.topScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,0,NPWidth, self.frame.size.height)];
    self.topScrollView.showsHorizontalScrollIndicator = NO;
    self.topScrollView.bounces = true;
    self.topScrollView.delegate = self;
    [self addSubview:self.topScrollView];
    
    
    self.contentSizeFrame = @[].mutableCopy;
    self.labelwidth = @[].mutableCopy;
    self.tableArray = @[].mutableCopy;
    
    NSMutableArray *titlesarray = @[].mutableCopy;
    for (JXHomepagModel *model in titleArray) {
        [titlesarray addObject:model.name];
    }
    // 获取总长度
    CGFloat contentSizes = 0;
    // 获取总位移长度
    CGFloat contentScroller = 0;
    // 定义临时变量
    CGFloat labelW = 0;
    CGFloat labelY = 0;
    CGFloat labelH = self.frame.size.height;
    CGFloat labelX = 0;
    // 添加label
    for (NSInteger i = 0; i<titlesarray.count; i++) {
        
        labelW = [JXEncapSulationObjc stringWidth:titlesarray[i] maxSize:NPWidth fontSize:14.0f];
        // 获取所有内容的长度总和
        contentSizes += labelW;
        UILabel *label = [[UILabel alloc] init];
        label.text = titlesarray[i];
        if (i == 0)
        {
            labelX = 33*i+21;
            
        }
        else
        {
            labelX = (contentSizes-labelW)+33*i+21;
        }
        // 获取contentSize的总长度
        contentScroller = labelX;
        // 记录每次位移的坐标。宽度
        [self.contentSizeFrame addObject:[NSString stringWithFormat:@"%f",labelX]];
        [self.labelwidth addObject:[NSString stringWithFormat:@"%f",labelW]];
        
        label.frame = CGRectMake(labelX, labelY, labelW, labelH);
        label.textAlignment = NSTextAlignmentCenter;
        [label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClick:)]];
        label.userInteractionEnabled = YES;
        label.tag = i;
        if (i == 0) {
            [label setTextColor:kUIColorFromRGB(0xef5b4c)];
        }else {
            [label setTextColor:kUIColorFromRGB(0x666666)];
        }
        [JXContTextObjc p_SetfondboldLabel:label fondSize:14.0f];
        
        [self.tableArray addObject:label];
        [self.topScrollView addSubview:label];
    }
    
    // 设置contentSize
    self.topScrollView.contentSize = CGSizeMake(contentScroller+[JXEncapSulationObjc stringWidth:titlesarray[titlesarray.count-1] maxSize:NPWidth fontSize:14.0f]+20, 0);
    // 第一个
    CGFloat firstTitleW = [self.labelwidth[0] integerValue];
    self.y_color.width = firstTitleW;
    self.y_color = [[UIView alloc] initWithFrame:CGRectMake(21,self.frame.size.height-0.7,firstTitleW, 1.5)];
    [self.y_color setBackgroundColor:kUIColorFromRGB(0xef5b4c)];
    [self addSubview:self.y_color];
    
}


/**
 * 监听顶部label点击
 */
- (void)labelClick:(UITapGestureRecognizer *)tap {
    
    currentIndex = tap.view.tag;
    // 取出被点击label的索引
    NSInteger index = tap.view.tag;
    
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@",self.contentSizeFrame[index]] forKey:@"Labelsp"];
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@",self.labelwidth[index]] forKey:@"LabelWidth"];
    
    // 让对应的顶部标题居中显示
    UILabel *label = self.topScrollView.subviews[index];
    // 改变对应的颜色
    for (UILabel *label in self.tableArray) {
        if (label.tag == index) {
            [label setTextColor:kUIColorFromRGB(0xef5b4c)];
        }else {
            [label setTextColor:kUIColorFromRGB(0x666666)];
        }
    }
    CGPoint titleOffset = self.topScrollView.contentOffset;
    
    CGFloat width = self.topScrollView.frame.size.width;
    titleOffset.x = label.center.x - width * 0.5;
    // 左边超出处理
    if (titleOffset.x < 0) titleOffset.x = 0;
    // 右边超出处理
    CGFloat maxTitleOffsetX = self.topScrollView.contentSize.width - width;
    if (titleOffset.x > maxTitleOffsetX) titleOffset.x = maxTitleOffsetX;
    [self.topScrollView setContentOffset:titleOffset animated:YES];
    [UIView animateWithDuration:0.4 animations:^{
        self.y_color.frame = CGRectMake([self.contentSizeFrame[index] integerValue]-titleOffset.x, 40-1.5, [self.labelwidth[index] integerValue], 2);
    }];
    _TopTitleblock(index);
}



- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    CGFloat offsetX = scrollView.contentOffset.x;
    for (UILabel *label in self.tableArray)
    {
        if (label.tag == currentIndex)
        {
            CGRect titleframe = self.y_color.frame;
            titleframe.origin.x = label.frame.origin.x-offsetX;
            // 当前位置需要显示的控制器的索引
            [UIView animateWithDuration:0.4 animations:^{
                self.y_color.frame = titleframe;
            }];
            
        }
    }
}

- (void)setColorviewwidht {
    NSString *lefts = [[NSUserDefaults standardUserDefaults] objectForKey:@"Labelsp"];
    NSString *width = [[NSUserDefaults standardUserDefaults] objectForKey:@"LabelWidth"];
    self.y_color.frame = CGRectMake(lefts.floatValue, 40-1.5, width.floatValue, 2);
}



@end
