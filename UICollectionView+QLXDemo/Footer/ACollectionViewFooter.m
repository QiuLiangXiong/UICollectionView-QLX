//
//  ACollectionViewFooter.m
//  UICollectionView+QLXDemo
//
//  Created by QLX on 16/9/8.
//  Copyright © 2016年 QLX. All rights reserved.
//

#import "ACollectionViewFooter.h"
#import "UICollectionView+QLX.h"

@implementation ACollectionViewFooter


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor purpleColor];
    }
    return self;
}

-(CGSize)qlx_viewSize{
    return CGSizeMake(self.qlx_collectionView.frame.size.width, 20);
}

@end
