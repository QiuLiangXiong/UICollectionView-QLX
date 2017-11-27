//
//  QLXDiffUtil.m
//  UICollectionView+QLXDemo
//
//  Created by QLX on 2017/11/27.
//  Copyright © 2017年 QLX. All rights reserved.
//

#import "QLXDiffUtil.h"

typedef enum : NSUInteger {
    QLXDiffOperationDoNothing,
    QLXDiffOperationUpdate,
    QLXDiffOperationDelete,
    QLXDiffOperationInsert
} QLXDiffOperation;

@implementation QLXDiffUpdateIndex

- (instancetype)initWithOldIndex:(NSUInteger)oldIndex newIndex:(NSUInteger)newIndex
{
    if (self = [super init]) {
        _oldIndex = oldIndex;
        _newIndex = newIndex;
    }
    
    return self;
}

@end

@implementation QLXDiffResult

- (instancetype)initWithInserts:(NSIndexSet *)inserts
                        deletes:(NSIndexSet *)deletes
                        updates:(NSArray<QLXDiffUpdateIndex *> *)updates
{
    if (self = [super init]) {
        _inserts = [inserts copy];
        _deletes = [deletes copy];
        _updates = [updates copy];
    }
    
    return self;
}

- (BOOL)hasChanges
{
    return _updates.count > 0 || _inserts.count > 0 || _deletes.count > 0;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: %p; %zi inserts; %zi deletes; %zi updates", NSStringFromClass([self class]), self, _inserts.count, _deletes.count, _updates.count];
}


@end

@implementation QLXDiffUtil

+ (QLXDiffResult *)diffWithMinimumDistance:(NSArray<id<QLXDiffable>> *)newArray oldArray:(NSArray<id<QLXDiffable>> *)oldArray
{
    // Using the levenshtein algorithm
    // https://en.wikipedia.org/wiki/Levenshtein_distance
    
    int oldSize = (int)(oldArray.count + 1);
    int newSize = (int)(newArray.count + 1);
    
    int **matrix = malloc(oldSize * sizeof(int *));
    for (int i = 0; i < oldSize; i++) {
        matrix[i] = malloc(newSize * sizeof(int));
    }
    
    matrix[0][0] = 0;
    
    for (int i = 1; i < oldSize; i++) {
        matrix[i][0] = i;
    }
    
    for (int j = 1; j < newSize; j++) {
        matrix[0][j] = j;
    }
    
    for (int oldIndex = 1; oldIndex < oldSize; oldIndex ++) {
        for (int newIndex = 1; newIndex < newSize; newIndex ++) {
            if ([oldArray[oldIndex - 1] qlx_isEqualToObject:newArray[newIndex - 1]]) {
                matrix[oldIndex][newIndex] = matrix[oldIndex - 1][newIndex - 1];
            } else {
                int updateCost = matrix[oldIndex - 1][newIndex - 1] + 1;
                int insertCost = matrix[oldIndex][newIndex - 1] + 1;
                int deleteCost = matrix[oldIndex - 1][newIndex] + 1;
                matrix[oldIndex][newIndex] = MIN(MIN(insertCost, deleteCost), updateCost);
            }
        }
    }
    
    [self _printMatrix:matrix rowSize:oldSize columnSize:newSize];
    
    NSMutableArray *updates = [NSMutableArray array];
    NSMutableIndexSet *inserts = [NSMutableIndexSet indexSet];
    NSMutableIndexSet *deletes = [NSMutableIndexSet indexSet];
    int oldIndex = oldSize - 1;
    int newIndex = newSize - 1;
    while (oldIndex != 0 || newIndex != 0) {
        QLXDiffOperation operation = [self _operationInMatrix:matrix newIndex:newIndex oldIndex:oldIndex];
        switch (operation) {
            case QLXDiffOperationUpdate:
                newIndex --;
                oldIndex --;
                [updates addObject:[[QLXDiffUpdateIndex alloc] initWithOldIndex:oldIndex newIndex:newIndex]];
                break;
            case QLXDiffOperationDelete:
                oldIndex --;
                [deletes addIndex:oldIndex];
                break;
            case QLXDiffOperationInsert:
                newIndex --;
                [inserts addIndex:newIndex];
                break;
            case QLXDiffOperationDoNothing:
                newIndex --;
                oldIndex --;
                break;
        }
    }
    
    for (int i = 0; i < oldSize; i++) {
        free(matrix[i]);
    }
    free(matrix);
    
    QLXDiffResult *result = [[QLXDiffResult alloc] initWithInserts:inserts deletes:deletes updates:updates];
    return result;
}

+ (QLXDiffOperation)_operationInMatrix:(int **)matrix newIndex:(int)newIndex oldIndex:(int)oldIndex
{
    if (newIndex == 0) {
        return QLXDiffOperationDelete;
    }
    
    if (oldIndex == 0) {
        return QLXDiffOperationInsert;
    }
    
    int cost = matrix[oldIndex][newIndex];
    
    int costBeforeInsert = matrix[oldIndex][newIndex - 1];
    if (costBeforeInsert + 1 == cost) {
        return QLXDiffOperationInsert;
    }
    
    int costBeforDelete = matrix[oldIndex - 1][newIndex];
    if (costBeforDelete + 1 == cost) {
        return QLXDiffOperationDelete;
    }
    
    int costBeforUpdate = matrix[oldIndex - 1][newIndex - 1];
    if (costBeforUpdate + 1 == cost) {
        return QLXDiffOperationUpdate;
    }
    
    return QLXDiffOperationDoNothing;
}

+ (void)_printMatrix:(int **)matrix rowSize:(int)rowSize columnSize:(int)columnSize
{
    for (int i = 0; i < rowSize; i ++) {
        NSMutableArray *array = [NSMutableArray array];
        for (int j = 0; j < columnSize; j ++) {
            int value = matrix[i][j];
            NSString *result;
            if (value < 10) {
                result = [NSString stringWithFormat:@"0%zi", value];
            } else {
                result = [NSString stringWithFormat:@"%zi", value];
            }
            [array addObject:result];
        }
    }
}

@end
