//
//  JXHomePageLayOut.m
//  JaneCargo
//
//  Created by cxy on 2017/6/28.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXHomePageLayOut.h"

@implementation JXHomePageLayOut

-(id)init
{
    self = [super init];
    if (self) {
        
        self.itemSize = CGSizeMake(NPWidth/2 , BranchOrder_Collection_Height);
        self.scrollDirection = UICollectionViewScrollDirectionVertical; // 设置滚动方向  UICollectionViewScrollDirectionVertical UICollectionViewScrollDirectionHorizontal
        self.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0); // top left bottom right
        self.minimumLineSpacing = 0; // 上下间距
        self.minimumInteritemSpacing = 0;  // 左右间距
        
        
    }
    return self;
}

@end
