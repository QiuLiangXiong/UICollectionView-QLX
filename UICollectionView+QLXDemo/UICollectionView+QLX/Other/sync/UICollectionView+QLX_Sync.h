//
//  UICollectionView+QLX_Sync.h
//  UICollectionView+QLXDemo
//
//  Created by QLX on 2017/11/20.
//  Copyright © 2017年 QLX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICollectionView(QLX_Sync)

/**
 备份数据源
 */
- (void)qlx_copyDataSource;

/**
 数据同步到视图
 */
+ (void)qlx_syncToViewWithAnimated:(BOOL)animated  completed:(void (^)())completed;

@end
