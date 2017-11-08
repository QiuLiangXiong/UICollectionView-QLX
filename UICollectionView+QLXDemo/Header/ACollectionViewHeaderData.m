//
//  ACollectionViewHeaderData.m
//  UICollectionView+QLXDemo
//
//  Created by QLX on 16/9/8.
//  Copyright © 2016年 QLX. All rights reserved.
//

#import "ACollectionViewHeaderData.h"
#import "ACollectionViewHeader.h"
#import "UICollectionView+QLX.h"

@implementation ACollectionViewHeaderData

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.qlx_minimumLineSpacing = 20;
        self.qlx_secionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    }
    return self;
}


-(Class)qlx_reuseIdentifierClass{
    return [ACollectionViewHeader class];
}


@end
