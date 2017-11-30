//
//  QLXWarpCollectionViewCell.m
//  UICollectionView+QLXDemo
//
//  Created by QLX on 2017/11/5.
//  Copyright © 2017年 QLX. All rights reserved.
//

#import "QLXWarpCollectionViewCell.h"
#import "QMacros.h"
#import "NSObject+QLXView.h"
#import "UIView+QLX.h"
#import "UIView+QLXCellDelegate.h"
#import "QLXWrapViewData.h"


@implementation QLXWarpCollectionViewCell

#pragma mark - overriding



- (void)qlx_reuseWithData:(NSObject *)data indexPath:(NSIndexPath *)indexPath{
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
        rootView.translatesAutoresizingMaskIntoConstraints = true;
    }
    rootView.qlx_collectionView = self.qlx_collectionView;
    [rootView qlx_reuseWithData:[rootView qlx_data] indexPath:indexPath];
}

- (CGSize)qlx_viewSize{
    UIView * rootView = [self getRootView];
    return [rootView qlx_viewSize];
}


/*
 *  重定向触摸所在视图，解决嵌套cell带来的UICollectionView点击cell未响应问题
 */
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView * view = [super hitTest:point withEvent:event];
    UIView * rootView = [self getRootView];
    if ([rootView isKindOfClass:[UICollectionViewCell class]]) {
        UICollectionViewCell * cell = (UICollectionViewCell *)rootView;
        if (view == cell || view == cell.contentView) {
            if (rootView.gestureRecognizers.count == 0 && cell.contentView.gestureRecognizers.count <= 1) {
               return self;
            }
        }
    }
    return view;
}



- (void)prepareForReuse{
    [super prepareForReuse];
    UIView * rootView = [self getRootView];
    if ([rootView isKindOfClass:[UICollectionReusableView class]]) {
        UICollectionReusableView * cell = (UICollectionReusableView *)rootView;
        [cell prepareForReuse];
    }else {
        [rootView qlx_prepareForReuse];
    }
}


- (void)qlx_didSelectCell{
    [super qlx_didSelectCell];
    UIView * rootView = [self getRootView];
    [rootView qlx_didSelectCell];
}

- (void)qlx_didDeselectCell{
    [super qlx_didDeselectCell];
    UIView * rootView = [self getRootView];
    [rootView qlx_didDeselectCell];
}

- (void)qlx_willDisplayCell{
    [super qlx_willDisplayCell];
    UIView * rootView = [self getRootView];
    [rootView qlx_willDisplayCell];
}

- (void)qlx_didEndDisplayingCell{
    [super qlx_didEndDisplayingCell];
    UIView * rootView = [self getRootView];
    [rootView qlx_didEndDisplayingCell];
}

- (BOOL)qlx_shouldSelectCell{

    UIView * rootView = [self getRootView];
    return [rootView qlx_shouldSelectCell];
}

- (BOOL)qlx_shouldDeselectCell{
    UIView * rootView = [self getRootView];
    return [rootView qlx_shouldDeselectCell];
}

- (BOOL)qlx_shouldHighlightCell{
    UIView * rootView = [self getRootView];
    return [rootView qlx_shouldHighlightCell];
}

- (void)qlx_didHighlightCell{
    [super qlx_didHighlightCell];
    UIView * rootView = [self getRootView];
    [rootView qlx_didHighlightCell];
}

- (void)qlx_didUnhighlightCell{
    [super qlx_didUnhighlightCell];
    UIView * rootView = [self getRootView];
    [rootView qlx_didUnhighlightCell];
}

#pragma mark - private

- (UIView *)getRootView{
    return (UIView *)self.contentView.subviews.lastObject;
}



@end
