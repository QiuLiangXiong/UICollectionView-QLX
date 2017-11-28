//
//  QLXDataSource.m
//  UICollectionView+QLXDemo
//
//  Created by QLX on 2017/11/27.
//  Copyright © 2017年 QLX. All rights reserved.
//

#import "QLXDataSource.h"
#import "UICollectionView+QLX.h"
#import "NSMutableArray+QLX.h"
#import "QLXCollectionViewUpdateUtil.h"

@implementation QLXDataSource

#pragma mark - public

+ (instancetype)createWithCollectionView:(UICollectionView *)collectionView{
    if ([collectionView isKindOfClass:[UICollectionView class]] && collectionView.qlx_dataSource) {
        QLXDataSource * source = [QLXDataSource new];
        [source _fullContentWithCollectionView:collectionView];
        return source;
    }else {
        return [QLXDataSource new];
    }
}


#pragma mark - private

- (void)_fullContentWithCollectionView:(UICollectionView *)collectionView{
    id<QLXCollectionViewDataSource> delegate = collectionView.qlx_dataSource;
    
    NSMutableArray<QLXSectionData *> * res = [NSMutableArray new];
    if ([delegate respondsToSelector:@selector(qlx_sectionDataListWithCollectionView:)]) {
        res = [self _copyWithArray:[delegate qlx_sectionDataListWithCollectionView:collectionView]];
    }
    self.sectionDataList = res;
}



- (NSMutableArray<QLXSectionData *> *)_copyWithArray:(NSArray *)array{
    if ([array isKindOfClass:[NSArray class]]) {
        NSMutableArray * newArray = [[NSMutableArray alloc] initWithCapacity:array.count+1];
        for (id ele in array) {
            if ([ele isKindOfClass:[QLXSectionData class]]) {
                QLXSectionData * sectionData = (QLXSectionData *)ele;
                QLXSectionData * copySectionData = [QLXSectionData new];
                copySectionData.headerData = [self _copyInstanceIfNeed:sectionData.headerData];
                copySectionData.footerData = [self _copyInstanceIfNeed:sectionData.footerData];
                copySectionData.cellDataList =  (NSMutableArray *)[self _copyInstanceIfNeed:sectionData.cellDataList];
                copySectionData.decorationData = sectionData.decorationData;
                [newArray addObject:copySectionData];
            }else {
                [newArray addObject:ele];
            }
        }
        return newArray;
    }
    return [NSMutableArray new];
}

- (NSObject *)_copyInstanceIfNeed:(NSObject *)object{
    if (object == nil) {
        return nil;
    }
    if ([object isKindOfClass:[NSMutableArray class]]) {
        return [object mutableCopy];
    }
    return object;
}




@end
