//
//  QLXDiffUtil.h
//  UICollectionView+QLXDemo
//  Created by QLX on 2017/11/27.
//  Copyright © 2017年 QLX. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol QLXDiffable <NSObject>

- (BOOL)qlx_isEqualToObject:(id<QLXDiffable>)object;

@end

@interface QLXDiffUpdateIndex : NSObject

@property (nonatomic, assign, readonly) NSUInteger oldIndex;
@property (nonatomic, assign, readonly) NSUInteger newIndex;

@end

@interface QLXDiffResult : NSObject

@property (nonatomic, strong, readonly) NSIndexSet *inserts;
@property (nonatomic, strong, readonly) NSIndexSet *deletes;
@property (nonatomic, strong, readonly) NSArray<QLXDiffUpdateIndex *> *updates;

- (BOOL)hasChanges;

@end

@interface QLXDiffUtil : NSObject

+ (QLXDiffResult *)diffWithMinimumDistance:(NSArray<id<QLXDiffable>> *)newArray oldArray:(NSArray<id<QLXDiffable>> *)oldArray;

@end
