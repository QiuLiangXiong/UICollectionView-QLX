//
//  UICollectionViewDataSourceDelegator.m
//  UICollectionView+QLXDemo
//
//  Created by QLX on 16/9/6.
//  Copyright © 2016年 QLX. All rights reserved.
//

#import "UICollectionViewDataSourceDelegator.h"
#import "UICollectionView+QLX.h"
#import "UIView+QLX.h"
#import "NSObject+QLXView.h"
#import "QMacros.h"
#import <objc/runtime.h>
#import "UICollectionViewDataSourceDelegator+CollectionViewDelegator.h"
#import "QLXWrapViewData.h"
#import "QLXWrapReuseCollectionViewCell.h"
#import "QLXWrapReuseCollectionReusableView.h"
#import "QLXSectionData.h"
#import "UICollectionView+QLXResort.h"


static NSString * const DefaultCellIdentifier = @"UICollectionViewCell";
static NSString * const DefaultReusableViewIdentifier = @"UICollectionReusableView";


@interface UICollectionViewDataSourceDelegator()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>

@property(nonatomic , strong) NSArray * sectionDataList;
@property (nonatomic, strong) NSMutableDictionary * cacheCellDic;
@property (nonatomic, strong) NSMutableDictionary * cacheHeaderDic;
@property (nonatomic, strong) NSMutableDictionary * cacheFooterDic;

@end

@implementation UICollectionViewDataSourceDelegator



#pragma mark - public


#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self getSectionDataWithSection:section].cellDataList.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.sectionDataList.count;
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
    
    NSObject * data = [self getHeaderOrFooterDataWithKind:kind atSection:indexPath.section];
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


- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(9_0){
    return  [self getCellDataWithIndexPath:indexPath].qlx_resortEnable;
}
- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath*)destinationIndexPath NS_AVAILABLE_IOS(9_0){
    NSObject * sourceData = [self getCellDataWithIndexPath:sourceIndexPath];
    NSObject * destinationIndexPathData = [self getCellDataWithIndexPath:destinationIndexPath];
    
    if(sourceData && destinationIndexPathData){
        QLXSectionData * sSeciontData = [self getSectionDataWithSection:sourceIndexPath.section];
        QLXSectionData * dSeciontData = [self getSectionDataWithSection:destinationIndexPath.section];
        [sSeciontData.cellDataList replaceObjectAtIndex:sourceIndexPath.row withObject:destinationIndexPathData];
        [dSeciontData.cellDataList replaceObjectAtIndex:destinationIndexPath.row withObject:sourceData];
        
    }
    
    
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
            return [self safeSize: CGSizeMake(cellData.qlx_viewWidth, cellData.qlx_viewHeight)];
        }
    return [self safeSize:CGSizeZero];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    NSObject * headerData  = [self getHeaderOrFooterDataWithKind:UICollectionElementKindSectionHeader atSection:section];
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
            [cacheHeader qlx_reuseWithData:headerData indexPath:[NSIndexPath indexPathForRow:NSNotFound inSection:section]];
            CGSize size = [cacheHeader qlx_viewSize];
            headerData.qlx_viewWidth = size.width;
            headerData.qlx_viewHeight = size.height;
         }
         return [self safeSize:CGSizeMake(headerData.qlx_viewWidth, headerData.qlx_viewHeight)];
    }
    return [self safeSize:CGSizeZero];;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    NSObject * footerData  = [self getHeaderOrFooterDataWithKind:UICollectionElementKindSectionFooter atSection:section];

        if (footerData) {
            if (footerData.qlx_viewWidth == 0 && footerData.qlx_viewHeight == 0) {
                if ([self.collectionView.collectionViewLayout isKindOfClass:[UICollectionViewFlowLayout class]]) {
                    UICollectionViewFlowLayout * layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
                    footerData.qlx_viewWidth = layout.footerReferenceSize.width;
                    footerData.qlx_viewHeight = layout.footerReferenceSize.height;
                }
            }
            
            if (footerData.qlx_viewWidth == 0 || footerData.qlx_viewHeight == 0) {
                UICollectionReusableView * cacheFooter = [self getCacheFooterWithReuseIdentifierClass:[footerData qlx_reuseIdentifierClass]];
                [cacheFooter qlx_reuseWithData:footerData indexPath:[NSIndexPath indexPathForRow:NSNotFound inSection:section]];
                CGSize size = [cacheFooter qlx_viewSize];
                footerData.qlx_viewWidth = size.width;
                footerData.qlx_viewHeight = size.height;
            }
            
            return [self safeSize:CGSizeMake(footerData.qlx_viewWidth, footerData.qlx_viewHeight)];
        }
    return [self safeSize:CGSizeZero];
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    QLXSectionData * sectionData = [self getSectionDataWithSection:section];
     if (sectionData.headerData) {
        return sectionData.headerData.qlx_secionInset;
     }else if(sectionData.footerData){
         return sectionData.footerData.qlx_secionInset;
     }
    if ([self.collectionView.collectionViewLayout isKindOfClass:[UICollectionViewFlowLayout class]]) {
        UICollectionViewFlowLayout * layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
        return layout.sectionInset;
    }
    return UIEdgeInsetsZero;
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    QLXSectionData * sectionData = [self getSectionDataWithSection:section];
    if (sectionData.headerData) {
        return sectionData.headerData.qlx_minimumLineSpacing;;
    }else if(sectionData.footerData){
        return sectionData.footerData.qlx_minimumLineSpacing;
    }
    if ([self.collectionView.collectionViewLayout isKindOfClass:[UICollectionViewFlowLayout class]]) {
        UICollectionViewFlowLayout * layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
        return layout.minimumLineSpacing;
    }
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    QLXSectionData * sectionData = [self getSectionDataWithSection:section];
    if (sectionData.headerData) {
        return sectionData.headerData.qlx_minimumInteritemSpacing;;
    }else if(sectionData.footerData){
        return sectionData.footerData.qlx_minimumInteritemSpacing;
    }
    
    if ([self.collectionView.collectionViewLayout isKindOfClass:[UICollectionViewFlowLayout class]]) {
        UICollectionViewFlowLayout * layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
        return layout.minimumInteritemSpacing;
    }
    return 0;
}


#pragma mark - getter

- (NSMutableDictionary *)cacheCellDic{
    if (!_cacheCellDic) {
        _cacheCellDic = [NSMutableDictionary new];
    }
    return _cacheCellDic;
}

- (NSMutableDictionary *)cacheHeaderDic{
    if (!_cacheHeaderDic) {
        _cacheHeaderDic= [NSMutableDictionary new];
    }
    return _cacheHeaderDic;
}

- (NSMutableDictionary *)cacheFooterDic{
    if (!_cacheFooterDic) {
        _cacheFooterDic = [NSMutableDictionary new];
    }
    return _cacheFooterDic;
}

#pragma mark - private

- (Class)getRegisterClassWithIdentifierClass:(Class)identifierClass{
    if ([identifierClass isSubclassOfClass:[UICollectionViewCell class]]) {
        return identifierClass;
    }
    return [QLXWrapReuseCollectionViewCell class];;
}

- (Class)getRegisterHeaderOrFooterClassWithIdentifierClass:(Class)identifierClass{
    if ([identifierClass isSubclassOfClass:[UICollectionReusableView class]]) {
        return identifierClass;
    }
    return [QLXWrapReuseCollectionReusableView class];;
}

- (UICollectionViewCell *)getCacheCellWithReuseIdentifierClass:(Class)identifierClass{
    if (!identifierClass) {
        return nil;
    }
    NSString * identifier = NSStringFromClass(identifierClass);
    UICollectionViewCell * cacheCell = [self.cacheCellDic objectForKey:identifier];
    if (!cacheCell || ![cacheCell isKindOfClass:[UICollectionViewCell class]]) {
        Class registerClass = [self getRegisterClassWithIdentifierClass:identifierClass];
        cacheCell = [[registerClass alloc] init];
        if ([cacheCell isKindOfClass:[UICollectionViewCell class]]) {
            cacheCell.qlx_collectionView = self.collectionView;
            [self registerCellClass:registerClass indentifier:identifier];
            [self.cacheCellDic setObject:cacheCell forKey:identifier];
        }else {
            QLXAssert(false, @"identifier is not a UICollectionViewCell subClassName");
        }
    }
    return cacheCell;
}

- (void)registerCellClassIfNeedWithIdentifierClass:(Class) identifierClass{
    if (identifierClass) {
        NSString * identifier = NSStringFromClass(identifierClass);
        UICollectionViewCell * cacheCell = [self.cacheCellDic objectForKey:identifier];
        if (!cacheCell) {
            Class cellClass = [self getRegisterClassWithIdentifierClass:identifierClass];
            if (cellClass) {
                [self registerCellClass:cellClass indentifier:identifier];
                [self.cacheCellDic setObject:cellClass forKey:identifier];
            }else {
                QLXAssert(cellClass, @"identifier is not a className");
            }
        }
    }
}

- (UICollectionReusableView *)getCacheHeaderWithReuseIdentifierClass:(Class) identifierClass{
    if (!identifierClass) {
        return nil;
    }
    NSString * identifier = NSStringFromClass(identifierClass);
    UICollectionReusableView * cacheHeader = [self.cacheHeaderDic objectForKey:identifier];
    if (!cacheHeader || ![cacheHeader isKindOfClass:[UICollectionReusableView class]]) {
        Class headerClass = [self getRegisterHeaderOrFooterClassWithIdentifierClass:identifierClass];
        cacheHeader = [[headerClass alloc] init];
        if ([cacheHeader isKindOfClass:[UICollectionReusableView class]]) {
            cacheHeader.qlx_collectionView = self.collectionView;
            [self registerHeaderClass:headerClass indentifier:identifier];
            [self.cacheHeaderDic setObject:cacheHeader forKey:identifier];
        }else {
            QLXAssert(false, @"identifier is not a className");
        }
        
    }
    return cacheHeader;
}

- (void)registerSupplementaryViewIfNeedWithIdentifierClass:(Class) identifierClass kind:(NSString *)kind{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        [self registerHeaderClassIfNeedWithIdentifierClass:identifierClass];
    }else if([kind isEqualToString:UICollectionElementKindSectionFooter]){
        [self registerFooterClassIfNeedWithIdentifierClass:identifierClass];
    }
}

- (void)registerHeaderClassIfNeedWithIdentifierClass:(Class) identifierClass{
    if (identifierClass) {
        NSString * identifier = NSStringFromClass(identifierClass);
        UICollectionReusableView * cacheHeader = [self.cacheHeaderDic objectForKey:identifier];
        if (!cacheHeader) {
            Class headerClass = [self getRegisterHeaderOrFooterClassWithIdentifierClass:identifierClass];
            if (headerClass) {
                [self registerHeaderClass:headerClass indentifier:identifier];
                [self.cacheHeaderDic setObject:headerClass forKey:identifier];
            }else {
                QLXAssert(false, @"identifier is not a className");
            }
        }
    }
}


- (UICollectionReusableView *)getCacheFooterWithReuseIdentifierClass:(Class) identifierClass{
    if (!identifierClass) {
        return nil;
    }
    NSString * identifier = NSStringFromClass(identifierClass);
    UICollectionReusableView * cacheFooter = [self.cacheFooterDic objectForKey:identifier];
    if (!cacheFooter || ![cacheFooter isKindOfClass:[UICollectionReusableView class]]) {
        Class footerClass = [self getRegisterHeaderOrFooterClassWithIdentifierClass:identifierClass];
        cacheFooter = [[footerClass alloc] init];
        if ([cacheFooter isKindOfClass:[UICollectionReusableView class]]) {
            cacheFooter.qlx_collectionView = self.collectionView;
            [self registerFooterClass:footerClass indentifier:identifier];
            [self.cacheFooterDic setObject:cacheFooter forKey:identifier];
        }else {
            QLXAssert(false, @"identifier is not a className");
        }
    }
    return cacheFooter;
}

- (void)registerFooterClassIfNeedWithIdentifierClass:(Class) identifierClass{
    if (identifierClass) {
        NSString * identifier = NSStringFromClass(identifierClass);
        UICollectionReusableView * cacheFooter = [self.cacheFooterDic objectForKey:identifier];
        if (!cacheFooter) {
            Class footerClass = [self getRegisterHeaderOrFooterClassWithIdentifierClass:identifierClass];
            if (footerClass) {
                [self registerFooterClass:footerClass indentifier:identifier];
                [self.cacheFooterDic setObject:footerClass forKey:identifier];
            }else {
                QLXAssert(false, @"identifier is not a className");
            }
        }
    }
}

- (void)registerCellClass:(Class)cellClass{
    [self registerCellClass:cellClass indentifier:NSStringFromClass(cellClass)];
}

- (void)registerCellClass:(Class)cellClass indentifier:(NSString *)indentifier{
    QAssert(cellClass && indentifier);
    [self.collectionView registerClass:cellClass forCellWithReuseIdentifier:indentifier];
}

- (void)registerHeaderClass:(Class) headerClass{
    QAssert(headerClass);
    [self registerHeaderClass:headerClass indentifier:NSStringFromClass(headerClass)];
}

- (void)registerHeaderClass:(Class) headerClass indentifier:(NSString *)indentifier{
      [self.collectionView registerClass:headerClass forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:indentifier];
}


- (void)registerFooterClass:(Class) footerClass{
    QAssert(footerClass);
    [self registerFooterClass:footerClass indentifier:NSStringFromClass(footerClass)];
}

- (void)registerFooterClass:(Class) footerClass indentifier:(NSString *)indentifier{
     QAssert(footerClass && indentifier);
    [self.collectionView registerClass:footerClass forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:indentifier];
}




#pragma mark - private

- (NSObject *) warpDataWithView:(UIView *)view isCell:(BOOL)isCell{
    if ([view isKindOfClass:[UIView class]]) {
        static QLXWrapViewData * wrapData;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            wrapData = [QLXWrapViewData new];
        });
        wrapData.wrapType = isCell ? QLXWrapViewTypeCell : QLXWrapViewTypeHeaderOrFooter;
        wrapData.rootView = view;
        return wrapData;
    }
    return view;
}



- (NSObject *)getCellDataWithIndexPath:(NSIndexPath *)indexPath{
    QLXSectionData * sectionData = [self getSectionDataWithSection:indexPath.section];
    
    NSObject * cellData = nil;
    if (sectionData.cellDataList && indexPath.row < sectionData.cellDataList.count) {
        
         cellData = [sectionData.cellDataList objectAtIndex:indexPath.row];
        if ([cellData isKindOfClass:[UIView class]]) {
            cellData = [self warpDataWithView:(UIView *)cellData isCell:true];
        }
        if (cellData.qlx_resortEnable) {
            [self.collectionView qlx_initConfigForResort];
        }
    }
    return cellData;
}



- (NSObject *)getHeaderOrFooterDataWithKind:(NSString *)kind atSection:(NSUInteger)section{
    QLXSectionData * sectionData = [self getSectionDataWithSection:section];
    NSObject * data = nil;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        data = sectionData.headerData;
    }else if([kind isEqualToString:UICollectionElementKindSectionFooter]){
        data = sectionData.footerData;
    }
    if ([data isKindOfClass:[UIView class]]) {
        return [self warpDataWithView:(UIView *)data isCell:false];
    }
    return data;
}


#pragma mark private

/**
   get  secionData  in section index
 */

- (QLXSectionData *)getSectionDataWithSection:(NSUInteger)section{
    if (section < self.sectionDataList.count ) {
        return [self.sectionDataList objectAtIndex:section];
    }
    return nil;
}

- (CGSize)safeSize:(CGSize)size{
    if (size.width >= 0.01f && size.height >= 0.01f) {
        return size;
    }else {
        return CGSizeMake(fmax(0.01f, size.width), fmax(0.01f, size.height));
    }
}


#pragma mark -getter

- (NSArray *)sectionDataList{
    if ([self.delegate respondsToSelector:@selector(qlx_sectionDataListWithCollectionView:)]) {
        return [self.delegate qlx_sectionDataListWithCollectionView:self.collectionView];
    }
    return @[];
}









@end
