//
//  QLXSectionData.m
//  UICollectionView+QLXDemo
//
//  Created by QLX on 2017/11/27.
//  Copyright © 2017年 QLX. All rights reserved.
//

#import "QLXSectionData.h"
#import <UIKit/UIKit.h>
#import "QMacros.h"
#import "NSObject+QLXView.h"
@implementation QLXSectionData

@synthesize decorationData = _decorationData;
@synthesize cellDataList = _cellDataList;
@synthesize headerData = _headerData;


- (void)setHeaderData:(NSObject *)headerData{
    if (headerData) {
        QLXAssert(![headerData isKindOfClass:[NSArray class]], @"headerData 不应是数组");
        if (![headerData isKindOfClass:[UIView class]] && ![headerData qlx_reuseIdentifierClass]) {
            QLXAssert(false, @"headerData  qlx_reuseIdentifierClass不应为空");
        }
    }
    if (_headerData != headerData ) {
        _headerData = headerData;
    }
}

- (void)setFooterData:(NSObject *)footerData{
    if (footerData) {
        QLXAssert(![footerData isKindOfClass:[NSArray class]], @"footerData 不应是数组");
        if (![footerData isKindOfClass:[UIView class]] && ![footerData qlx_reuseIdentifierClass]) {
            QLXAssert(false, @"footerData qlx_reuseIdentifierClass不应为空");
        }
    }
    if (_footerData != footerData) {
        _footerData = footerData;
    }
}

- (void)setCellDataList:(NSMutableArray<NSObject *> *)cellDataList{
    
    if (cellDataList) {
        QLXAssert([cellDataList isKindOfClass:[NSMutableArray class]], @"cellDataList must be NSMutableArray")
        NSObject * firstObject = cellDataList.count ? cellDataList.firstObject : nil;
        QLXAssert(![firstObject isKindOfClass:[NSArray class]], @"cellDataList 元素不应含有数组")
        if (firstObject && ![firstObject isKindOfClass:[UIView class]] && ![firstObject qlx_reuseIdentifierClass]) {
            QLXAssert(false, @"firstObject qlx_reuseIdentifierClass不应为空");
        }
    }
    
    if (_cellDataList != cellDataList) {
        _cellDataList = cellDataList;
    }
}


- (void)setDecorationData:(Class)decorationData{
    if (decorationData && ![decorationData isSubclassOfClass:[UICollectionReusableView class]]) {
         QLXAssert(false, @"decorationData 必须是 UICollectionReusableView 的子类");
    }
    _decorationData = decorationData;
}

- (Class)decorationData{
    if (!_decorationData) {
        return [UICollectionReusableView class];
    }
    return _decorationData;
}


#pragma mark - getter

- (NSMutableArray<NSObject *> *)cellDataList{
    if (!_cellDataList) {
        _cellDataList = [NSMutableArray new];
    }
    return _cellDataList;
}


- (NSObject *)headerData{
    if (!_headerData) {
        if (_cellDataList.count == 0 && _footerData == nil) {
            NSObject * object = [NSObject new];
            object.qlx_reuseIdentifierClass = [UICollectionReusableView class];
            object.qlx_viewWidth = 0.01;
            object.qlx_viewHeight = 0.01;
            _headerData = object;
        }
    }
    return _headerData;
}


#pragma mark - QLXDiffable implementation

- (BOOL)qlx_isEqualToObject:(id<QLXDiffable>)object{
    if ([object isKindOfClass:[QLXSectionData class]]) {
        QLXSectionData *controller = (QLXSectionData *)object;
        BOOL headerEqual =  (self.headerData && controller.headerData && [self.headerData qlx_isEqualToObject:controller.headerData]) || (!self.headerData && !controller.headerData);
        BOOL footerEqual = (self.footerData && controller.footerData && [self.footerData qlx_isEqualToObject:controller.footerData]) || (!self.footerData && !controller.footerData);
        
        BOOL decorationEqual = self.decorationData = controller.decorationData;
        
        BOOL cellEqual =  self.cellDataList.count == controller.cellDataList.count;
        if (cellEqual) {
            for (int i = 0; i < self.cellDataList.count; i ++) {
                if (![self.cellDataList[i] qlx_isEqualToObject:controller.cellDataList[i]]) {
                    cellEqual = NO;
                    break;
                }
            }
        }
        return headerEqual && footerEqual && cellEqual && decorationEqual;
    } else {
        return NO;
    }
}




@end
