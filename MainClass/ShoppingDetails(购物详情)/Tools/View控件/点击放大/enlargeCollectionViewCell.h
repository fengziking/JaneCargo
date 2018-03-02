//
//  enlargeCollectionViewCell.h
//  代码布局
//
//  Created by iOS on 16/7/25.
//  Copyright © 2016年 iOS. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol concellEnlargeImageDalegate
- (void)removeEnlargeImageView;
@end
@interface enlargeCollectionViewCell : UICollectionViewCell
@property(nonatomic,weak)id <concellEnlargeImageDalegate> delegate;
@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)UIImage * image;

- (instancetype)initWithFrame:(CGRect)frame;
@end
