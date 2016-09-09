//
//  UICollectionViewDataSourceDelegator.m
//  UICollectionView+QLXDemo
//
//  Created by QLX on 16/9/6.
//  Copyright © 2016年 QLX. All rights reserved.
//

#import "UICollectionViewDataSourceDelegator.h"
#import "UICollectionView+QLX.h"
#import "UICollectionReusableView+QLX.h"
#import "NSObject+View.h"
#import "QMacros.h"
#import <objc/runtime.h>
#import "UICollectionViewDataSourceDelegator+CollectionViewDelegator.h"


static NSString * const DefaultCellIdentifier = @"UICollectionViewCell";
static NSString * const DefaultReusableViewIdentifier = @"UICollectionReusableView";


@interface UICollectionViewDataSourceDelegator()<UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSMutableDictionary * cacheCellDic;
@property (nonatomic, strong) NSMutableDictionary * cacheHeaderDic;
@property (nonatomic, strong) NSMutableDictionary * cacheFooterDic;

@end

@implementation UICollectionViewDataSourceDelegator




#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self getSecionDataListWithSection:section].count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    if ([self headerDataList]) {
        return [self headerDataList].count;
    }else {
        NSArray * cellDataList = [self cellDataList];
        if (cellDataList.count) {
            if ([cellDataList.firstObject isKindOfClass:[NSArray class]]) {
                return cellDataList.count;
            }else {
                return 1;
            }
        }
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSObject * cellData = [self getCellDataWithIndexPath:indexPath];
    if ([cellData isKindOfClass:[NSObject class]]) {
        [self registerCellClassIfNeedWithIdentifierClass:[cellData qlx_reuseIdentifierClass]];
        NSString * identifier = NSStringFromClass([cellData qlx_reuseIdentifierClass]);
        UICollectionViewCell * cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        cell.qlx_collectionView = self.collectionView;
        [cell qlx_reuseWithData:cellData indexPath:indexPath];
        return cell;
    }
    [self registerCellClassIfNeedWithIdentifierClass:NSClassFromString(DefaultCellIdentifier)];
    return [self.collectionView dequeueReusableCellWithReuseIdentifier:DefaultCellIdentifier forIndexPath:indexPath];
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    NSObject * data = [self getHeaderOrFooterDataWithKind:kind atIndexPath:indexPath];
    if (data) {
        [self registerSupplementaryViewIfNeedWithIdentifierClass:[data qlx_reuseIdentifierClass] kind:kind];
        NSString * identifier = NSStringFromClass([data qlx_reuseIdentifierClass]);
        UICollectionReusableView * view = [self.collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:identifier forIndexPath:indexPath];
        view.qlx_collectionView = self.collectionView;
        [view qlx_reuseWithData:data indexPath:indexPath];
        return view;
    }
    [self registerSupplementaryViewIfNeedWithIdentifierClass:NSClassFromString(DefaultReusableViewIdentifier) kind:kind];
    return [self.collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:DefaultReusableViewIdentifier forIndexPath:indexPath];
}



#pragma mark UICollectionViewDelegateFlowLayout


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSObject * cellData = [self getCellDataWithIndexPath:indexPath];
    if (cellData) {
            if (cellData.qlx_viewHeight == 0 || cellData.qlx_viewWidth == 0) {
                UICollectionViewCell * cacheCell = [self getCacheCellWithReuseIdentifierClass:[cellData qlx_reuseIdentifierClass]];
                [cacheCell qlx_reuseWithData:cellData indexPath:indexPath];
                CGSize size = [cacheCell qlx_viewSize];
                cellData.qlx_viewWidth = size.width;
                cellData.qlx_viewHeight = size.height;
            }
            return CGSizeMake(cellData.qlx_viewWidth, cellData.qlx_viewHeight);
        }
    return CGSizeZero;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    NSArray * headerDataList = [self headerDataList];
    if (section < headerDataList.count) {
        NSObject * headerData = [headerDataList objectAtIndex:section];
        if (headerData) {
            if (headerData.qlx_viewWidth == 0 && headerData.qlx_viewHeight == 0) {
                if ([self.collectionView.collectionViewLayout isKindOfClass:[UICollectionViewFlowLayout class]]) {
                    UICollectionViewFlowLayout * layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
                    headerData.qlx_viewWidth = layout.headerReferenceSize.width;
                    headerData.qlx_viewHeight = layout.headerReferenceSize.height;
                }
            }
            
            if (headerData.qlx_viewWidth == 0 || headerData.qlx_viewHeight == 0) {
                UICollectionReusableView * cacheHeader = [self getCacheHeaderWithReuseIdentifierClass:[headerData qlx_reuseIdentifierClass]];
                [cacheHeader qlx_reuseWithData:headerData indexPath:[NSIndexPath indexPathForRow:0 inSection:section]];
                CGSize size = [cacheHeader qlx_viewSize];
                headerData.qlx_viewWidth = size.width;
                headerData.qlx_viewHeight = size.height;
            }
            return CGSizeMake(headerData.qlx_viewWidth, headerData.qlx_viewHeight);
        }
    }
    return CGSizeZero;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    NSArray * footerDataList = [self footerDataList];
    if (section < footerDataList.count) {
        NSObject * footerData = [footerDataList objectAtIndex:section];
        if (footerData) {
            if (footerDataList.qlx_viewWidth == 0 && footerDataList.qlx_viewHeight == 0) {
                if ([self.collectionView.collectionViewLayout isKindOfClass:[UICollectionViewFlowLayout class]]) {
                    UICollectionViewFlowLayout * layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
                    footerData.qlx_viewWidth = layout.footerReferenceSize.width;
                    footerData.qlx_viewHeight = layout.footerReferenceSize.height;
                }
            }
            
            if (footerData.qlx_viewWidth == 0 || footerData.qlx_viewHeight == 0) {
                UICollectionReusableView * cacheFooter = [self getCacheFooterWithReuseIdentifierClass:[footerData qlx_reuseIdentifierClass]];
                [cacheFooter qlx_reuseWithData:footerData indexPath:[NSIndexPath indexPathForRow:0 inSection:section]];
                CGSize size = [cacheFooter qlx_viewSize];
                footerData.qlx_viewWidth = size.width;
                footerData.qlx_viewHeight = size.height;
            }
            
            return CGSizeMake(footerData.qlx_viewWidth, footerData.qlx_viewHeight);
        }
    }
    return CGSizeZero;
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
     NSArray * headerDataList = [self headerDataList];
     if (section < headerDataList.count) {
        NSObject * data = [headerDataList objectAtIndex:section];
        return data.qlx_secionInset;
     }else {
         NSArray * footerDataList = [self footerDataList];
         if (section < footerDataList.count) {
             NSObject * data = [footerDataList objectAtIndex:section];
             return data.qlx_secionInset;
         }
     }
    if ([self.collectionView.collectionViewLayout isKindOfClass:[UICollectionViewFlowLayout class]]) {
        UICollectionViewFlowLayout * layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
        return layout.qlx_secionInset;
    }
    return UIEdgeInsetsZero;
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    NSArray * headerDataList = [self headerDataList];
    if (section < headerDataList.count) {
        NSObject * data = [headerDataList objectAtIndex:section];
        return data.qlx_minimumLineSpacing;
    }else {
       NSArray * footerDataList = [self footerDataList];
        if (section < footerDataList.count) {
            NSObject * data = [footerDataList objectAtIndex:section];
            return data.qlx_minimumLineSpacing;
        }
    }
    if ([self.collectionView.collectionViewLayout isKindOfClass:[UICollectionViewFlowLayout class]]) {
        UICollectionViewFlowLayout * layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
        return layout.minimumLineSpacing;
    }
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    NSArray * headerDataList = [self headerDataList];
    if (section < headerDataList.count) {
        NSObject * data = [headerDataList objectAtIndex:section];
        return data.qlx_minimumInteritemSpacing;
    }else {
        NSArray * footerDataList = [self footerDataList];
        if (section < footerDataList.count) {
            NSObject * data = [footerDataList objectAtIndex:section];
            return data.qlx_minimumInteritemSpacing;
        }
    }
    
    if ([self.collectionView.collectionViewLayout isKindOfClass:[UICollectionViewFlowLayout class]]) {
        UICollectionViewFlowLayout * layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
        return layout.minimumInteritemSpacing;
    }
    return 0;
}


#pragma mark - getter



-(NSMutableDictionary *)cacheCellDic{
    if (!_cacheCellDic) {
        _cacheCellDic = [NSMutableDictionary new];
    }
    return _cacheCellDic;
}

-(NSMutableDictionary *)cacheHeaderDic{
    if (!_cacheHeaderDic) {
        _cacheHeaderDic= [NSMutableDictionary new];
    }
    return _cacheHeaderDic;
}

-(NSMutableDictionary *)cacheFooterDic{
    if (!_cacheFooterDic) {
        _cacheFooterDic = [NSMutableDictionary new];
    }
    return _cacheFooterDic;
}

#pragma mark - private

-(UICollectionViewCell *) getCacheCellWithReuseIdentifierClass:(Class)identifierClass{
    if (!identifierClass) {
        return nil;
    }
    NSString * identifier = NSStringFromClass(identifierClass);
    UICollectionViewCell * cacheCell = [self.cacheCellDic objectForKey:identifier];
    if (!cacheCell || ![cacheCell isKindOfClass:[UICollectionViewCell class]]) {
        cacheCell = [[identifierClass alloc] init];
        if ([cacheCell isKindOfClass:[UICollectionViewCell class]]) {
            cacheCell.qlx_collectionView = self.collectionView;
            [self registerCellClass:identifierClass];
            [self.cacheCellDic setObject:cacheCell forKey:identifier];
        }else {
            QLXAssert(false, @"identifier is not a UICollectionViewCell subClassName");
        }
    }
    return cacheCell;
}

-(void) registerCellClassIfNeedWithIdentifierClass:(Class) identifierClass{
    if (identifierClass) {
        NSString * identifier = NSStringFromClass(identifierClass);
        UICollectionViewCell * cacheCell = [self.cacheCellDic objectForKey:identifier];
        if (!cacheCell) {
            Class cellClass = identifierClass;
            if (cellClass) {
                [self registerCellClass:cellClass];
                [self.cacheCellDic setObject:cellClass forKey:identifier];
            }else {
                QLXAssert(cellClass, @"identifier is not a className");
            }
        }
    }
}

-(UICollectionReusableView *) getCacheHeaderWithReuseIdentifierClass:(Class) identifierClass{
    if (!identifierClass) {
        return nil;
    }
    NSString * identifier = NSStringFromClass(identifierClass);
    UICollectionReusableView * cacheHeader = [self.cacheHeaderDic objectForKey:identifier];
    if (!cacheHeader || ![cacheHeader isKindOfClass:[UICollectionReusableView class]]) {
        cacheHeader = [[identifierClass alloc] init];
        if ([cacheHeader isKindOfClass:[UICollectionReusableView class]]) {
            cacheHeader.qlx_collectionView = self.collectionView;
            [self registerHeaderClass:identifierClass];
            [self.cacheHeaderDic setObject:cacheHeader forKey:identifier];
        }else {
            QLXAssert(false, @"identifier is not a className");
        }
        
    }
    return cacheHeader;
}

-(void) registerSupplementaryViewIfNeedWithIdentifierClass:(Class) identifierClass kind:(NSString *)kind{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        [self registerHeaderClassIfNeedWithIdentifierClass:identifierClass];
    }else if([kind isEqualToString:UICollectionElementKindSectionFooter]){
        [self registerFooterClassIfNeedWithIdentifierClass:identifierClass];
    }
}

-(void) registerHeaderClassIfNeedWithIdentifierClass:(Class) identifierClass{
    if (identifierClass) {
        NSString * identifier = NSStringFromClass(identifierClass);
        UICollectionReusableView * cacheHeader = [self.cacheHeaderDic objectForKey:identifier];
        if (!cacheHeader) {
            Class headerClass = identifierClass;
            if (headerClass) {
                [self registerHeaderClass:headerClass];
                [self.cacheHeaderDic setObject:headerClass forKey:identifier];
            }else {
                QLXAssert(false, @"identifier is not a className");
            }
        }
    }
}


-(UICollectionReusableView *) getCacheFooterWithReuseIdentifierClass:(Class) identifierClass{
    if (!identifierClass) {
        return nil;
    }
    NSString * identifier = NSStringFromClass(identifierClass);
    UICollectionReusableView * cacheFooter = [self.cacheFooterDic objectForKey:identifier];
    if (!cacheFooter || ![cacheFooter isKindOfClass:[UICollectionReusableView class]]) {
        cacheFooter = [[identifierClass alloc] init];
        if ([cacheFooter isKindOfClass:[UICollectionReusableView class]]) {
            cacheFooter.qlx_collectionView = self.collectionView;
            [self registerFooterClass:identifierClass];
            [self.cacheFooterDic setObject:cacheFooter forKey:identifier];
        }else {
            QLXAssert(false, @"identifier is not a className");
        }
    }
    return cacheFooter;
}

-(void) registerFooterClassIfNeedWithIdentifierClass:(Class) identifierClass{
    if (identifierClass) {
        NSString * identifier = NSStringFromClass(identifierClass);
        UICollectionReusableView * cacheFooter = [self.cacheFooterDic objectForKey:identifier];
        if (!cacheFooter) {
            Class footerClass = identifierClass;
            if (footerClass) {
                [self registerFooterClass:footerClass];
                [self.cacheFooterDic setObject:footerClass forKey:identifier];
            }else {
                QLXAssert(false, @"identifier is not a className");
            }
        }
    }
}

-(void)registerCellClass:(Class)cellClass {
    QAssert(cellClass);
    [self.collectionView registerClass:cellClass forCellWithReuseIdentifier:NSStringFromClass(cellClass)];
}

-(void) registerHeaderClass:(Class) headerClass{
    QAssert(headerClass);
    [self.collectionView registerClass:headerClass forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass(headerClass)];
}

-(void) registerFooterClass:(Class) footerClass{
    QAssert(footerClass);
    [self.collectionView registerClass:footerClass forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:NSStringFromClass(footerClass)];
}


#pragma mark - private

- (NSArray *) getSecionDataListWithSection:(NSInteger) section{
    NSArray * list = [self cellDataList];
    if (list.count) {
        if (section == 0 && ![list.firstObject isKindOfClass:[NSArray class]]) {
            return list;
        }
        if (section < list.count) {
            NSArray * sectionDataList = [list objectAtIndex:section];
            if ([sectionDataList isKindOfClass:[NSArray class]]) {
                return sectionDataList;
            }else {
                QLXAssert(false, @"sectionDataList not be NSArray type");
            }
        }
    }
    return nil;
}

- (NSObject *) getCellDataWithIndexPath:(NSIndexPath *)indexPath{
    NSArray * sectionDataList = [self getSecionDataListWithSection:indexPath.section];
    if (indexPath.row < sectionDataList.count) {
        return [sectionDataList objectAtIndex:indexPath.row];
    }
    return nil;
}


-(NSObject * )getHeaderOrFooterDataWithKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    NSArray * list;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        list = [self headerDataList];
    }else if([kind isEqualToString:UICollectionElementKindSectionFooter]){
        list = [self footerDataList];
    }
    if (indexPath.section < list.count) {
        return [list objectAtIndex:indexPath.section];
    }
    return nil;
}



- (NSArray *) cellDataList{
    if ([self.delegate respondsToSelector:@selector(qlx_cellDataListWithCollectionView:)]) {
        NSArray * dataList = [self.delegate qlx_cellDataListWithCollectionView:self.collectionView];
        if ([dataList isKindOfClass:[NSArray class]]) {
            return dataList;
        }else if(dataList){
            QLXAssert(false, @"Result not be NSArray type");
        }
    }
    return nil;
}

- (NSArray *) headerDataList{
    if ([self.delegate respondsToSelector:@selector(qlx_headerDataListWithCollectionView:)]) {
        NSArray * dataList = [self.delegate qlx_headerDataListWithCollectionView:self.collectionView];
        if ([dataList isKindOfClass:[NSArray class]]) {
            return dataList;
        }else if(dataList){
            QLXAssert(false, @"Result not be NSArray type");
        }
    }
    return nil;
}

- (NSArray *) footerDataList{
    if ([self.delegate respondsToSelector:@selector(qlx_footerDataListWithCollectionView:)]) {
        NSArray * dataList = [self.delegate qlx_footerDataListWithCollectionView:self.collectionView];
        if ([dataList isKindOfClass:[NSArray class]]) {
            return dataList;
        }else if(dataList){
            QLXAssert(false, @"Result not be NSArray type");
        }
    }
    return nil;
}

- (NSArray *) decorationViewClassList{
    if ([self.delegate respondsToSelector:@selector(qlx_decorationViewClassListWithCollectionView:)]) {
        NSArray * classList = [self.delegate qlx_decorationViewClassListWithCollectionView:self.collectionView];
        if ([classList isKindOfClass:[NSArray class]]) {
            return classList;
        }else if(classList){
            QLXAssert(false, @"Result not be NSArray type");
        }
    }
    return nil;
}






@end
