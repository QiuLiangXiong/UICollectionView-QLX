//
//  NSMutableArray+QLX.m
//  UICollectionView+QLXDemo
//
//  Created by QLX on 2017/11/17.
//  Copyright © 2017年 QLX. All rights reserved.
//

#import "NSMutableArray+QLX.h"
#import "QMacros.h"
#import "UICollectionView+QLX_Sync.h"



@implementation NSMutableArray(QLX)

static BOOL  QLXWaitingSyncToView;

#pragma mark public



- (void)qlx_syncToViewWithAnimated:(BOOL)animated{
    
    if (!QLXWaitingSyncToView) {
        QLXWaitingSyncToView = true;
        

        if ([NSThread isMainThread]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                //self 闭包短暂引用 保证可以执行这个api
                [self _syncToViewWithAnimated:@(animated)];//同步
            });
        }else {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self _syncToViewWithAnimated:@(animated)];
            });
        }
    }
}

/*同步数据到对应的视图上*/
- (void)_syncToViewWithAnimated:(NSNumber *)animated{
    [UICollectionView qlx_syncToViewWithAnimated:[animated boolValue] completed:^{
        QLXWaitingSyncToView = false;
    }];
}

- (void)qlx_addObject:(id)anObject{
    [self qlx_addObject:anObject syncToView:true animated:false];
}

- (void)qlx_addObject:(id)anObject syncToView:(BOOL)sync animated:(BOOL)animated{
    [self addObject:anObject];
    if (sync) {
        [self qlx_syncToViewWithAnimated:animated];
    }
}

- (void)qlx_insertObject:(id)anObject atIndex:(NSUInteger)index{
    [self qlx_insertObject:anObject atIndex:index syncToView:true animated:false];
}

- (void)qlx_insertObject:(id)anObject atIndex:(NSUInteger)index syncToView:(BOOL)sync animated:(BOOL)animated{
    [self insertObject:anObject atIndex:index];
    if (sync) {
        [self qlx_syncToViewWithAnimated:animated];
    }
}

- (void)qlx_removeLastObject{
    [self qlx_removeLastObjectWithSyncToView:true animated:false];
}

- (void)qlx_removeLastObjectWithSyncToView:(BOOL)sync animated:(BOOL)animated{
    [self removeLastObject];
    if (sync) {
        [self qlx_syncToViewWithAnimated:animated];
    }
}

- (void)qlx_removeObjectAtIndex:(NSUInteger)index{
    [self qlx_removeObjectAtIndex:index syncToView:true animated:false];
}

- (void)qlx_removeObjectAtIndex:(NSUInteger)index syncToView:(BOOL)sync animated:(BOOL)animated{
    [self removeObjectAtIndex:index];
    if (sync) {
        [self qlx_syncToViewWithAnimated:animated];
    }
}

- (void)qlx_replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject{
    [self qlx_replaceObjectAtIndex:index withObject:anObject syncToView:true animated:false];
}

- (void)qlx_replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject syncToView:(BOOL)sync animated:(BOOL)animated{
    [self replaceObjectAtIndex:index withObject:anObject];
    if (sync) {
        [self qlx_syncToViewWithAnimated:animated];
    }
    
}

- (void)qlx_removeObject:(id)anObject{
    [self qlx_removeObject:anObject syncToView:true animated:false];
}

- (void)qlx_removeObject:(id)anObject syncToView:(BOOL)sync animated:(BOOL)animated{
    [self removeObject:anObject];
    if (sync) {
        [self qlx_syncToViewWithAnimated:animated];
    }
}

- (void)qlx_removeObject:(id)anObject inRange:(NSRange)range{
    [self qlx_removeObject:anObject inRange:range syncToView:true animated:false];
}

- (void)qlx_removeObject:(id)anObject inRange:(NSRange)range syncToView:(BOOL)sync animated:(BOOL)animated{
    [self removeObject:anObject inRange:range];
    if (sync) {
        [self qlx_syncToViewWithAnimated:animated];
    }
}

- (void)qlx_insertObjects:(NSArray *)objects atIndexes:(NSIndexSet *)indexes{
    [self qlx_insertObjects:objects atIndexes:indexes syncToView:true animated:false];
}

- (void)qlx_insertObjects:(NSArray *)objects atIndexes:(NSIndexSet *)indexes syncToView:(BOOL)sync animated:(BOOL)animated{
    [self insertObjects:objects atIndexes:indexes];
    if (sync) {
        [self qlx_syncToViewWithAnimated:animated];
    }
}

- (void)qlx_removeObjectsInArray:(NSArray *)otherArray{
    [self qlx_removeObjectsInArray:otherArray syncToView:true animated:false];
}

- (void)qlx_removeObjectsInArray:(NSArray *)otherArray syncToView:(BOOL)sync animated:(BOOL)animated{
    [self removeObjectsInArray:otherArray];
    if (sync) {
        [self qlx_syncToViewWithAnimated:animated];
    }
}

- (void)qlx_addObjectsFromArray:(NSArray *)otherArray{
    [self qlx_addObjectsFromArray:otherArray syncToView:true animated:false];
}

- (void)qlx_addObjectsFromArray:(NSArray *)otherArray syncToView:(BOOL)sync animated:(BOOL)animated {
    [self addObjectsFromArray:otherArray];
    if (sync) {
        [self qlx_syncToViewWithAnimated:animated];
    }
}




@end
