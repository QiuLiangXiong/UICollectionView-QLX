//
//  UIView+QLX.m
//  UICollectionView+QLXDemo
//
//  Created by QLX on 16/9/6.
//  Copyright © 2016年 QLX. All rights reserved.
//

#import "UIView+QLX.h"
#import <objc/runtime.h>
#import "QLXWeakObject.h"
#import "QMacros.h"
#import "NSObject+View.h"

@interface UIView()<UICollectionViewDelegate>

@end

@implementation UIView(QLX)



- (void)qlx_reuseWithData:(NSObject *)data indexPath:(NSIndexPath *)indexPath NS_REQUIRES_SUPER{
    self.qlx_data = data;
    self.qlx_indexPath = indexPath;
}

-(CGSize)qlx_viewSize{

    
    UIView * view = self;
    if ([self isKindOfClass:[UICollectionViewCell class]]) {
        view = [self performSelector:@selector(contentView)];
    }
    
    CGFloat width = self.qlx_viewWidth;
    CGFloat height = self.qlx_viewHeight;
    
    if ([self isVerticalLayout] && height > 0) {
        return CGSizeMake(width, height);
    }else if(![self isVerticalLayout] && width > 0){
        return CGSizeMake(width, height);
    }
    self.frame = CGRectMake(0, 0, width, height);
    if ([self isVerticalLayout]) {
        [self updateWidthWithView:view width:width];
    }else {
        [self updateHeightWithView:view height:height];
    }
   
    CGSize  comproessedSize = [view systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    
    if ([self isVerticalLayout]) {
        comproessedSize.width = width;
    }else {
        comproessedSize.height = height;
    }
    return comproessedSize;
}

- (void)qlx_viewSizeChanged{
    [super qlx_viewSizeChanged];
    self.frame = CGRectZero;
}

- (CGFloat)qlx_viewWidth{
    if ([super qlx_viewWidth] > 0) {
        return [super qlx_viewWidth];
    }
    if ([self isVerticalLayout]) {
        if (self.qlx_indexPath.row == NSNotFound) {
            return self.qlx_collectionView.frame.size.width;
        }else {
            UIEdgeInsets insets = [self _seciontInset];
            return self.qlx_collectionView.frame.size.width - insets.left - insets.right;
        }
    }
    return 0;
}

- (CGFloat)qlx_viewHeight{
    if ([super qlx_viewHeight] > 0) {
        return [super qlx_viewHeight];
    }
    if (![self isVerticalLayout]) {
        if (self.qlx_indexPath.row == NSNotFound) {
            return self.qlx_collectionView.frame.size.height;
        }else {
            UIEdgeInsets insets = [self _seciontInset];
            return self.qlx_collectionView.frame.size.height - insets.top - insets.bottom;
        }
        
    }
    return 0;
}


#pragma mark - private

-(BOOL) isVerticalLayout{
    if ([self.qlx_collectionView.collectionViewLayout isKindOfClass:[UICollectionViewFlowLayout class]]) {
        UICollectionViewFlowLayout * layout = (UICollectionViewFlowLayout *)(self.qlx_collectionView.collectionViewLayout);
        return layout.scrollDirection == UICollectionViewScrollDirectionVertical;
    }
    return true;
}

-(UIEdgeInsets) _seciontInset{
    if ([self.qlx_collectionView.delegate respondsToSelector:@selector(collectionView:layout:insetForSectionAtIndex:)]) {
        id<UICollectionViewDelegateFlowLayout> delegate = (id<UICollectionViewDelegateFlowLayout>)self.qlx_collectionView.delegate;
        
        return [delegate collectionView:self.qlx_collectionView layout:self.qlx_collectionView.collectionViewLayout insetForSectionAtIndex:self.qlx_indexPath.section];
    }
    return UIEdgeInsetsZero;
}

-(void) updateWidthWithView:(UIView *)view width:(CGFloat)width{
    BOOL updated = false;
    NSArray * constraints = [view.constraints copy];
    for (NSLayoutConstraint * constraint in constraints) {
        if (constraint.firstAttribute == NSLayoutAttributeWidth && constraint.secondAttribute == NSLayoutAttributeNotAnAttribute && constraint.relation == NSLayoutRelationEqual && constraint.secondItem == nil && constraint.multiplier == 1 && constraint.firstItem == view) {
            if (constraint.constant != width) {
                constraint.constant = width;
            }
            updated = true;
        }else if(constraint.firstAttribute == NSLayoutAttributeHeight && constraint.secondAttribute == NSLayoutAttributeNotAnAttribute && constraint.relation == NSLayoutRelationEqual && constraint.secondItem == nil && constraint.multiplier == 1 && constraint.firstItem == view){
            [view removeConstraint:constraint];
        }
    }
    if (!updated) {
        NSLayoutConstraint * widthConstraint = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:width];
        view.translatesAutoresizingMaskIntoConstraints = NO;
        [view addConstraint:widthConstraint];;

    }
}

-(void) updateHeightWithView:(UIView *)view height:(CGFloat)height{
    BOOL updated = false;
    
    NSArray * constraints = [view.constraints copy];
    
    for (NSLayoutConstraint * constraint in constraints) {
        if (constraint.firstAttribute == NSLayoutAttributeHeight && constraint.secondAttribute == NSLayoutAttributeNotAnAttribute && constraint.relation == NSLayoutRelationEqual && constraint.secondItem == nil && constraint.multiplier == 1 && constraint.firstItem == view) {
            if (constraint.constant != height) {
                constraint.constant = height;
            }
            updated = true;
        }else if(constraint.firstAttribute == NSLayoutAttributeWidth && constraint.secondAttribute == NSLayoutAttributeNotAnAttribute && constraint.relation == NSLayoutRelationEqual && constraint.secondItem == nil && constraint.multiplier == 1 && constraint.firstItem == view){
            [view removeConstraint:constraint];
        }
    }
    if (!updated) {
        NSLayoutConstraint * heightConstraint = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:height];
        view.translatesAutoresizingMaskIntoConstraints = NO;
        [view addConstraint:heightConstraint];;
    }
}




#pragma mark - getter settter


-(NSObject *)qlx_data{
    return objc_getAssociatedObject(self, @selector(data));
}

-(void)setQlx_data:(NSObject *)data{
    if (self.qlx_data != data) {
       objc_setAssociatedObject(self, @selector(data), data, OBJC_ASSOCIATION_RETAIN);
    }

}

-(NSIndexPath *)qlx_indexPath{
    return objc_getAssociatedObject(self, @selector(qlx_indexPath));
}

-(void)setQlx_indexPath:(NSIndexPath *)indexPath{
    objc_setAssociatedObject(self, @selector(qlx_indexPath), indexPath, OBJC_ASSOCIATION_RETAIN);
}

-(UICollectionView *)qlx_collectionView{
    QLXWeakObject * object = objc_getAssociatedObject(self, @selector(qlx_collectionView));
    return [object weakObject];
}

-(void)setQlx_collectionView:(UICollectionView *)collectionView{
    if (self.qlx_collectionView != collectionView) {
        QLXWeakObject * weakObject = [QLXWeakObject new];
        weakObject.weakObject = collectionView;
        objc_setAssociatedObject(self, @selector(qlx_collectionView), weakObject, OBJC_ASSOCIATION_RETAIN);
    }
}




@end
