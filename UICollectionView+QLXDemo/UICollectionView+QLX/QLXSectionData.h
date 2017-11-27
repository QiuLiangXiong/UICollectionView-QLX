//
//  QLXSectionData.h
//  UICollectionView+QLXDemo
//
//  Created by QLX on 2017/11/27.
//  Copyright © 2017年 QLX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QLXDiffUtil.h"

@interface QLXSectionData : NSObject<QLXDiffable>

@property (nonatomic, strong) NSArray<NSObject *> * cellDataList;
@property (nonatomic, strong) NSObject * headerData;
@property (nonatomic, strong) NSObject * footerData;
@property (nonatomic, strong) Class decorationData;

@end
