//
//  UICollectoinView+QLXTransitonAnimation.m
//  UICollectionView+QLXDemo
//
//  Created by QLX on 2017/12/2.
//  Copyright © 2017年 QLX. All rights reserved.
//

#import "UICollectoinView+QLXTransitonAnimation.h"
#import <objc/runtime.h>

/*-----类分割线-----*/

@interface UIView(QLXTransitonAnimation)

@property(nonatomic , assign) CGRect qlx__oldFrame;
@property(nonatomic , assign) CGRect qlx__newFrame;

@end

@implementation UIView(QLXTransitonAnimation)

- (CGRect)qlx__oldFrame{
    NSValue * value = objc_getAssociatedObject(self, @selector(qlx__oldFrame));
    return  [value CGRectValue];
}

- (void)setQlx__oldFrame:(CGRect)qlx__oldFrame{
    objc_setAssociatedObject(self, @selector(qlx__oldFrame), [NSValue valueWithCGRect:qlx__oldFrame], OBJC_ASSOCIATION_RETAIN);
}

- (CGRect)qlx__newFrame{
    NSValue * value = objc_getAssociatedObject(self, @selector(qlx__newFrame));
    return  [value CGRectValue];
}

- (void)setQlx__newFrame:(CGRect)qlx__newFrame{
    objc_setAssociatedObject(self, @selector(qlx__newFrame), [NSValue valueWithCGRect:qlx__newFrame], OBJC_ASSOCIATION_RETAIN);
}

@end



/*-----类分割线-----*/

@implementation UICollectionView(QLXTransitonAnimation)

- (void)qlx_performBatchUpdates:(void (^)(void))updates withAnimated:(QLXTransitonAnimationType)type completion:(void (^)(BOOL))completion{
    if ([NSThread isMainThread]) {
        if (type == QLXTransitonAnimationTypeNone) {
            [UIView performWithoutAnimation:^{
                [self performBatchUpdates:updates completion:completion];
            }];
        }else if(type == QLXTransitonAnimationTypeDefault){
            [self _handleDefaultTransitonAnimationWithUpdates:updates completion:completion];
        }else {
            //更多过渡动画后续提供..
        }
    }else {
        NSAssert(false, @"should be used in main thread");
    }
    
    
}

- (void) _handleDefaultTransitonAnimationWithUpdates:(void (^)(void))updates  completion:(void (^)(BOOL))completion{
    
    [UIView animateWithDuration:0.3 delay:0 options:(UIViewAnimationOptionCurveEaseOut) animations:^{
        [self performBatchUpdates:updates completion:completion];
    } completion:nil];
    
//    NSArray<UIView *> * oldViews = [[self subviews] copy];
//    for (UIView * view in oldViews) {
//        if (!view.hidden) {
//            view.qlx__oldFrame = view.frame;
//        }
//
//    }
//
//
//    [UIView performWithoutAnimation:^{
//        [self performBatchUpdates:updates completion:completion];
//    }];
//    NSArray<UIView *> * newViews = [[self subviews] copy];
//
//    NSMutableArray * hiddenViews = [NSMutableArray new];
//    for (UIView * view in newViews) {
//        view.qlx__newFrame = view.frame;
//        view.clipsToBounds = true;
//
//        if (view.hidden) {
//            continue;
//        }
//
//        if (!CGRectEqualToRect(view.qlx__oldFrame, CGRectZero)) {
//            view.frame = view.qlx__oldFrame;
//        }else {
//            view.frame = CGRectMake(view.qlx__newFrame.origin.x, view.qlx__newFrame.origin.y, view.qlx__newFrame.size.width, 1);
//
//        }
//
//
//
//
//
//
//        //
//
//
//
//    }
//
//
//
//
//
//    [UIView animateWithDuration:0.3 animations:^{
//          //
//        for (UIView * view in newViews) {
//            if (!view.hidden) {
//                view.frame = view.qlx__newFrame;
//            }
//
//
//
//        }
//    }];
//
//    [oldViews enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        obj.qlx__oldFrame = CGRectZero;
//        obj.qlx__newFrame = CGRectZero;
//    }];
//    [newViews enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        obj.qlx__oldFrame = CGRectZero;
//        obj.qlx__newFrame = CGRectZero;
//    }];
//    [hiddenViews enumerateObjectsUsingBlock:^(UIView *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        obj.hidden = true;
//    }];
}








@end
