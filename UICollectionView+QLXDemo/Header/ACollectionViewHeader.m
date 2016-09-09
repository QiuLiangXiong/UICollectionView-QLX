//
//  ACollectionViewHeader.m
//  UICollectionView+QLXDemo
//
//  Created by QLX on 16/9/8.
//  Copyright © 2016年 QLX. All rights reserved.
//

#import "ACollectionViewHeader.h"

@implementation ACollectionViewHeader

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor purpleColor];
    }
    return self;
}

-(void)qlx_reuseWithData:(NSObject *)data indexPath:(NSIndexPath *)indexPath{
    [super qlx_reuseWithData:data indexPath:indexPath];
    return;
}

-(CGSize)qlx_viewSize{
    return CGSizeMake(self.qlx_collectionView.frame.size.width, 20);
}


@end
