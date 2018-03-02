//
//  loopImageView.m
//  代码布局
//
//  Created by iOS on 16/7/20.
//  Copyright © 2016年 iOS. All rights reserved.
//

#import "loopImageView.h"
#import "MyCollectionViewCell.h"
#import "enlargeImageCollectionView.h"
@interface loopImageView()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,synchronizationItemDelagate>
@property(nonatomic,strong)NSArray *DataArray;
@property(nonatomic,strong)UIImageView * rightImageview;
@property(nonatomic,strong)UIImageView * leftImageview;
@property(nonatomic,strong)UIImageView * rightImageviewSecound;
@property(nonatomic,strong)UIImageView * leftImageviewSecound;
@property (nonatomic,strong)UIView * RoundView;
@property(nonatomic,strong)UICollectionView * collectionView;
@end
static CGRect Frame;
@implementation loopImageView
static NSInteger currentCell = 0;

- (instancetype)initWithFrame:(CGRect)frame AnddataArray:(NSArray*)dataArray{
    if (self = [super initWithFrame:frame]) {
        Frame = frame;
        self.DataArray =dataArray;
        [self mainCollectionview];
        UIImageView * imageview = [[UIImageView alloc]initWithFrame:CGRectMake(NPWidth, 0, NPWidth, frame.size.height)];
        
        imageview.backgroundColor = [UIColor clearColor];
        self.rightImageview = imageview;
        UIImageView * imageviewS = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, NPWidth, frame.size.height)];
        self.rightImageviewSecound = imageviewS;
        
        imageviewS.backgroundColor = [UIColor clearColor];
        [self addSubview:imageviewS];
         [self addSubview:imageview];
        
        
        
        UIImageView * imageViewL = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, NPWidth, self.frame.size.height)];
        self.leftImageview = imageViewL;
         imageViewL.backgroundColor = [UIColor clearColor];
       
        
        UIImageView * imageViewLeftsecond = [[UIImageView alloc]initWithFrame:CGRectMake(- NPWidth/2.0, 0, NPWidth, self.frame.size.height)];
        self.leftImageviewSecound = imageViewLeftsecond;
        imageViewLeftsecond.backgroundColor = [UIColor clearColor];
        [self addSubview:imageViewLeftsecond];
         [self addSubview:imageViewL];
    
    }
    return self;
}

- (void)mainCollectionview{
    [self setBackgroundColor:[UIColor whiteColor]];
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 0;
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    
    UICollectionView * collectionview = [[UICollectionView alloc]initWithFrame:Frame collectionViewLayout:flowLayout];
    collectionview.showsVerticalScrollIndicator = NO;
    collectionview.showsHorizontalScrollIndicator = NO;
    [collectionview setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:collectionview];
    collectionview.dataSource =self;
    collectionview.delegate = self;
    collectionview.pagingEnabled = YES;
    self.collectionView = collectionview;
    [collectionview registerClass:[MyCollectionViewCell class] forCellWithReuseIdentifier:@"loop"];
}
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    currentCell = indexPath.item;
    if([collectionView.panGestureRecognizer translationInView:collectionView].x > 0 && indexPath.item < self.DataArray.count - 1){
        if (indexPath.item  >=0 ) {
#warning 有过崩溃 向右滑动
//             self.leftImageview.image = [UIImage imageNamed:self.DataArray[indexPath.item +1]];
//            self.leftImageviewSecound.image =[UIImage imageNamed:self.DataArray[indexPath.item ]];
            UIImage *cacheImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:[NSString stringWithFormat:@"%@%@",Image_Url,self.DataArray[indexPath.item +1]]];
            [self.leftImageview setImage:cacheImage];
            [self.leftImageview sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Image_Url,self.DataArray[indexPath.item +1]]] placeholderImage:[UIImage imageNamed:@"img_图片加载_小"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                
            }];
            UIImage *cacheImage1 = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:[NSString stringWithFormat:@"%@%@",Image_Url,self.DataArray[indexPath.item]]];
            [self.leftImageviewSecound setImage:cacheImage1];
            [self.leftImageviewSecound sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Image_Url,self.DataArray[indexPath.item ]]] placeholderImage:[UIImage imageNamed:@"img_图片加载_小"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                
            }];
            
            
        }
    }else{
#pragma mark  向左
        self.rightImageview.hidden = YES;

        if (indexPath.item < self.DataArray.count ) {
           
            
            if (indexPath.item  > 0) {
//                self.rightImageviewSecound.image = [UIImage imageNamed:self.DataArray[indexPath.item - 1]];
//                self.rightImageview.image = [UIImage imageNamed:self.DataArray[indexPath.item ]];
                UIImage *cacheImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:[NSString stringWithFormat:@"%@%@",Image_Url,self.DataArray[indexPath.item-1]]];
                [self.rightImageviewSecound setImage:cacheImage];
                [self.rightImageviewSecound sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Image_Url,self.DataArray[indexPath.item-1]]] placeholderImage:[UIImage imageNamed:@"img_图片加载_小"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                    
                }];
                UIImage *cacheImage1 = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:[NSString stringWithFormat:@"%@%@",Image_Url,self.DataArray[indexPath.item]]];
                [self.rightImageview setImage:cacheImage1];
                [self.rightImageview sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Image_Url,self.DataArray[indexPath.item ]]] placeholderImage:[UIImage imageNamed:@"img_图片加载_小"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                    
                }];
                
                
                
                
            }else{
//            self.rightImageviewSecound.image = [UIImage imageNamed:self.DataArray[indexPath.item ]];
//                self.rightImageview.image = [UIImage imageNamed:self.DataArray[indexPath.item+1 ]];
                UIImage *cacheImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:[NSString stringWithFormat:@"%@%@",Image_Url,self.DataArray[indexPath.item]]];
                [self.rightImageviewSecound setImage:cacheImage];
                [self.rightImageviewSecound sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Image_Url,self.DataArray[indexPath.item]]] placeholderImage:[UIImage imageNamed:@"img_图片加载_小"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                    
                }];
                if (self.DataArray.count>indexPath.item +1) {
                    UIImage *cacheImage1 = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:[NSString stringWithFormat:@"%@%@",Image_Url,self.DataArray[indexPath.item+1]]];
                    [self.rightImageview setImage:cacheImage1];
                    [self.rightImageview sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Image_Url,self.DataArray[indexPath.item +1]]] placeholderImage:[UIImage imageNamed:@"img_图片加载_小"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                        
                    }];
                }
                
            }
            
       
            
                   }
    }

}
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
   // self.rightImageview.hidden = NO;;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.DataArray.count;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return Frame.size;
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0 , 0, 0, 0);
}
- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MyCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"loop" forIndexPath:indexPath];
//     cell.imageview.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",self.DataArray[indexPath.item]]];
    UIImage *cacheImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:[NSString stringWithFormat:@"%@%@",Image_Url,self.DataArray[indexPath.item]]];
    [cell.imageview setImage:cacheImage];
    [cell.imageview sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Image_Url,self.DataArray[indexPath.item]]] placeholderImage:[UIImage imageNamed:@"img_图片加载_小"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    enlargeImageCollectionView * enlargeImage = [[enlargeImageCollectionView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    enlargeImage.dataArray = self.DataArray;
    enlargeImage.indepathItem = indexPath.item;
    enlargeImage.delegate = self;
    enlargeImage.alpha = 0;
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:enlargeImage];
    UIImageView * imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,NPWidth , self.frame.size.height)];
//    imageview.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",self.DataArray[indexPath.item]]];
    UIImage *cacheImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:[NSString stringWithFormat:@"%@%@",Image_Url,self.DataArray[indexPath.item]]];
    [imageview setImage:cacheImage];
    [imageview sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Image_Url,self.DataArray[indexPath.item]]] placeholderImage:[UIImage imageNamed:@"img_图片加载_小"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
    
    
    [self.superview addSubview:imageview];
    self.hidden = YES;
    [UIView animateWithDuration:0.1 animations:^{

        imageview.frame =CGRectMake(0, (NPHeight - self.frame.size.height)/2.0 - 64, NPWidth, self.frame.size.height);
      //   enlargeImage.alpha = 1.0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            enlargeImage.alpha = 1.0;
        }completion:^(BOOL finished) {
            imageview.alpha = 0;
            [imageview removeFromSuperview];
            self.hidden = NO;
        }];
        

        
    }];
}
- (void)synchronizationItem:(NSInteger)indexpathItem{
    
    self.collectionView.contentOffset = CGPointMake(NPWidth*indexpathItem+1, 0);
     [self.delegate loopImageContentoffset:indexpathItem];
    
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
      static NSInteger currentCellNum;
    if ([scrollView.panGestureRecognizer translationInView:scrollView].x >0 && scrollView.contentOffset.x >= 0) {//像右滑动
     //   NSLog(@"%f",scrollView.contentOffset.x);
        self.rightImageview.alpha = 0;
        self.rightImageviewSecound.alpha = 0;
        if (currentCell > 0) {
            currentCellNum = currentCell;
        }else{
            currentCellNum = currentCell;
        }
        self.leftImageviewSecound.alpha = 1;
        self.leftImageview.alpha = 1;
        CGRect frame = self.leftImageview.frame;
        CGRect frameLeftSecond = self.leftImageviewSecound.frame;

        CGFloat leftMoveX = (currentCellNum + 1)*NPWidth -scrollView.contentOffset.x;
        [self.delegate loopImageViewFooterTranster: - leftMoveX/NPWidth AndIndexPath:currentCell AndTotal:self.DataArray.count];
        if (leftMoveX  <= NPWidth ) {
            
            frame.origin.x = leftMoveX;
            self.leftImageview.frame = frame;

            
            frameLeftSecond.origin.x = leftMoveX /2.0 - NPWidth/2.0 ;
            self.leftImageviewSecound.frame = frameLeftSecond;
            
        }else {
            
            frame.origin.x = NPWidth ;
            self.leftImageview.frame = frame;
            frameLeftSecond.origin.x = 0;
            self.leftImageviewSecound.frame = frame;
    
            /************/
            self.leftImageview.alpha = 0;
            CGRect frame = self.leftImageview.frame;
            frame.origin.x = 0 ;
            self.leftImageview.frame = frame;
            // self.leftImageview.alpha = 1;
            
            
            self.leftImageviewSecound.alpha = 0;
            CGRect frames = self.leftImageviewSecound.frame;
            frames.origin.x = -NPWidth/2.0 ;
            self.leftImageviewSecound.frame = frames;
            //   self.leftImageviewSecound.alpha = 1;
        }
        
    }else if ([scrollView.panGestureRecognizer translationInView:scrollView].x < 0 && scrollView.contentOffset.x <= NPWidth*self.DataArray.count){
        //向左滑动
        self.leftImageviewSecound.alpha = 0;
        self.leftImageview.alpha = 0;
        self.rightImageview.hidden = NO;
        if (currentCell > 0) {
            currentCellNum = currentCell - 1;
        }else{
            currentCellNum = currentCell;
        }
      
        [self insertSubview:self.rightImageview atIndex:self.rightImageview.subviews.count+ 3 ];

        self.rightImageview.alpha = 1;
        self.rightImageviewSecound.alpha = 1;
        CGRect frame = self.rightImageview.frame;
        CGRect frameSecond = self.rightImageviewSecound.frame;
       // CGFloat rightMoveX =-(scrollView.contentOffset.x - (currentCellNum)*WIDTH) + WIDTH;
        CGFloat rightMoveX = (currentCellNum+1)*NPWidth -scrollView.contentOffset.x;
    
       [self.delegate loopImageViewFooterTranster: rightMoveX/NPWidth - 1 AndIndexPath:currentCell AndTotal:self.DataArray.count];
        if ( rightMoveX >= 0) {
            frame.origin.x = rightMoveX ;
            frameSecond.origin.x =(rightMoveX  - NPWidth)*0.5;
            self.rightImageview.frame = frame;
            self.rightImageviewSecound.frame = frameSecond;
           //
        }else if(scrollView.contentOffset.x < (self.DataArray.count - 1) * NPWidth){
            frame.origin.x = 0 ;
            self.rightImageview.frame = frame;
            /*************/
            self.rightImageview.alpha = 0;
            CGRect frame = self.rightImageview.frame;
            frame.origin.x = NPWidth ;
            self.rightImageview.frame = frame;
            //   self.rightImageview.alpha = 1;
            
            
            self.rightImageviewSecound.alpha = 0;
            CGRect framesec = self.rightImageviewSecound.frame;
            framesec.origin.x = 0 ;
            self.rightImageviewSecound.frame = frame;
            // self.rightImageviewSecound.alpha = 1;

        }
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if ([scrollView.panGestureRecognizer translationInView:scrollView].x >0) {
        self.leftImageview.alpha = 0;
        CGRect frame = self.leftImageview.frame;
        frame.origin.x = 0 ;
        self.leftImageview.frame = frame;
        
        self.leftImageviewSecound.alpha = 0;
        CGRect frames = self.leftImageviewSecound.frame;
        frames.origin.x = -NPWidth/2.0 ;
        self.leftImageviewSecound.frame = frames;
        
    }else{
    self.rightImageview.alpha = 0;
    CGRect frame = self.rightImageview.frame;
    frame.origin.x = NPWidth ;
    self.rightImageview.frame = frame;
      
        
        self.rightImageviewSecound.alpha = 0;
        CGRect framesec = self.rightImageviewSecound.frame;
        framesec.origin.x = 0 ;
        self.rightImageviewSecound.frame = frame;
    }
}


@end
