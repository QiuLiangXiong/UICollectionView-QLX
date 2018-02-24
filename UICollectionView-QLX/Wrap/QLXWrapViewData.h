//
//  QLXWrapViewData.h
//  UICollectionView+QLXDemo
//
//  Created by QLX on 2017/11/5.
//  Copyright © 2017年 QLX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,QLXWrapViewType){
    QLXWrapViewTypeCell,
    QLXWrapViewTypeHeaderOrFooter,
};



@interface QLXWrapViewData : NSObject

@property(nonatomic , assign) QLXWrapViewType wrapType;

@property(nonatomic , weak) UIView * rootView;

@end
