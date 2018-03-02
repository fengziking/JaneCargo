//
//  JXFicationLeftView.m
//  JaneCargo
//
//  Created by 鹏 on 2017/8/18.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXFicationLeftView.h"

@interface JXFicationLeftView () <UIScrollViewDelegate> {
    
    // 获取总个数
    NSInteger indexTagMAll;
    // 获取cell在屏幕上显示的长度
    CGFloat screenHeight;
    // 获取中间位置的index
    NSInteger indexTagMid;
}

@property (nonatomic, strong) UIScrollView *menuScrollView;
@property (nonatomic, strong) NSMutableArray *labelArray;
@property (nonatomic, strong) NSMutableArray *lineArray;


@end

@implementation JXFicationLeftView

static const CGFloat CellHeight = 50;

#pragma mark -- 添加侧边分类内容
- (void)setupTitle:(NSArray *)titleArrays selectIndex:(NSInteger)selectIndex{
    
    
    self.menuScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,0,100, self.frame.size.height)];
    self.menuScrollView.bounces = true;
    self.menuScrollView.delegate = self;
    self.menuScrollView.showsVerticalScrollIndicator = NO;
    [self addSubview:self.menuScrollView];
    
    self.lineArray = @[].mutableCopy;
    self.labelArray= @[].mutableCopy;
    // 定义临时变量
    CGFloat labelW = 100;
    CGFloat labelX = 0;
    CGFloat labelH = 50;
    
    NSMutableArray *titlesarray = @[].mutableCopy;
    for (JXHomepagModel *model in titleArrays) {
        [titlesarray addObject:model.name];
    }
    
    // 添加label
    for (NSInteger i = 0; i<titlesarray.count; i++) {
        UILabel *label = [[UILabel alloc] init];
        label.text = titlesarray[i];
        CGFloat labelY = i * labelH;
        label.frame = CGRectMake(labelX, labelY, labelW, labelH);
        label.textAlignment = NSTextAlignmentCenter;
        [label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClick:)]];
        label.userInteractionEnabled = YES;
        label.tag = i;
        
        [label setTextColor:kUIColorFromRGB(0x333333)];
        [JXContTextObjc p_SetfondLabel:label fondSize:14.0f];
        [self.menuScrollView addSubview:label];
        [self.labelArray addObject:label];
        
        
        UIView *redView = [[UIView alloc] initWithFrame:CGRectMake(0, labelY, 2, labelH)];
        if (i == selectIndex)
        {
            [label setBackgroundColor:kUIColorFromRGB(0xf2f2f2)];
            [redView setBackgroundColor:kUIColorFromRGB(0xef5b4c)];
        }else
        {
            [label setBackgroundColor:kUIColorFromRGB(0xffffff)];
            [redView setBackgroundColor:[UIColor clearColor]];
        }
        redView.tag = i;
        [self.lineArray addObject:redView];
        [self.menuScrollView addSubview:redView];
    }
    // 设置contentSize
    self.menuScrollView.contentSize = CGSizeMake(0, titlesarray.count * labelH);
}

/**
 * 监听左侧
 */
- (void)labelClick:(UITapGestureRecognizer *)tap {
    // 取出被点击label的索引
    NSInteger index = tap.view.tag;
    _LeftTitleblock(index);
    // 改变对应label的颜色
    for (UILabel *label in self.labelArray) {
        if (label.tag == index) {
            [label setBackgroundColor:kUIColorFromRGB(0xf2f2f2)];
            [label setTextColor:kUIColorFromRGB(0xef5b4c)];
        }else {
            [label setTextColor:kUIColorFromRGB(0x666666)];
            [label setBackgroundColor:kUIColorFromRGB(0xffffff)];
        }
      }
    // 改变边界红线的颜色
    for (UIView *redline in self.lineArray) {
        if (redline.tag == index) {
            [redline setBackgroundColor:kUIColorFromRGB(0xef5b4c)];
        }else {
            [redline setBackgroundColor:[UIColor clearColor]];
        }
    }
    // 滑动
    // 获取总个数
    indexTagMAll = self.labelArray.count;
    // 获取cell在屏幕上显示的长度
    screenHeight = self.frame.size.height;
    // 获取中间位置的index
    indexTagMid = screenHeight/CellHeight/2;
    // 获取屏幕显示的个数
    NSInteger indexNumber = screenHeight/CellHeight;
    
    if (indexNumber>=indexTagMAll)
    {
        // 不做任何操作
    }
    else
    {
        if (index>indexTagMid)
        { //  点击的物品超过一半 继续判断是否位移
            // 获取移动的位数
            NSInteger conset =  index - indexTagMid;
            if (conset>=0)
            {
                // 获取总高度
                CGFloat accordingTotalHeight = indexTagMAll*CellHeight;
                // 减去位移的高度
                CGFloat displacementHeight  = accordingTotalHeight -  index*CellHeight;
                // 还有一种情况>0即超出的部分小于显示的一半折全部位移上来
                if (displacementHeight > 0)
                { // screenHeight
                    if (displacementHeight-screenHeight/2>0)
                    {// 超出处理 上移对应位置
                        [self.menuScrollView setContentOffset:CGPointMake(0, conset*CellHeight) animated:YES];
                    }
                    else
                    {// 超出但是小于底部位置以中心点为基准
                        [self.menuScrollView setContentOffset:CGPointMake(0, (self.labelArray.count-indexTagMid*2)*CellHeight) animated:YES];
                    }
                }
            }
        }
        else
        { // 返回时 小于中心点位置 还原
            [self.menuScrollView setContentOffset:CGPointMake(0,0) animated:YES];
        }
        
    }
    
}









@end
