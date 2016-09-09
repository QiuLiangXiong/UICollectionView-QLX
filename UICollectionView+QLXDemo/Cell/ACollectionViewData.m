//
//  ACollectionViewData.m
//  UICollectionView+QLXDemo
//
//  Created by QLX on 16/9/8.
//  Copyright © 2016年 QLX. All rights reserved.
//

#import "ACollectionViewData.h"
#import "ACollectionViewCell.h"

@implementation ACollectionViewData

-(Class)qlx_reuseIdentifierClass{
    return [ACollectionViewCell class];
}


@end
