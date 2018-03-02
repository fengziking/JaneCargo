//
//  ZYTagLayout.m
//  可以自动调整列数的CollectionView
//
//  Created by tarena on 16/7/3.
//  Copyright © 2016年 张永强. All rights reserved.
//

#import "ZYTagLayout.h"



/** 每一列之间的间距 */
static const CGFloat kZYDefaultColumnInterval = 10;
/** 每一行之间的间距 */
static const CGFloat kZYDefaultRowInterval  = 10;
/** 边缘间距 */
static const UIEdgeInsets kZYDsfultEdgeInsets = { 10 ,10 , 10 , 20};




@interface ZYTagLayout ()
/** 存放所有cell的布局属性 */
@property (nonatomic , strong)NSMutableArray *attrsArray;
/** 存放所有列的当前高度 */
@property (nonatomic , strong)NSMutableArray *columnHeights;
/** 高度内容 */
@property (nonatomic , assign)CGFloat contentHeight;
/** 当前内容的x值 */
@property (nonatomic , assign)CGFloat itemMaxX;
/** item的y值 */
@property (nonatomic, assign) CGFloat itemMaxY;

@end

@implementation ZYTagLayout
#pragma mark -- 代理处理属性
/** 行间隔 */
- (CGFloat)rowInterval  {
    if ([self.delegate respondsToSelector:@selector(rowIntervalInWaterFlowLayout:)]) {
        return [self.delegate rowIntervalInWaterFlowLayout:self];
    }else {
        return kZYDefaultRowInterval;
    }
}
/** 列间隔 */
- (CGFloat)columnInterval {
    if ([self.delegate respondsToSelector:@selector(columnIntervalInWaterFlowLayout:)]) {
        return [self.delegate columnIntervalInWaterFlowLayout:self];
    }else {
        return kZYDefaultColumnInterval;
    }
}
/** 边缘间隔 */
- (UIEdgeInsets)edgeInsets{
    if ([self.delegate respondsToSelector:@selector(edgeInsetsInWaterFlowLayout:)]) {
        return [self.delegate edgeInsetsInWaterFlowLayout:self];
    }else {
        return kZYDsfultEdgeInsets;
    }
}
- (NSMutableArray *)columnHeights {
    if (nil == _columnHeights) {
        _columnHeights = [NSMutableArray array];
    }
    return _columnHeights;
}
- (NSMutableArray *)attrsArray {
    if (nil == _attrsArray) {
        _attrsArray = [NSMutableArray array];
    }
    return _attrsArray;
}
/** 初始化 */
- (void)prepareLayout {
    [super prepareLayout];
    self.itemMaxX = 10;
    self.itemMaxY = 10;
    //清除之前的所有布局属性
    [self.attrsArray removeAllObjects];
    //开始创建每一个cell对应的布局属性
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for (NSInteger i = 0; i < count; i ++) {
        //创建位置
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.attrsArray addObject:attrs];
    }
}
//决定cell的布局
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    return self.attrsArray;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    // 创建布局属性
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
     // collectionView的宽度
    CGFloat collextionViewWidth = self.collectionView.frame.size.width;
    //通过代理拿到item的宽高
    CGSize itemSize = [self.delegate tagLabel:self indexPath:indexPath];
    //itemsize 宽度大于剩余宽度
    if (collextionViewWidth - self.itemMaxX - [self edgeInsets].right < itemSize.width) {
        self.itemMaxX = [self columnInterval];
        self.itemMaxY += itemSize.height + [self columnInterval];
    }else {
        if (self.itemMaxX != 10) {
            self.itemMaxX += [self rowInterval];
        }
        if (self.itemMaxY == 10) {
            self.itemMaxY += [self edgeInsets].top - 10;
        }
    }
    attrs.frame = CGRectMake(self.itemMaxX, self.itemMaxY, itemSize.width, itemSize.height);
    //设置最大宽度

    self.itemMaxX = CGRectGetMaxX(attrs.frame);
    self.contentHeight = self.itemMaxY + itemSize.height;
//    self.contentHeight = CGRectGetMaxY(attrs.frame);
    NSLog(@"itemSize.height %f" , itemSize.height);
    NSLog(@"itemMaxY %f" , self.itemMaxY);
    NSLog(@" contentHeight %f" , self.contentHeight);
    return attrs;
}
- (CGSize)collectionViewContentSize {
    return CGSizeMake(0, self.contentHeight + [self edgeInsets].bottom);
}

@end



















