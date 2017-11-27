//
//  QLXDataSource.h
//  UICollectionView+QLXDemo
//
//  Created by QLX on 2017/11/27.
//  Copyright © 2017年 QLX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QLXDiffUtil.h"
@class QLXSectionData;
@interface QLXDataSource : NSObject

@property(nonatomic , strong) NSArray<QLXSectionData *> * sectionDataList;

+ (instancetype)createWithCollectionView:(UICollectionView *)collectionView;

@end
