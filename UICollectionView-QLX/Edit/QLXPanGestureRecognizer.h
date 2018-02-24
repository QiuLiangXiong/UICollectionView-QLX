//
//  QLXPanGestureRecognizer.h
//  FunPoint
//
//  Created by QLX on 15/12/15.
//  Copyright © 2015年 com.fcuh.funpoint. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, QLXPanGestureRecognizerDirection) {
    QLXPanGestureRecognizerDirectionRight       = 1 << 1,   // 右边
    QLXPanGestureRecognizerDirectionLeft        = 1 << 2,   // 左边
    QLXPanGestureRecognizerDirectionUp          = 1 << 3,   // 向上
    QLXPanGestureRecognizerDirectionDown        = 1 << 4,   // 向下
    QLXPanGestureRecognizerDirectionHorizontal  = (1 << 1)|(1<<2),  // 横向
    QLXPanGestureRecognizerDirectionVertical    = (1 << 3)|(1 << 4),  // 纵向
};

@protocol QLXPanGestureRecognizerDelegate;

@interface QLXPanGestureRecognizer : UIPanGestureRecognizer

@property(nonatomic , assign ) QLXPanGestureRecognizerDirection direction;    // 拖动方向 默认全方向

//  刚拖动的时候的初始方向加速度  可以根据这个来识别方向
//    velocityWhenBegin.x < 0  手指向左滑 y < 0 手指向上滑  是不是水平方向的判断方式  fabs(x) > fabs(y);
@property(nonatomic , assign , readonly) CGPoint velocityWhenBegin;

@property(nonatomic , weak) id<QLXPanGestureRecognizerDelegate> panDelegate;

@property(nonatomic , weak) UIView * targetView ; // 在这个view下滑动
@property(nonatomic , assign) CGPoint translation;  // 在targetView 中的拖动偏移量
@property(nonatomic , assign) CGPoint velocity;  // 在targetView 中的拖动加速度
@property(nonatomic , assign) BOOL paning;       // 是否在拖动中

-(BOOL) isHorizontalWhenBegin;//刚开始拖动的时候 是不是水平方向

-(BOOL) isLeftWhenBegin;//刚开始拖动的时候 是不是向左滑



@end

@protocol QLXPanGestureRecognizerDelegate <UIGestureRecognizerDelegate>

@optional

/**
 *  是否开始接受这个触摸  用于解决手势冲突
 *
 *  @param gestureRecognizer
 *  @param veloctiy          veloctiy提供加速度来判断拖动初始方向
 *
 *  @return 是否接受这个触摸
 */
- (BOOL)gestureRecognizer:(QLXPanGestureRecognizer *)gestureRecognizer shouldBeginWithVelocity:(CGPoint) veloctiy;

@end

