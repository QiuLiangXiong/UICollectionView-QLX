//
//  UICollectionView+QLX.h
//
//
//  Created by QLX on 15/9/6.
//  Copyright © 2016年 QLX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QLXSectionData.h"
#import "NSObject+View.h"
#import "UIView+QLX.h"
#import "UIView+QLX_CellDelegate.h"
#import "NSMutableArray+QLX.h"


@protocol QLXCollectionViewDataSource;

@interface UICollectionView(QLX)

@property (nonatomic , weak) id<QLXCollectionViewDataSource> qlx_dataSource;

/**
 *  便利构造  产生一个默认系统流布局初始化的UICollectionView对象
 */
+ (instancetype) qlx_createForFlowLayout;


@end


@protocol QLXCollectionViewDataSource <NSObject>

@required

- (NSArray<QLXSectionData *> *)qlx_sectionDataListWithCollectionView:(UICollectionView *) collectionView;

@end
