//
//  UICollectionViewDataSourceDelegator+CollectionViewDelegator.m
//  UICollectionView+QLXDemo
//
//  Created by QLX on 16/9/8.
//  Copyright © 2016年 QLX. All rights reserved.
//

#import "UICollectionViewDataSourceDelegator+CollectionViewDelegator.h"
#import "QLXWeakObject.h"
#import "objc/runtime.h"

@interface UICollectionViewDataSourceDelegator()

@property(nonatomic , weak) id<UICollectionViewDelegate> collectionViewDelegate;

@end

@implementation UICollectionViewDataSourceDelegator(CollectionViewDelegator)


#pragma mark - getter


-(id<UICollectionViewDelegate>)collectionViewDelegate{
    QLXWeakObject * delegate = objc_getAssociatedObject(self, @selector(collectionViewDelegate));
    return [delegate weakObject];
}

#pragma mark- getter


-(void)setCollectionViewDelegate:(id<UICollectionViewDelegate>)collectionViewDelegate{
    if (self.collectionViewDelegate != collectionViewDelegate) {
        QLXWeakObject * weakObject = [QLXWeakObject new];
        weakObject.weakObject = collectionViewDelegate;
        objc_setAssociatedObject(self, @selector(collectionViewDelegate), weakObject, OBJC_ASSOCIATION_RETAIN);
    }
}

#pragma mark - UICollectionViewDelegate

- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.collectionViewDelegate respondsToSelector:@selector(collectionView:shouldHighlightItemAtIndexPath:)]) {
        return [self.collectionViewDelegate collectionView:collectionView shouldHighlightItemAtIndexPath:indexPath];
    }
    UICollectionViewCell * cell = [collectionView cellForItemAtIndexPath:indexPath];
    if (cell) {
        return [cell qlx_shouldHighlightCell];
    }
    return true;
}

- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.collectionViewDelegate respondsToSelector:@selector(collectionView:didHighlightItemAtIndexPath:)]) {
        [self.collectionViewDelegate collectionView:collectionView didHighlightItemAtIndexPath:indexPath];
    }
    UICollectionViewCell * cell = [collectionView cellForItemAtIndexPath:indexPath];
    [cell qlx_didHighlightCell];
}


- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.collectionViewDelegate respondsToSelector:@selector(collectionView:didUnhighlightItemAtIndexPath:)]) {
        [self.collectionViewDelegate collectionView:collectionView didUnhighlightItemAtIndexPath:indexPath];
    }
    UICollectionViewCell * cell = [collectionView cellForItemAtIndexPath:indexPath];
    [cell qlx_didUnhighlightCell];
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.collectionViewDelegate respondsToSelector:@selector(collectionView:shouldSelectItemAtIndexPath:)]) {
        return [self.collectionViewDelegate collectionView:collectionView shouldSelectItemAtIndexPath:indexPath];
    }
    UICollectionViewCell * cell = [collectionView cellForItemAtIndexPath:indexPath];
    if (cell) {
        return [cell qlx_shouldSelectCell];
    }
    return true;
}
- (BOOL)collectionView:(UICollectionView *)collectionView shouldDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.collectionViewDelegate respondsToSelector:@selector(collectionView:shouldDeselectItemAtIndexPath:)]) {
        return [self.collectionViewDelegate collectionView:collectionView shouldDeselectItemAtIndexPath:indexPath];
    }
    UICollectionViewCell * cell = [collectionView cellForItemAtIndexPath:indexPath];
    if (cell) {
        return [cell qlx_shouldDeselectCell];
    }
    return true;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.collectionViewDelegate respondsToSelector:@selector(collectionView:didSelectItemAtIndexPath:)]) {
        [self.collectionViewDelegate collectionView:collectionView didSelectItemAtIndexPath:indexPath];
    }
    UICollectionViewCell * cell = [collectionView cellForItemAtIndexPath:indexPath];
    [cell qlx_didSelectCell];
}
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.collectionViewDelegate respondsToSelector:@selector(collectionView:didDeselectItemAtIndexPath:)]) {
        [self.collectionViewDelegate collectionView:collectionView didDeselectItemAtIndexPath:indexPath];
    }
    UICollectionViewCell * cell = [collectionView cellForItemAtIndexPath:indexPath];
    [cell qlx_didDeselectCell];
}


-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.collectionViewDelegate respondsToSelector:@selector(collectionView:willDisplayCell:forItemAtIndexPath:)]) {
        [self.collectionViewDelegate collectionView:collectionView willDisplayCell:cell forItemAtIndexPath:indexPath];
    }
    [cell qlx_willDisplayCell];
}




#pragma mark UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if ([self.collectionViewDelegate respondsToSelector:@selector(scrollViewDidScroll:)]) {
        [self.collectionViewDelegate scrollViewDidScroll:scrollView];
    }
}


-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    if ([self.collectionViewDelegate respondsToSelector:@selector(scrollViewWillBeginDragging:)]) {
        [self.collectionViewDelegate scrollViewWillBeginDragging:scrollView];
    }
}




-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    
    if ([self.collectionViewDelegate respondsToSelector:@selector(scrollViewWillEndDragging:withVelocity:targetContentOffset:)]) {
        [self.collectionViewDelegate scrollViewWillEndDragging:scrollView withVelocity:velocity targetContentOffset:targetContentOffset];
    }
    
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    if ([self.collectionViewDelegate respondsToSelector:@selector(scrollViewDidEndDragging:willDecelerate:)]) {
        [self.collectionViewDelegate scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
    }
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    if ([self.collectionViewDelegate respondsToSelector:@selector(scrollViewWillBeginDecelerating:)]) {
        [self.collectionViewDelegate scrollViewWillBeginDecelerating:scrollView];
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if ([self.collectionViewDelegate respondsToSelector:@selector(scrollViewDidEndDecelerating:)]) {
        [self.collectionViewDelegate scrollViewDidEndDecelerating:scrollView];
    }
    
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    if ([self.collectionViewDelegate respondsToSelector:@selector(scrollViewDidEndScrollingAnimation:)]) {
        [self.collectionViewDelegate scrollViewDidEndScrollingAnimation:scrollView];
    }
}

-(void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale{
    
    if ([self.collectionViewDelegate respondsToSelector:@selector(scrollViewDidEndZooming:withView:atScale:)]) {
        [self.collectionViewDelegate scrollViewDidEndZooming:scrollView withView:view atScale:scale];
    }
    
}

#pragma mark - publick

-(void) updateCollectionViewDelegateIfNeed{
    if (self.collectionView.dataSource) {
        if (self.collectionView.delegate != self) {
            self.collectionViewDelegate = self.collectionView.delegate;
            self.collectionView.delegate = self;
        }
    }else {
        self.collectionView.delegate = self.collectionViewDelegate;
    }
    
}

@end
