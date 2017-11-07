//
//  QLXWarpCollectionViewCell.m
//  UICollectionView+QLXDemo
//
//  Created by QLX on 2017/11/5.
//  Copyright © 2017年 QLX. All rights reserved.
//

#import "QLXWarpCollectionViewCell.h"
#import "UIView+QLX.h"
#import "QMacros.h"
#import "QLXWrapViewData.h"

@implementation QLXWarpCollectionViewCell

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

    if ([rootView isKindOfClass:[UICollectionViewCell class]]) {
        UICollectionViewCell * cell = (UICollectionViewCell *)rootView;
        [cell prepareForReuse];
    }
}


- (void)qlx_didSelectCell{
    [super qlx_didSelectCell];
    UIView * rootView = [self getRootView];
    if ([rootView isKindOfClass:[UICollectionViewCell class]]) {
        UICollectionViewCell * cell = (UICollectionViewCell *)rootView;
        [cell qlx_didSelectCell];
    }
}

- (void)qlx_didDeselectCell{
    [super qlx_didDeselectCell];
    UIView * rootView = [self getRootView];
    if ([rootView isKindOfClass:[UICollectionViewCell class]]) {
        UICollectionViewCell * cell = (UICollectionViewCell *)rootView;
        [cell qlx_didDeselectCell];
    }
}

- (void)qlx_willDisplayCell{
    [super qlx_willDisplayCell];
    UIView * rootView = [self getRootView];
    if ([rootView isKindOfClass:[UICollectionViewCell class]]) {
        UICollectionViewCell * cell = (UICollectionViewCell *)rootView;
        [cell qlx_willDisplayCell];
    }
}

- (BOOL)qlx_shouldSelectCell{

    UIView * rootView = [self getRootView];
    if ([rootView isKindOfClass:[UICollectionViewCell class]]) {
        UICollectionViewCell * cell = (UICollectionViewCell *)rootView;
        return [cell qlx_shouldSelectCell];
    }
    return [super qlx_shouldSelectCell];;
}

- (BOOL)qlx_shouldDeselectCell{
    UIView * rootView = [self getRootView];
    if ([rootView isKindOfClass:[UICollectionViewCell class]]) {
        UICollectionViewCell * cell = (UICollectionViewCell *)rootView;
        return [cell qlx_shouldDeselectCell];
    }
    return [super qlx_shouldDeselectCell];
}

- (BOOL)qlx_shouldHighlightCell{
    UIView * rootView = [self getRootView];
    if ([rootView isKindOfClass:[UICollectionViewCell class]]) {
        UICollectionViewCell * cell = (UICollectionViewCell *)rootView;
        return [cell qlx_shouldHighlightCell];
    }
    return [super qlx_shouldHighlightCell];
}

- (void)qlx_didHighlightCell{
    [super qlx_didHighlightCell];
    UIView * rootView = [self getRootView];
    if ([rootView isKindOfClass:[UICollectionViewCell class]]) {
        UICollectionViewCell * cell = (UICollectionViewCell *)rootView;
        [cell qlx_didHighlightCell];
    }
}

- (void)qlx_didUnhighlightCell{
    [super qlx_didUnhighlightCell];
    UIView * rootView = [self getRootView];
    if ([rootView isKindOfClass:[UICollectionViewCell class]]) {
        UICollectionViewCell * cell = (UICollectionViewCell *)rootView;
        [cell qlx_didUnhighlightCell];
    }
}

#pragma mark - private

- (UIView *)getRootView{
    return (UIView *)self.contentView.subviews.firstObject;
}

@end
