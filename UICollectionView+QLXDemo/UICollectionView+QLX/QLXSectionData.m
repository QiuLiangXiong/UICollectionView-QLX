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
#import "NSObject+View.h"
@implementation QLXSectionData

@synthesize decorationData = _decorationData;


- (void)setHeaderData:(NSObject *)headerData{
    if (headerData) {
        QLXAssert(![headerData isKindOfClass:[NSArray class]], @"headerData 不应是数组");
        if (![headerData isKindOfClass:[UIView class]] && ![headerData qlx_reuseIdentifierClass]) {
            QLXAssert(false, @"headerData 没有实现 qlx_reuseIdentifierClass方法");
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
            QLXAssert(false, @"footerData 没有实现 qlx_reuseIdentifierClass方法");
        }
    }
    if (_footerData != footerData) {
        _footerData = footerData;
    }
}

- (void)setCellDataList:(NSArray<NSObject *> *)cellDataList{
    
    if (cellDataList) {
        QLXAssert([cellDataList isKindOfClass:[NSArray class]], @"cellDataList must be NSArray")
        NSObject * firstObject = cellDataList.count ? cellDataList.firstObject : nil;
        QLXAssert(![firstObject isKindOfClass:[NSArray class]], @"cellDataList 元素不应含有数组")
        if (firstObject && ![firstObject isKindOfClass:[UIView class]] && ![firstObject qlx_reuseIdentifierClass]) {
            QLXAssert(false, @"firstObject 没有实现 qlx_reuseIdentifierClass方法");
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


#pragma mark - QLXDiffable implementation

- (BOOL)qlx_isEqualToObject:(id<QLXDiffable>)object{
    if ([object isKindOfClass:[QLXSectionData class]]) {
        QLXSectionData *controller = (QLXSectionData *)object;
        BOOL headerEqual = (self.headerData && controller.headerData && self.headerData == controller.headerData) || (!self.headerData && !controller.headerData);
        BOOL footerEqual = (self.footerData && controller.footerData && self.footerData == controller.footerData) || (!self.footerData && !controller.footerData);
        BOOL cellEqual = self.cellDataList && controller.cellDataList && self.cellDataList.count == controller.cellDataList.count;
        if (cellEqual) {
            for (int i = 0; i < self.cellDataList.count; i ++) {
                if (self.cellDataList[i] != controller.cellDataList[i]) {
                    cellEqual = NO;
                    break;
                }
            }
        } else {
            cellEqual = !self.cellDataList && controller.cellDataList;
        }
        
        return headerEqual && footerEqual && cellEqual;
    } else {
        return NO;
    }
}




@end
