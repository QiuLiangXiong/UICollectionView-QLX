//
//  NSObject+View.h
//  UICollectionView+QLXDemo
//
//  Created by QLX on 16/9/6.
//  Copyright © 2016年 QLX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"
#import "QLXDiffUtil.h"


@interface NSObject(QLXView)<QLXDiffable>

/**
 *  数据映射绑定视图的类名  不能为空
 */
@property(nonatomic , assign ,nonnull) Class  qlx_reuseIdentifierClass;

@property (nonatomic, assign) CGFloat qlx_viewHeight;
@property (nonatomic, assign) CGFloat qlx_viewWidth;

/**
 * 仅对 header footer data  生效
 */

@property(nonatomic , assign) UIEdgeInsets qlx_secionInset;
@property(nonatomic , assign) CGFloat qlx_minimumLineSpacing;
@property(nonatomic , assign) CGFloat qlx_minimumInteritemSpacing;


/**
 * view的高度或者宽度变化了 请用这个函数调用下
 */
- (void)qlx_viewSizeChanged;


@end
