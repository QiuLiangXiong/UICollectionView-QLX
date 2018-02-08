//
//  UIView+QLX.h
//  UICollectionView+QLXDemo
//
//  注意： 子类通过重写initWithFrame来初始化 重写init系统不会回调 切记
//  Created by QLX on 16/9/6.
//  Copyright © 2016年 QLX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView(QLX)

@property (nonatomic, strong) NSObject * qlx_data;             //数据源
@property (nonatomic, strong) NSIndexPath * qlx_indexPath;         // 视图所在位置
@property (nonatomic, weak)   UICollectionView * qlx_collectionView;// 所在的collectionView

/**
 *  数据和视图绑定的回调方法 需要重写
 *  重写需要调用父类改方法
 *  @param data      视图数据
 *  @param indexPath 视图所在位置
 */

- (void)qlx_reuseWithData:(NSObject *)data indexPath:(NSIndexPath *)indexPath NS_REQUIRES_SUPER;

/**
 *  如果重写了就不要调用[super qlx_viewSize];
 *  @return 返回view的size
 */

- (CGSize)qlx_viewSize;

- (CGFloat)qlx_viewWidth;

- (CGFloat)qlx_viewHeight;

/**
 本视图变化时调用该方法刷新
 note : don't call this method in @SEL(qlx_reuseWithData: indexPath:)
 */
- (void)qlx_updateViewWithAnimated:(BOOL)animated;

@end
