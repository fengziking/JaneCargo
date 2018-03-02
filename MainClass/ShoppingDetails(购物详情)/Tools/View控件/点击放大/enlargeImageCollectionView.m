//
//  enlargeImageCollectionView.m
//  代码布局
//
//  Created by iOS on 16/7/25.
//  Copyright © 2016年 iOS. All rights reserved.
//

#import "enlargeImageCollectionView.h"
#import "enlargeCollectionViewCell.h"
@interface enlargeImageCollectionView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,concellEnlargeImageDalegate>
@property(nonatomic,strong)UICollectionView * collectionView;
@property(nonatomic,strong)UILabel * pageLabel;

@end
@implementation enlargeImageCollectionView
static NSInteger CurrentItem ;




- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self collectionViewWithFrame:frame];
    }
    return self;
}
- (void)collectionViewWithFrame:(CGRect)frame{
    
    
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 0;
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    UICollectionView * collectionview = [[UICollectionView alloc]initWithFrame:frame collectionViewLayout:flowLayout];
    [self addSubview:collectionview];
    [collectionview setBackgroundColor:[UIColor whiteColor]];
    collectionview.dataSource =self;
    collectionview.delegate = self;
    collectionview.pagingEnabled = YES;
    collectionview.contentOffset = CGPointMake(self.indepathItem * NPWidth, 0);
    self.collectionView = collectionview;
    [collectionview registerClass:[enlargeCollectionViewCell class] forCellWithReuseIdentifier:@"enlarge"];
    self.pageLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 64, NPWidth, 30)];

    self.pageLabel.textAlignment = 1;
    [self addSubview:self.pageLabel];

}



- (void)setIndepathItem:(NSInteger)indepathItem{
    _indepathItem =indepathItem;
    self.pageLabel.text = [NSString stringWithFormat:@"%ld/%ld",_indepathItem+1,self.dataArray.count];
    self.collectionView.contentOffset = CGPointMake(self.indepathItem * NPWidth, 0);
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
  return  self.dataArray.count;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
//    CurrentItem = indexPath.item;
    enlargeCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"enlarge" forIndexPath:indexPath];
    cell.delegate =self;
//    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",self.dataArray[indexPath.item]]];
    UIImage *cacheImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:[NSString stringWithFormat:@"%@%@",Image_Url,self.dataArray[indexPath.item]]];
    [cell.imageView setImage:cacheImage];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Image_Url,self.dataArray[indexPath.item]]] placeholderImage:[UIImage imageNamed:@"img_图片加载_小"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        cell.image = image;
    }];
    
//    cell.image =[UIImage imageNamed:[NSString stringWithFormat:@"%@",self.dataArray[indexPath.item]]];
   
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return self.frame.size;
}
- (void)removeEnlargeImageView{
    [UIView animateWithDuration:2 animations:^{
        [self removeFromSuperview];
   
    }];
    [self.delegate synchronizationItem:CurrentItem];
}
//- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
//    NSLog(@" current = %ld",indexPath.item);
//    NSString * string = [NSString stringWithFormat:@"%ld/%ld",indexPath.item,self.dataArray.count];
//    NSMutableAttributedString * atributed = [[NSMutableAttributedString alloc]initWithString:string];
//    NSRange  rang = [string rangeOfString:[NSString stringWithFormat:@"%ld",indexPath.item]];
//    NSRange rang2 = [string rangeOfString:[NSString stringWithFormat:@"/%ld",self.dataArray.count]];
//    [atributed addAttribute:NSFontAttributeName
//     
//                      value:[UIFont systemFontOfSize:22.0]
//     
//                      range:rang];
//    
//    [atributed addAttribute:NSFontAttributeName
//     
//                      value:[UIFont systemFontOfSize:16.0]
//     
//                      range:rang2];
//    self.pageLabel.attributedText = atributed;
//}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    
    CGFloat offsetY = scrollView.contentOffset.x;
    NSInteger index = offsetY/NPWidth;
    CurrentItem = index;
    self.pageLabel.text = [NSString stringWithFormat:@"%ld/%ld",index+1,self.dataArray.count];
    
}


@end
