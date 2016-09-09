//
//  ACollectionViewFooterData.m
//  UICollectionView+QLXDemo
//
//  Created by QLX on 16/9/8.
//  Copyright © 2016年 QLX. All rights reserved.
//

#import "ACollectionViewFooterData.h"
#import "ACollectionViewFooter.h"

@implementation ACollectionViewFooterData

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(Class)qlx_reuseIdentifierClass{
    return [ACollectionViewFooter class];
}

@end
