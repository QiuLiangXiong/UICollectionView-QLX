//
//  QLXWrapReuseCollectionViewCell.m
//  UICollectionView+QLXDemo
//
//  Created by QLX on 2017/11/8.
//  Copyright © 2017年 QLX. All rights reserved.
//

#import "QLXWrapReuseCollectionViewCell.h"
#import "UIView+QLX.h"
#import "NSObject+View.h"
#import "UIView+QLX_CellDelegate.h"

@implementation QLXWrapReuseCollectionViewCell

- (void)qlx_reuseWithData:(NSObject *)data indexPath:(NSIndexPath *)indexPath{
    [super qlx_reuseWithData:data indexPath:indexPath];
    UIView * view = [self addRootViewIfNeedWithViewClass:[data qlx_reuseIdentifierClass]];
    view.qlx_collectionView = self.qlx_collectionView;
    [view qlx_reuseWithData:data indexPath:indexPath];
}

- (CGSize)qlx_viewSize{
    UIView * rootView = [self getRootView];
    return [rootView qlx_viewSize];
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


- (UIView *)addRootViewIfNeedWithViewClass:(Class) viewClass{
    if (viewClass) {
       UIView * lastObject = self.contentView.subviews.lastObject;
        if (![lastObject isKindOfClass:viewClass]) {
            UIView * view = [[viewClass alloc] init];
            if ([view isKindOfClass:[UIView class]]) {
                for (UIView * view in self.contentView.subviews) {
                    [view removeFromSuperview];
                }
                [self.contentView addSubview:view];
                [self addEdgeZeroConstraintWithView:view];
            }
        }
    }
    return [self getRootView];
}

- (UIView *)getRootView{
    return (UIView *)self.contentView.subviews.lastObject;
}

- (void)addEdgeZeroConstraintWithView:(UIView *)view{
    view.translatesAutoresizingMaskIntoConstraints = NO;
    UIView * superView = view.superview;
    if (superView) {
        [superView addConstraints:@[
           [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:superView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0],
           [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:superView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0],
           [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:superView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0],
           [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:superView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0],
           ]
         ];
    }
}


@end
