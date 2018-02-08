//
//  UICollectoinView+QLXTransitonAnimation.h
//  UICollectionView+QLXDemo
//
//  Created by QLX on 2017/12/2.
//  Copyright © 2017年 QLX. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,QLXTransitonAnimationType){
    QLXTransitonAnimationTypeNone,
    QLXTransitonAnimationTypeDefault,
};


@interface UICollectionView(QLXTransitonAnimation)

/*
 *批量更新 带过渡动画类型(主线程使用)
 */

- (void)qlx_performBatchUpdates:(void (^)(void))updates withAnimated:(QLXTransitonAnimationType)type completion:(void (^)(BOOL))completion;

@end
