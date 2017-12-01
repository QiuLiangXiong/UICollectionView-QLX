//
//  QLXPanGestureRecognizer.m
//  FunPoint
//
//  Created by QLX on 15/12/15.
//  Copyright © 2015年 com.fcuh.funpoint. All rights reserved.
//

#import "QLXPanGestureRecognizer.h"

@interface QLXPanGestureRecognizer()<UIGestureRecognizerDelegate>



@end

@implementation QLXPanGestureRecognizer


-(instancetype)initWithTarget:(id)target action:(SEL)action{
    self = [super initWithTarget:target action:action];
    if (self) {
        self.direction = QLXPanGestureRecognizerDirectionVertical | QLXPanGestureRecognizerDirectionVertical;  // 默认全方向
        self.delegate = self;
    }
    return self;
}

-(instancetype)init{
    self = [super init];
    if (self) {
        self.direction = QLXPanGestureRecognizerDirectionVertical | QLXPanGestureRecognizerDirectionVertical;  // 默认全方向
        self.delegate = self;
    }
    return self;
}

-(void)setDelegate:(id<UIGestureRecognizerDelegate>)delegate{
    if (delegate != self) {
        self.panDelegate = (id<QLXPanGestureRecognizerDelegate>)delegate;
    }else {
        [super setDelegate:delegate];
    }
}


-(BOOL)paning{
    if (self.state == UIGestureRecognizerStateBegan || self.state == UIGestureRecognizerStateChanged) {
        return true;
    }
    return false;
}

-(void)setTargetView:(UIView *)targetView{
    if (_targetView != targetView) {
        [_targetView removeGestureRecognizer:self];
        _targetView = targetView;
    }
}


-(CGPoint)velocity{
    assert(self.targetView);// 触摸目标未设置
    return [self velocityInView:self.targetView];
}


-(CGPoint)translation{
    assert(self.targetView);// 触摸目标未设置
    return [self translationInView:self.targetView];
}


-(BOOL)isHorizontalWhenBegin{
    return fabs(self.velocityWhenBegin.x) >= fabs(self.velocityWhenBegin.y);
}

-(BOOL)isLeftWhenBegin{
    return self.velocityWhenBegin.x <= 0;
}

-(BOOL)  shouldBeginByDirection{
    CGPoint velocity = self.velocityWhenBegin;
    switch (self.direction) {
        case QLXPanGestureRecognizerDirectionUp:
            return fabs(velocity.x) <= fabs(velocity.y) && velocity.y < 0 ;
        case QLXPanGestureRecognizerDirectionDown:
            return fabs(velocity.x) <= fabs(velocity.y) && velocity.y > 0 ;
        case QLXPanGestureRecognizerDirectionLeft:
            return fabs(velocity.x) >= fabs(velocity.y) && velocity.x < 0 ;
        case QLXPanGestureRecognizerDirectionRight:
            return fabs(velocity.x) >= fabs(velocity.y) && velocity.x > 0 ;
        case QLXPanGestureRecognizerDirectionHorizontal:
            return fabs(velocity.x) >= fabs(velocity.y);
        case QLXPanGestureRecognizerDirectionVertical:
            return fabs(velocity.x) <= fabs(velocity.y);
        default:
            return true;
    }
    return  true;
}

-(void) refreshVelocityWhenBegin{
    CGPoint velocity = self.velocity;
    if (velocity.x == 0 && velocity.y == 0) {
        velocity = self.translation;
    }
    _velocityWhenBegin = velocity;
}


#pragma mark UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    [self refreshVelocityWhenBegin];
    BOOL result = true;
    _velocityWhenBegin = self.velocity;
    if ([self.panDelegate respondsToSelector:@selector(gestureRecognizerShouldBegin:)]) {
        result = [self.panDelegate gestureRecognizerShouldBegin:gestureRecognizer];
    }
    if ([self.panDelegate respondsToSelector:@selector(gestureRecognizer:shouldBeginWithVelocity:)]) {
        result = [self.panDelegate gestureRecognizer:self shouldBeginWithVelocity:self.velocityWhenBegin];
    }
    if (result) {
        result =  [self shouldBeginByDirection];
    }
    return result;
}

// called when the recognition of one of gestureRecognizer or otherGestureRecognizer would be blocked by the other
// return YES to allow both to recognize simultaneously. the default implementation returns NO (by default no two gestures can be recognized simultaneously)
//
// note: returning YES is guaranteed to allow simultaneous recognition. returning NO is not guaranteed to prevent simultaneous recognition, as the other gesture's delegate may return YES
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    if ([self.panDelegate respondsToSelector:@selector(gestureRecognizer:shouldRecognizeSimultaneouslyWithGestureRecognizer:)]) {
        return [self.panDelegate gestureRecognizer:gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:otherGestureRecognizer];
    }
    return false;
}

// called once per attempt to recognize, so failure requirements can be determined lazily and may be set up between recognizers across view hierarchies
// return YES to set up a dynamic failure requirement between gestureRecognizer and otherGestureRecognizer
//
// note: returning YES is guaranteed to set up the failure requirement. returning NO does not guarantee that there will not be a failure requirement as the other gesture's counterpart delegate or subclass methods may return YES
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if ([self.panDelegate respondsToSelector:@selector(gestureRecognizer:shouldRequireFailureOfGestureRecognizer:)]) {
        return [self.panDelegate gestureRecognizer:gestureRecognizer shouldRequireFailureOfGestureRecognizer:otherGestureRecognizer];
    }
    return false;
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if ([self.panDelegate respondsToSelector:@selector(gestureRecognizer:shouldBeRequiredToFailByGestureRecognizer:)]) {
        return [self.panDelegate gestureRecognizer:gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:otherGestureRecognizer];
    }
    return false;
}

// called before touchesBegan:withEvent: is called on the gesture recognizer for a new touch. return NO to prevent the gesture recognizer from seeing this touch
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if ([self.panDelegate respondsToSelector:@selector(gestureRecognizer:shouldReceiveTouch:)]) {
        return [self.panDelegate gestureRecognizer:gestureRecognizer shouldReceiveTouch:touch];
    }
    return true;
}

// called before pressesBegan:withEvent: is called on the gesture recognizer for a new press. return NO to prevent the gesture recognizer from seeing this press
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceivePress:(UIPress *)press{
    if ([self.panDelegate respondsToSelector:@selector(gestureRecognizer:shouldReceivePress:)]) {
        return [self.panDelegate gestureRecognizer:gestureRecognizer shouldReceivePress:press];
    }
    return true;
}




@end
