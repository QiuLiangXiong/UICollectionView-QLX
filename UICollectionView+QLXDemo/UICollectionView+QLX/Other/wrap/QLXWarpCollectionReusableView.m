//
//  QLXWarpCollectionReusableView.m
//  UICollectionView+QLXDemo
//
//  Created by QLX on 2017/11/5.
//  Copyright © 2017年 QLX. All rights reserved.
//

#import "QLXWarpCollectionReusableView.h"
#import "QLXWrapViewData.h"
#import "QMacros.h"

@implementation QLXWarpCollectionReusableView

#pragma mark - overriding



-(void)qlx_reuseWithData:(NSObject *)data indexPath:(NSIndexPath *)indexPath{
    [super qlx_reuseWithData:data indexPath:indexPath];
    QLXAssert([data isKindOfClass:[QLXWrapViewData class]], @"data must be QLXWrapViewData ");
    QLXWrapViewData * wrapData = (QLXWrapViewData *)data;
    
    UIView * rootView = [self getRootView];
    if (rootView != wrapData.rootView) {
        [rootView removeFromSuperview];
        [wrapData.rootView removeFromSuperview];
        rootView = wrapData.rootView;
        for (NSLayoutConstraint * c in [self.contentView constraints]) {
            [self.contentView removeConstraint:c];
        }
        [self.contentView addSubview:rootView];
        rootView.frame = CGRectMake(0, 0, wrapData.qlx_viewWidth, wrapData.qlx_viewHeight);
    }
    rootView.qlx_collectionView = self.qlx_collectionView;
    [rootView qlx_reuseWithData:[rootView qlx_data] indexPath:indexPath];
    rootView.hidden = false;
}

- (CGSize)qlx_viewSize{
    UIView * rootView = [self getRootView];
    return [rootView qlx_viewSize];
}



- (void)prepareForReuse{
    [super prepareForReuse];
    UIView * rootView = [self getRootView];
    rootView.hidden = true;
}





#pragma mark - private

- (UIView *)getRootView{
    return (UIView *)self.contentView.subviews.firstObject;
}

- (UIView *)contentView{
    return self;
}

@end
