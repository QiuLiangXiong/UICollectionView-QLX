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

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UITapGestureRecognizer * gr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(qlx_didSelectCell)];
        [self addGestureRecognizer:gr];
        self.userInteractionEnabled = true;
    }
    return self;
}


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
        rootView.translatesAutoresizingMaskIntoConstraints = true;
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
    if ([rootView isKindOfClass:[UICollectionReusableView class]]) {
        UICollectionReusableView * cell = (UICollectionReusableView *)rootView;
        [cell prepareForReuse];
    }else {
        [rootView qlx_prepareForReuse];
    }
    rootView.hidden = true;
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
    return (UIView *)self.contentView.subviews.firstObject;
}

- (UIView *)contentView{
    return self;
}

@end
