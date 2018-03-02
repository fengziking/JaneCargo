//
//  ZYTagLabelsViewController.m
//  可以自动调整列数的CollectionView
//
//  Created by tarena on 16/7/3.
//  Copyright © 2016年 张永强. All rights reserved.
//

#import "ZYTagLabelsViewController.h"
#import "ZYTagLayout.h"
#import "NSString+ZYStringSize.h"

#import "LabelCollectionViewCell.h"
@interface ZYTagLabelsViewController ()<UICollectionViewDataSource , UICollectionViewDelegate , ZYTagLayoutDelegate>

/** 标签数组 */
@property (nonatomic , strong)NSArray *itemArr;
@end

@implementation ZYTagLabelsViewController
static NSString * XHLCellId = @"cellId";
- (NSArray *)itemArr
{
    if (!_itemArr) {
        _itemArr = @[@"乐天1",@"乐天2",@"乐天3",@"乐天4",@"乐天5",@"乐天6",@"乐天7",@"乐天8",@"乐天9", @"是你发来看你看你6",@"是你发来看你看你10",@"是你发来看你11", @"是你发来看你看你看你110"];
    }
    return _itemArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 创建布局
    ZYTagLayout *layout = [[ZYTagLayout alloc] init];
    layout.delegate = self;
    // 创建CollectionView
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    collectionView.dataSource = self;
    collectionView.delegate   = self;
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:collectionView];
    // 注册
    [collectionView registerClass:[LabelCollectionViewCell class] forCellWithReuseIdentifier:XHLCellId];
    
    
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.itemArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    LabelCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:XHLCellId forIndexPath:indexPath];
    cell.backgroundColor = [self randomColor];

    NSLog(@"%@",self.itemArr[indexPath.row]);
    
    cell.title = self.itemArr[indexPath.row];
    
    return cell;
    
}
- (UIColor *)randomColor {
    
    CGFloat red = arc4random_uniform(255);
    CGFloat green = arc4random_uniform(255);
    CGFloat blue = arc4random_uniform(255);
    UIColor *color = [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1.0];
    return color;
}
#pragma mark -- ZYTagLayoutDelegate
- (CGSize)tagLabel:(UICollectionViewLayout *)tagLabel indexPath:(NSIndexPath *)indexPath {
    NSString *content = [NSString stringWithFormat:@"%@杀神",self.itemArr[indexPath.row]];
    
    CGSize size = [content xhl_stringSizeWithFont:[UIFont systemFontOfSize:19] maxWidth:self.view.bounds.size.width];
    // 添加一定宽度的内容去增长cell的宽度(根据需求去添加)
    size.width = size.width;
    return size;
//    return [content xhl_stringSizeWithFont:[UIFont systemFontOfSize:19]];
}
- (UIEdgeInsets)edgeInsetsInWaterFlowLayout:(UICollectionViewLayout *)layout {
    return UIEdgeInsetsMake(20, 10, 10, 20);
}

@end
