//
//  NSMutableArray+QLX.h
//  UICollectionView+QLXDemo
//
//  Created by QLX on 2017/11/17.
//  Copyright © 2017年 QLX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray(QLX)

- (void)qlx_syncToViewWithAnimated:(BOOL)animated;

- (void)qlx_addObject:(id)anObject;

- (void)qlx_addObject:(id)anObject syncToView:(BOOL)sync animated:(BOOL)animated;

- (void)qlx_insertObject:(id)anObject atIndex:(NSUInteger)index;

- (void)qlx_insertObject:(id)anObject atIndex:(NSUInteger)index syncToView:(BOOL)sync animated:(BOOL)animated;

- (void)qlx_removeLastObject;

- (void)qlx_removeLastObjectWithSyncToView:(BOOL)sync animated:(BOOL)animated;

- (void)qlx_removeObjectAtIndex:(NSUInteger)index;

- (void)qlx_removeObjectAtIndex:(NSUInteger)index syncToView:(BOOL)sync animated:(BOOL)animated;

- (void)qlx_replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject;

- (void)qlx_replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject syncToView:(BOOL)sync animated:(BOOL)animated;

- (void)qlx_removeObject:(id)anObject;

- (void)qlx_removeObject:(id)anObject syncToView:(BOOL)sync animated:(BOOL)animated;

- (void)qlx_removeObject:(id)anObject inRange:(NSRange)range;

- (void)qlx_removeObject:(id)anObject inRange:(NSRange)range syncToView:(BOOL)sync animated:(BOOL)animated;

- (void)qlx_insertObjects:(NSArray *)objects atIndexes:(NSIndexSet *)indexes;

- (void)qlx_insertObjects:(NSArray *)objects atIndexes:(NSIndexSet *)indexes syncToView:(BOOL)sync animated:(BOOL)animated;

- (void)qlx_removeObjectsInArray:(NSArray *)otherArray;

- (void)qlx_removeObjectsInArray:(NSArray *)otherArray syncToView:(BOOL)sync animated:(BOOL)animated;

- (void)qlx_addObjectsFromArray:(NSArray *)otherArray;

- (void)qlx_addObjectsFromArray:(NSArray *)otherArray syncToView:(BOOL)sync animated:(BOOL)animated ;



@end
