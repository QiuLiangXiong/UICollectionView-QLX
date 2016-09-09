//
//  UICollectionViewFlowLayout+QLX.m
//  UICollectionView+QLXDemo
//
//  Created by QLX on 16/9/7.
//  Copyright © 2016年 QLX. All rights reserved.
//

#import "UICollectionViewFlowLayout+QLX.h"
#import  <objc/runtime.h>
#import "UICollectionView+QLX.h"
#import "QMacros.h"

@interface UICollectionViewFlowLayout()

@property(nonatomic , strong)  NSMutableArray * decroationViewAttsArray;

@property(nonatomic , strong)  id<UICollectionViewDelegateFlowLayout> delegate;

@property(nonatomic , assign)  BOOL isVerticalLayout;

@end

@implementation UICollectionViewFlowLayout(QLX)


+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleSelector:@selector(prepareLayout) withSelector:@selector(qlx_prepareLayout)];
        [self swizzleSelector:@selector(layoutAttributesForElementsInRect:) withSelector:@selector(qlx_layoutAttributesForElementsInRect:)];
    });
}



- (void)qlx_prepareLayout{
    self.decroationViewAttsArray = nil;
    [self qlx_prepareLayout];
}

- (NSArray<UICollectionViewLayoutAttributes *> *)qlx_layoutAttributesForElementsInRect:(CGRect)rect{
    NSArray * attributes = [self qlx_layoutAttributesForElementsInRect:rect];
    if (attributes && self.collectionView.qlx_dataSource && [self.collectionView.qlx_dataSource respondsToSelector:@selector(qlx_decorationViewClassListWithCollectionView:)]) {
        NSMutableArray * atts = [NSMutableArray arrayWithArray:attributes];
        [atts addObjectsFromArray:self.decroationViewAttsArray];
        return atts;
    }
    return attributes;
}

#pragma mark - getter

- (NSMutableArray *)decroationViewAttsArray{
    NSMutableArray * atts = objc_getAssociatedObject(self, @selector(decroationViewAttsArray));
    if (!atts) {
        atts = [NSMutableArray new];
        objc_setAssociatedObject(self, @selector(decroationViewAttsArray), atts, OBJC_ASSOCIATION_RETAIN);
        
        NSInteger sections = [self.collectionView numberOfSections];
        for (int i = 0; i < sections; i++) {
            UICollectionViewLayoutAttributes * firstAtt = [self firstLayoutAttributeWithSection:i];
            UICollectionViewLayoutAttributes * lastAtt = [self lastLayoutAttributeWithSection:i];
            if (lastAtt == nil) {
                lastAtt = firstAtt;
            }
            UICollectionViewLayoutAttributes * decroationAtt = [self getDecorationViewAttributesWithSection:i firstAtt:firstAtt lastAtt:lastAtt];
            if (decroationAtt) {
                [atts addObject:decroationAtt];
            }
        }
    }
    return atts;
}

-(void)setDecroationViewAttsArray:(NSMutableArray *)decroationViewAttsArray{
    objc_setAssociatedObject(self, @selector(decroationViewAttsArray), decroationViewAttsArray, OBJC_ASSOCIATION_RETAIN);
}


-(id<UICollectionViewDelegateFlowLayout>)delegate{
    return (id<UICollectionViewDelegateFlowLayout>)self.collectionView.dataSource;
}

-(BOOL)isVerticalLayout{
    return self.scrollDirection == UICollectionViewScrollDirectionVertical;
}

- (UICollectionViewLayoutAttributes *) firstLayoutAttributeWithSection:(NSUInteger)section{
    if ([self headerSizeWithSection:section].height >= 0.01) {
        return [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:[NSIndexPath indexPathForRow:0 inSection:section]];
    }else {
        if ([self.collectionView numberOfItemsInSection:section]) {
            return [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:section]];
        }
    }
    return nil;
}

- (UICollectionViewLayoutAttributes *) lastLayoutAttributeWithSection:(NSUInteger)section{
    if ([self footerSizeWithSection:section].height >= 0.01) {
        return [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionFooter atIndexPath:[NSIndexPath indexPathForRow:0 inSection:section]];
    }else {
        NSUInteger numOfItems = [self.collectionView numberOfItemsInSection:section];
        if (numOfItems) {
            return [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:numOfItems - 1 inSection:section]];
        }
    }
    return nil;
}

-(CGSize) headerSizeWithSection:(NSInteger)section{
    if ([self.delegate respondsToSelector:@selector(collectionView:layout:referenceSizeForHeaderInSection:)]) {
        return [self.delegate collectionView:self.collectionView layout:self referenceSizeForHeaderInSection:section];
    }
    return self.headerReferenceSize;
}


-(UICollectionViewLayoutAttributes *) getDecorationViewAttributesWithSection:(NSInteger)section firstAtt:(UICollectionViewLayoutAttributes *)firstAtt lastAtt:(UICollectionViewLayoutAttributes *)lastAtt{
    Class cla = [self getDecorationViewClassWithSecion:section];
    if (cla && firstAtt) {
        QLXAssert([cla isSubclassOfClass:[UICollectionReusableView class]], @"cla 必须是 UICollectionReusableView 的子类");
        [self registerClass:cla forDecorationViewOfKind:NSStringFromClass(cla)];
        UICollectionViewLayoutAttributes * att = [UICollectionViewLayoutAttributes layoutAttributesForDecorationViewOfKind:NSStringFromClass(cla) withIndexPath:[NSIndexPath indexPathForRow:0 inSection:section]];
        if (self.isVerticalLayout) {
            CGFloat y = CGRectGetMinY(firstAtt.frame);
            CGFloat height = CGRectGetMaxY(lastAtt.frame) - y;
            att.frame = CGRectMake(0, y, self.collectionView.frame.size.width, height);
        }else {
            CGFloat x = CGRectGetMinX(firstAtt.frame);
            CGFloat width = CGRectGetMaxX(lastAtt.frame) - x;
            att.frame = CGRectMake(x, 0, width , self.collectionView.frame.size.height);
        }
        att.zIndex = -1;
        return att;
    }
    return nil;
    
}

-(Class) getDecorationViewClassWithSecion:(NSInteger) section{
    if ([self.collectionView.qlx_dataSource respondsToSelector:@selector(qlx_decorationViewClassListWithCollectionView:)]) {
        NSArray * classes = [self.collectionView.qlx_dataSource qlx_decorationViewClassListWithCollectionView:self.collectionView];
        if (section < classes.count ) {
            return [classes objectAtIndex:section];
        }
    }
    
    return nil;
}


-(CGSize) footerSizeWithSection:(NSInteger)section{
    if ([self.delegate respondsToSelector:@selector(collectionView:layout:referenceSizeForFooterInSection:)]) {
        return [self.delegate collectionView:self.collectionView layout:self referenceSizeForFooterInSection:section];
    }
    return self.footerReferenceSize;
}





+ (void)swizzleSelector:(SEL)originalSelector withSelector:(SEL)swizzledSelector {
    Class class = [self class];
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    method_exchangeImplementations(originalMethod, swizzledMethod);
}

@end
