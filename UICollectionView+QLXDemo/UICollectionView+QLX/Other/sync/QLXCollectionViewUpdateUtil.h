//
//  QLXCollectionViewUpdateUtil.h
//  UICollectionView+QLXDemo
//
//  Created by QLX on 2017/11/27.
//  Copyright © 2017年 QLX. All rights reserved.
//

#import <Foundation/Foundation.h>

@class QLXDataSource;

@interface QLXCollectionViewUpdateUtil : NSObject

+ (void)performUpdatesWithNewData:(QLXDataSource *)newData
                          oldData:(QLXDataSource *)oldData
                             view:(UICollectionView *)collectionView animated:(BOOL)animated;

@end
