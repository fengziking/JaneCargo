//
//  ZYTagLayout.h
//  可以自动调整列数的CollectionView
//
//  Created by tarena on 16/7/3.
//  Copyright © 2016年 张永强. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol ZYTagLayoutDelegate <NSObject>
@required
- (CGSize)tagLabel:(UICollectionViewLayout *)tagLabel indexPath:(NSIndexPath *)indexPath;
@optional
/** 行间距 */
- (CGFloat)rowIntervalInWaterFlowLayout:(UICollectionViewLayout *)layout;
/** 列间距 */
- (CGFloat)columnIntervalInWaterFlowLayout:(UICollectionViewLayout *)layout;
/** collectionView内边距 */
- (UIEdgeInsets)edgeInsetsInWaterFlowLayout:(UICollectionViewLayout *)layout;

@end
@interface ZYTagLayout : UICollectionViewLayout
/** 代理属性 */
@property (nonatomic , weak)id<ZYTagLayoutDelegate> delegate;

@end
