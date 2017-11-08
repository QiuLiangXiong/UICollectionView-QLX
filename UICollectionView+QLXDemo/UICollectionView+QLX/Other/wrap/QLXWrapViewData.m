//
//  QLXWrapViewData.m
//  UICollectionView+QLXDemo
//
//  Created by QLX on 2017/11/5.
//  Copyright © 2017年 QLX. All rights reserved.
//

#import "QLXWrapViewData.h"
#import "QLXWarpCollectionViewCell.h"
#import "QLXWarpCollectionReusableView.h"
#import "NSObject+View.h"
#import "UIView+QLX.h"
#import "UIView+QLX_CellDelegate.h"

@implementation QLXWrapViewData

- (Class)qlx_reuseIdentifierClass{
    if (self.wrapType == QLXWrapViewTypeCell) {
        return [QLXWarpCollectionViewCell class];
    }
    return [QLXWarpCollectionReusableView class];
}


- (CGFloat)qlx_viewWidth{
    if ([self.rootView qlx_viewWidth] > 0 && [self.rootView qlx_viewHeight] > 0) {
        return [self.rootView qlx_viewWidth];
    }
    
    CGSize size = self.rootView.frame.size;
    if (!CGSizeEqualToSize(CGSizeZero, size)) {
        return size.width;
    }else {
        CGFloat width = [self.rootView intrinsicContentSize].width;
        return fmax(width, 0);
    }
    return 0;
}

- (CGFloat)qlx_viewHeight{
    
    if ([self.rootView qlx_viewWidth] > 0 && [self.rootView qlx_viewHeight] > 0) {
        return [self.rootView qlx_viewHeight];
    }
    
    CGSize size = self.rootView.frame.size;
    if (!CGSizeEqualToSize(CGSizeZero, size)) {
        return size.height;
    }else {
        CGFloat height = [self.rootView intrinsicContentSize].height;
        return fmax(height, 0);
    }
    return 0;
}

- (void)setQlx_viewWidth:(CGFloat)qlx_viewWidth{
    self.rootView.qlx_viewWidth = qlx_viewWidth;
}

- (void)setQlx_viewHeight:(CGFloat)qlx_viewHeight{
    self.rootView.qlx_viewHeight = qlx_viewHeight;
}

- (UIEdgeInsets)qlx_secionInset{
    return self.rootView.qlx_secionInset;
}

- (CGFloat)qlx_minimumLineSpacing{
    return self.qlx_minimumLineSpacing;
}

- (CGFloat)qlx_minimumInteritemSpacing{
    return self.qlx_minimumInteritemSpacing;
}




@end
