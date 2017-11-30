//
//  QLXCollectionViewUpdateUtil.m
//  UICollectionView+QLXDemo
//
//  Created by QLX on 2017/11/27.
//  Copyright © 2017年 QLX. All rights reserved.
//

#import "QLXCollectionViewUpdateUtil.h"
#import "QLXDiffUtil.h"
#import "QLXDataSource.h"
#import "QLXSectionData.h"
#import "NSObject+QLXView.h"


@interface QLXCollectionViewDiffResult : NSObject

@property (nonatomic, strong, readonly) NSIndexSet *insertSections;
@property (nonatomic, strong, readonly) NSIndexSet *deleteSections;
@property (nonatomic, strong, readonly) NSIndexSet *reloadSections;

@property (nonatomic, strong, readonly) NSMutableSet<NSIndexPath *> *deleteIndexPaths;
@property (nonatomic, strong, readonly) NSMutableSet<NSIndexPath *> *insertIndexPaths;
@property (nonatomic, strong, readonly) NSMutableSet<NSIndexPath *> *reloadIndexPaths;

- (BOOL)hasChanges;

@end

@implementation QLXCollectionViewDiffResult

- (instancetype)initWithInsertSections:(NSIndexSet *)insertSections
                        deleteSections:(NSIndexSet *)deletesSections
                        reloadSections:(NSIndexSet *)reloadSections
                      insertIndexPaths:(NSMutableSet<NSIndexPath *> *)insertIndexPaths
                      deleteIndexPaths:(NSMutableSet<NSIndexPath *> *)deleteIndexPaths
                      reloadIndexPaths:(NSMutableSet<NSIndexPath *> *)reloadIndexPaths
{
    if (self = [super init]) {
        _insertSections = [insertSections copy];
        _deleteSections = [deletesSections copy];
        _reloadSections = [reloadSections copy];
        _insertIndexPaths = [insertIndexPaths copy];
        _deleteIndexPaths = [deleteIndexPaths copy];
        _reloadIndexPaths = [reloadIndexPaths copy];
    }
    
    return self;
}

- (BOOL)hasChanges
{
    return _insertSections.count > 0 || _deleteSections.count > 0 || _reloadSections.count > 0 || _insertIndexPaths.count > 0 || _deleteIndexPaths.count > 0 || _reloadIndexPaths.count > 0;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: %p; insert sections: %@; delete sections: %@; reload sections: %@; insert index paths: %@; delete index paths: %@; reload index paths: %@", NSStringFromClass([self class]), self,_insertSections, _deleteSections, _reloadSections, _insertIndexPaths, _deleteIndexPaths, _reloadIndexPaths];
}

@end






@implementation QLXCollectionViewUpdateUtil

+ (void)performUpdatesWithNewData:(QLXDataSource *)newData
                          oldData:(QLXDataSource *)oldData
                             view:(UICollectionView *)collectionView animated:(BOOL)animated{
    
    QLXCollectionViewDiffResult * diffResult = [self diffWithNewData:newData oldData:oldData];
    if (![diffResult hasChanges]) {
        return;
    }
    
    void (^updates)() = [^{
        [QLXCollectionViewUpdateUtil applyUpdate:diffResult toCollectionView:collectionView];
    } copy];
    
    void (^completion)(BOOL) = [^(BOOL finished) {
    } copy];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        // 主线程更新
        if (animated) {
            [UIView animateWithDuration:0.3 animations:^{
                [collectionView performBatchUpdates:updates completion:completion];
            }];
        }else {
            [UIView performWithoutAnimation:^{
                [collectionView performBatchUpdates:updates completion:completion];
            }];
        }
        
    });
    
}

+ (QLXCollectionViewDiffResult *)diffWithNewData:(QLXDataSource *)newData
                                  oldData:(QLXDataSource *)oldData{
    
    NSMutableIndexSet *reloadSections = [NSMutableIndexSet indexSet];
    NSMutableSet<NSIndexPath *> *reloadIndexPaths = [NSMutableSet set];
    NSMutableSet<NSIndexPath *> *deleteIndexPaths = [NSMutableSet set];
    NSMutableSet<NSIndexPath *> *insertIndexPaths = [NSMutableSet set];
    
    QLXDiffResult *sectionDiffResult = [QLXDiffUtil diffWithMinimumDistance:newData.sectionDataList oldArray:oldData.sectionDataList];
    
    
    
    [sectionDiffResult.inserts enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
        QLXSectionData *newSection = [newData.sectionDataList objectAtIndex:idx];
        [newSection.cellDataList enumerateObjectsUsingBlock:^(NSObject * _Nonnull obj, NSUInteger idx2, BOOL * _Nonnull stop) {
                NSIndexPath *insertIndexPath = [NSIndexPath indexPathForItem:idx2 inSection:idx];
                [insertIndexPaths addObject:insertIndexPath];
        }];
    }];
    
    for (QLXDiffUpdateIndex *sectionUpdate in sectionDiffResult.updates) {
        QLXSectionData * oldSection = [oldData.sectionDataList objectAtIndex:sectionUpdate.oldIndex];
        QLXSectionData * newSection = [newData.sectionDataList objectAtIndex:sectionUpdate.newIndex];
        
        QLXDiffResult *itemDiffResult = [QLXDiffUtil diffWithMinimumDistance:newSection.cellDataList oldArray:oldSection.cellDataList];
        if (![itemDiffResult hasChanges]) {
            // header or footer need to be updated
            [reloadSections addIndex:sectionUpdate.oldIndex];
        } else {
            for (QLXDiffUpdateIndex *update in itemDiffResult.updates) {
                NSIndexPath *reloadIndexPath = [NSIndexPath indexPathForItem:update.oldIndex inSection:sectionUpdate.oldIndex];
                [reloadIndexPaths addObject:reloadIndexPath];
            }
            
            [itemDiffResult.inserts enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
                NSIndexPath *insertIndexPath = [NSIndexPath indexPathForItem:idx inSection:sectionUpdate.oldIndex];
                [insertIndexPaths addObject:insertIndexPath];
                
            }];
            
            [itemDiffResult.deletes enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
                NSIndexPath *deleteIndexPath = [NSIndexPath indexPathForItem:idx inSection:sectionUpdate.oldIndex];
                [deleteIndexPaths addObject:deleteIndexPath];
            }];
        }
        
    }
    
    QLXCollectionViewDiffResult *result = [[QLXCollectionViewDiffResult alloc] initWithInsertSections:sectionDiffResult.inserts
                                                                         deleteSections:sectionDiffResult.deletes
                                                                         reloadSections:reloadSections
                                                                       insertIndexPaths:insertIndexPaths
                                                                       deleteIndexPaths:deleteIndexPaths
                                                                       reloadIndexPaths:reloadIndexPaths];
    
    return result;
}


+ (void)applyUpdate:(QLXCollectionViewDiffResult *)diffResult toCollectionView:(UICollectionView *)collectionView{
    if (!collectionView) {
        return;
    }
    
    // reload index paths should not inculde delete index paths, otherwise it will cause crash:
    // Assertion failure in
    // -[UICollectionView _endItemAnimationsWithInvalidationContext:tentativelyForReordering:animator:]
    NSMutableSet *reloadIndexPaths = [diffResult.reloadIndexPaths mutableCopy];
    [reloadIndexPaths minusSet:diffResult.deleteIndexPaths];
    
    [collectionView deleteItemsAtIndexPaths:[diffResult.deleteIndexPaths allObjects]];
    [collectionView insertItemsAtIndexPaths:[diffResult.insertIndexPaths allObjects]];
    [collectionView reloadItemsAtIndexPaths:[reloadIndexPaths allObjects]];
    
    [collectionView deleteSections:diffResult.deleteSections];
    [collectionView insertSections:diffResult.insertSections];
    [collectionView reloadSections:diffResult.reloadSections];
    
}


@end
