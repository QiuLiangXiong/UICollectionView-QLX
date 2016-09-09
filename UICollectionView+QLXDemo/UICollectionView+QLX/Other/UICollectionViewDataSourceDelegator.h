//
//  UICollectionViewDataSourceDelegator.h
//  UICollectionView+QLXDemo
//
//  Created by QLX on 16/9/6.
//  Copyright © 2016年 QLX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"

@protocol QLXCollectionViewDataSource;



@interface UICollectionViewDataSourceDelegator : NSObject<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic , weak) UICollectionView * collectionView;
@property(nonatomic , weak) id<QLXCollectionViewDataSource> delegate;


@end
