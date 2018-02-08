//
//  UICollectionView+QLXResort.m
//  UICollectionView+QLXDemo
//
//  Created by QLX on 2017/12/1.
//  Copyright © 2017年 QLX. All rights reserved.
//

#import "UICollectionView+QLXResort.h"
#import <objc/runtime.h>

@interface UICollectionView()

@property(nonatomic , strong) UILongPressGestureRecognizer * qlx_longPressGR;

@end

@implementation UICollectionView(QLXResort)

- (void)qlx_initConfigForResort{
    if (!self.qlx_longPressGR) {
        UILongPressGestureRecognizer * gr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(qlx_longPressAction:)];
        [self addGestureRecognizer:gr];
        self.qlx_longPressGR = gr;
    }
}

- (void)qlx_longPressAction:(UILongPressGestureRecognizer *)longPress{
    //获取此次点击的坐标，根据坐标获取cell对应的indexPath
    CGPoint point = [longPress locationInView:self];
    NSIndexPath *indexPath = [self indexPathForItemAtPoint:point];
    
    switch (longPress.state) {
        case UIGestureRecognizerStateBegan:
            //当没有点击到cell的时候不进行处理
            if (!indexPath) {
                break;
            }
            //开始移动
            if ([self respondsToSelector:@selector(beginInteractiveMovementForItemAtIndexPath:)]) {
            [self beginInteractiveMovementForItemAtIndexPath:indexPath];
            }

            break;
        case UIGestureRecognizerStateChanged:
            //移动过程中更新位置坐标
            if ([self respondsToSelector:@selector(updateInteractiveMovementTargetPosition:)]) {
                [self updateInteractiveMovementTargetPosition:point];
            }
            break;
        case UIGestureRecognizerStateEnded:
            //停止移动调用此方法
            if ([self respondsToSelector:@selector(endInteractiveMovement)]) {
                [self endInteractiveMovement];
            }
            break;
        default:
            //取消移动
            if ([self respondsToSelector:@selector(cancelInteractiveMovement)]) {
                [self cancelInteractiveMovement];
            }
            break;
    }
    
}

- (UILongPressGestureRecognizer *)qlx_longPressGR{
    return objc_getAssociatedObject(self, @selector(qlx_longPressGR));;
}

- (void)setQlx_longPressGR:(UILongPressGestureRecognizer *)qlx_longPressGR{
    objc_setAssociatedObject(self, @selector(qlx_longPressGR), qlx_longPressGR, OBJC_ASSOCIATION_RETAIN);
}




@end
