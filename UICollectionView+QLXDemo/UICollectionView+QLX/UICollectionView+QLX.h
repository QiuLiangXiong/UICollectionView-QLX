//
//  UICollectionView+QLX.h
//
//
//  Created by QLX on 15/9/6.
//  Copyright © 2016年 QLX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSObject+View.h"
#import "UIView+QLX.h"
#import "UICollectionViewCell+QLX.h"

@protocol QLXCollectionViewDataSource;

@interface UICollectionView(QLX)

@property (nonatomic , weak) id<QLXCollectionViewDataSource> qlx_dataSource;

/**
 *  便利构造  产生一个默认系统流布局初始化的UICollectionView对象
 */
+ (instancetype) createForFlowLayout;


@end


@protocol QLXCollectionViewDataSource <NSObject>

@required

- (NSArray *)qlx_cellDataListWithCollectionView:(UICollectionView *) collectionView;

@optional

- (NSArray *)qlx_headerDataListWithCollectionView:(UICollectionView *) collectionView;

- (NSArray *)qlx_footerDataListWithCollectionView:(UICollectionView *) collectionView;

- (NSArray<Class> *)qlx_decorationViewClassListWithCollectionView:(UICollectionView *)collectionView;

@end
