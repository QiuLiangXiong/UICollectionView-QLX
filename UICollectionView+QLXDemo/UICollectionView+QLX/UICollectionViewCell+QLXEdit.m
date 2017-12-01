//
//  UICollectionViewCell+QLXEdit.m
//  UICollectionView+QLXDemo
//
//  Created by QLX on 2017/11/30.
//  Copyright © 2017年 QLX. All rights reserved.
//

#import "UICollectionViewCell+QLXEdit.h"
#import <objc/runtime.h>
#import "QLXPanGestureRecognizer.h"

#define QEidtMaxBouncesLength   100

//--------------------- 类分割线  ------------------ //

@interface UIView(QEdit)

@property(nonatomic , assign) CGFloat q_originWidth;

- (UIView *)qlx_hitTest:(CGPoint)point withEvent:(UIEvent *)event defaultView:(UIView *)view;

+ (void)openQLXEdit;


@end

@implementation UIView(QEdit)


+ (void) openQLXEdit;{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleSelector:@selector(hitTest:withEvent:) withSelector:@selector(_qlx_hitTest:withEvent:)];
    });
}



- (UIView *)_qlx_hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView * view = [self _qlx_hitTest:point
                             withEvent:event];
    return [self qlx_hitTest:point withEvent:event defaultView:view];
}


- (UIView *)qlx_hitTest:(CGPoint)point withEvent:(UIEvent *)event defaultView:(UIView *)view{
    

    
    return view;
}



- (CGFloat)q_originWidth{
    NSNumber * value = objc_getAssociatedObject(self, @selector(q_originWidth));
    return [value floatValue];
}

- (void)setQ_originWidth:(CGFloat)q_originWidth{
       objc_setAssociatedObject(self, @selector(q_originWidth), @(q_originWidth), OBJC_ASSOCIATION_RETAIN);
}

+ (void)swizzleSelector:(SEL)originalSelector withSelector:(SEL)swizzledSelector {
    Class class = [self class];
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    method_exchangeImplementations(originalMethod, swizzledMethod);
}


@end

//--------------------- 类分割线  ------------------ //

@interface UICollectionView(QLXEdit)

@end
@implementation UICollectionView(QLXEdit)

- (UIView *)qlx_hitTest:(CGPoint)point withEvent:(UIEvent *)event defaultView:(UIView *)view{
    if (view) {
        if ([self isKindOfClass:[UICollectionView class]]) {
            NSArray * cells = [self visibleCells];
            for (UICollectionViewCell * cell in cells) {
                if (cell.qlx_leftEidtView || cell.qlx_rightEidtView) {
                    
                    BOOL isEidtView = false;
                    for (UIView * sub = view; sub ; sub = sub.superview) {
                        if ([sub isKindOfClass:[UICollectionView class]] || [sub isKindOfClass:[UICollectionViewCell class]]) {
                            break;
                        }
                        if (sub == cell.qlx_leftEidtView || sub == cell.qlx_rightEidtView) {
                            isEidtView = true;
                        }
                    }
                    if (!isEidtView) {
                       [cell qlx_finishEditWithAnimated:true];//根据需要去结束编辑状态
                    }
                    
                    
                }

            }
        }
    }
    return view;
}


@end


//--------------------- 类分割线  ------------------ //


@interface UICollectionViewCell()<QLXPanGestureRecognizerDelegate>

@property(nonatomic , assign) CGPoint  qlx_lastPanTranslation;

@end

@implementation UICollectionViewCell(QLXEdit)



#pragma mark - publick
- (void)qlx_finishEditWithAnimated:(BOOL)animated{
    CGFloat  x = self.contentView.frame.origin.x;
    if (x != 0) {
        self.qlx_lastPanTranslation = CGPointZero;
        if (animated) {
            [UIView animateWithDuration:0.22 animations:^{
                [self _handlerPanWithTranslation:CGPointMake(-x, 0)];
                [self.qlx_leftEidtView layoutIfNeeded];
                [self.qlx_rightEidtView layoutIfNeeded];
            }];
        }else {
            [UIView performWithoutAnimation:^{
                [self _handlerPanWithTranslation:CGPointMake(-x, 0)];
            }];
        }
        
    }


}

- (BOOL)qlx_isEditing{
    return self.contentView.frame.origin.x != 0 ;
}

- (void)qlx_openRightEditView{
    [self scrollToRightView];
}
- (void)qlx_openLeftEditView{
    [self scrollToLeftView];
}


#pragma mark - getter/setter


- (CGPoint)qlx_lastPanTranslation{
    NSValue * value = objc_getAssociatedObject(self, @selector(qlx_lastPanTranslation));
    return [value CGPointValue];
}

- (void)setQlx_lastPanTranslation:(CGPoint)qlx_lastPanTranslation{

     objc_setAssociatedObject(self, @selector(qlx_lastPanTranslation),[NSValue valueWithCGPoint:qlx_lastPanTranslation], OBJC_ASSOCIATION_RETAIN);
}

- (UIView *)qlx_leftEidtView{
    return objc_getAssociatedObject(self, @selector(qlx_leftEidtView));
}

- (void)setQlx_leftEidtView:(UIView *)qlx_leftEidtView{
    if (qlx_leftEidtView && ![qlx_leftEidtView isKindOfClass:[UIView class]]) {
        NSAssert(false, @"qlx_leftEidtView should be UIView Class instance");
    }
    if (self.qlx_leftEidtView != qlx_leftEidtView) {
        [self setClipsToBounds:true];
        [self.qlx_leftEidtView removeFromSuperview];
        if (qlx_leftEidtView) {
            [qlx_leftEidtView removeFromSuperview];
            [self insertSubview:qlx_leftEidtView atIndex:0];
            if (self.contentView.backgroundColor == nil) {
                self.contentView.backgroundColor = self.backgroundColor ? : [UIColor whiteColor];
                if (self.backgroundColor == nil) {
                    NSLog(@"UICollectionViewCell(QLXEdit) setQlx_rightEidtView give the     cell's contentView bgcolor a default white color");
                    self.backgroundColor = self.contentView.backgroundColor;
                }
            }
        }
    }
    objc_setAssociatedObject(self, @selector(qlx_leftEidtView), qlx_leftEidtView, OBJC_ASSOCIATION_RETAIN);
    [self _updatePanGestureRecognizer];
}

- (UIView *)qlx_rightEidtView{
    return objc_getAssociatedObject(self, @selector(qlx_rightEidtView));
}

- (void)setQlx_rightEidtView:(UIView *)qlx_rightEidtView{
    if (qlx_rightEidtView && ![qlx_rightEidtView isKindOfClass:[UIView class]]) {
        NSAssert(false, @"qlx_rightEidtView should be UIView Class instance");
    }
    if (self.qlx_rightEidtView != qlx_rightEidtView) {
        [self.qlx_rightEidtView removeFromSuperview];
        if (qlx_rightEidtView) {
            [self setClipsToBounds:true];
            [qlx_rightEidtView removeFromSuperview];

            [self insertSubview:qlx_rightEidtView atIndex:0];
            if (self.contentView.backgroundColor == nil) {
                self.contentView.backgroundColor = self.backgroundColor ? : [UIColor whiteColor];
                if (self.backgroundColor == nil) {
                    NSLog(@"UICollectionViewCell(QLXEdit) setQlx_rightEidtView give the cell's contentView bgcolor a  default white color");
                    self.backgroundColor = self.contentView.backgroundColor;
                }
            }
        }
        
    }
    objc_setAssociatedObject(self, @selector(qlx_rightEidtView), qlx_rightEidtView, OBJC_ASSOCIATION_RETAIN);
    
    [self _updatePanGestureRecognizer];
}




#pragma mark - QLXPanGestureRecognizerDelegate imple

- (BOOL)gestureRecognizer:(QLXPanGestureRecognizer *)gestureRecognizer shouldBeginWithVelocity:(CGPoint)veloctiy{
    if (self.qlx_leftEidtView == nil && veloctiy.x > 0) {   // 没有左边编辑视图  一开始不允许左滑
        return false;
    }
    if (self.qlx_rightEidtView == nil && veloctiy.x < 0) {
        return false;
    }
    return true;
}


#pragma mark - pan callback

- (void)onPanGestureRecognizer:(QLXPanGestureRecognizer *)panGR{
    
     CGPoint point = panGR.translation;
    UIGestureRecognizerState status = panGR.state;
    if (status == UIGestureRecognizerStateBegan) {
        self.qlx_lastPanTranslation = CGPointZero;
         [self _handlerPanWithTranslation:point];
    }else if (status == UIGestureRecognizerStateChanged) {
         [self _handlerPanWithTranslation:point];
    }else {
        //手指离开    ->  去归位到合适的位置
         [self _handlerPanWithTranslation:point];
        
        
        CGFloat leftViewWidth = [self _getOriginWidthView:self.qlx_leftEidtView];
        CGFloat rightViewWidth = [self _getOriginWidthView:self.qlx_rightEidtView];
        CGFloat x = self.contentView.frame.origin.x;
        CGPoint velocity = panGR.velocity;
        //位置和加速度来判断归位位置
        
        if (velocity.x >= 0) {
            
            if ((velocity.x >= 300 && x > 20)||(x > 50)) {
                [self scrollToLeftView];
            }else {
                
                if ((velocity.x < 300)  && self.qlx_rightEidtView && x < - rightViewWidth * 0.5) {
                    [self scrollToRightView];
                }else {
                    [self scrollToCenter];
                }
            }
        }else {
            if ((velocity.x < -300 && x < -20)||(x < -50)) {
                [self scrollToRightView];
            }else {
                if ((velocity.x > -300)  && self.qlx_leftEidtView && x >=  leftViewWidth * 0.5) {
                    [self scrollToLeftView];
                }else {
                    [self scrollToCenter];
                }
            }
           
        }
        
    }
   
   
    
    self.qlx_lastPanTranslation = point;
    
    
    
}

- (void) scrollToLeftView{
     CGFloat leftViewWidth = [self _getOriginWidthView:self.qlx_leftEidtView];
    if (leftViewWidth > 0) {
        CGFloat x = self.contentView.frame.origin.x;
        CGFloat length = fabs(leftViewWidth - x);
        [UIView animateWithDuration:0.15 + 0.2 * fmin(1, length / leftViewWidth) animations:^{
            [self handlerViewLayoutWithContentViewX:leftViewWidth];
            [self.qlx_leftEidtView layoutIfNeeded];
            [self.qlx_rightEidtView layoutIfNeeded];
        }];
    }else {
        [self scrollToCenter];
    }
    
}

- (void) scrollToRightView{
    CGFloat rightViewWidth = [self _getOriginWidthView:self.qlx_rightEidtView];
    if (rightViewWidth > 0) {
        CGFloat x = self.contentView.frame.origin.x;
        CGFloat length = fabs(rightViewWidth + x);
        [UIView animateWithDuration:0.15 + 0.2 * fmin(1, length / rightViewWidth) animations:^{
            [self handlerViewLayoutWithContentViewX:-rightViewWidth];
            [self.qlx_leftEidtView layoutIfNeeded];
            [self.qlx_rightEidtView layoutIfNeeded];
        }];
    }else {
        [self scrollToCenter];
    }
    
}



- (void)scrollToCenter{
    CGFloat x = self.contentView.frame.origin.x;
    CGFloat length = fabs(0 - x);
    CGFloat leftViewWidth = [self _getOriginWidthView:self.qlx_leftEidtView];
    CGFloat rightViewWidth = [self _getOriginWidthView:self.qlx_rightEidtView];
    
    CGFloat defaultLength = leftViewWidth ? :rightViewWidth;
    if (defaultLength == 0) {
        defaultLength = QEidtMaxBouncesLength;
    }
    
    [UIView animateWithDuration:0.15 + 0.2 * fmin(1, length / defaultLength) animations:^{
        [self handlerViewLayoutWithContentViewX:0];
        [self.qlx_leftEidtView layoutIfNeeded];
        [self.qlx_rightEidtView layoutIfNeeded];
    }];
}





#pragma mark - private

- (void) _updatePanGestureRecognizer{
    if (self.qlx_leftEidtView || self.qlx_rightEidtView) {
        //添加手势
        QLXPanGestureRecognizer * panGR = [self _getPanGestureRecognizer];
        if (!panGR) {
            panGR = [[QLXPanGestureRecognizer alloc] initWithTarget:self action:@selector(onPanGestureRecognizer:)];
            panGR.panDelegate = self;
            panGR.targetView = self;
            panGR.direction = QLXPanGestureRecognizerDirectionHorizontal;
            [self addGestureRecognizer:panGR];
        }
        self.userInteractionEnabled = true;
        
    }else {
        //移除手势
        QLXPanGestureRecognizer * panGR = [self _getPanGestureRecognizer];
        if (panGR) {
            [self removeGestureRecognizer:panGR];
        }
        
    }
    [UIView openQLXEdit];
}


- (void)_handlerPanWithTranslation:(CGPoint)translation{
    CGPoint point = translation;
    CGPoint lastPoint = self.qlx_lastPanTranslation;
    CGPoint offset = CGPointMake(point.x - lastPoint.x, point.y - lastPoint.y);
    CGSize size = self.frame.size;
    
    
    

    CGFloat x = self.contentView.frame.origin.x;

    
    // 应该限制一下x
    
    CGFloat offsetX = offset.x;
    CGFloat leftViewWidth = [self _getOriginWidthView:self.qlx_leftEidtView];
    CGFloat rightViewWidth = [self _getOriginWidthView:self.qlx_rightEidtView];
    if (offset.x >= 0) {
        if (leftViewWidth -x <= 0) {
            offsetX = fmin(offsetX * 0.6, 6) ;
        }else {
            if (x + offset.x > leftViewWidth) {
                x = leftViewWidth;
                offsetX = fmin(offsetX * 0.6, 6) ;
            }
        }
        x = x + offsetX;
    }else {
        CGFloat rightMargin = size.width - CGRectGetMaxX(self.contentView.frame);
        if (rightViewWidth - rightMargin <= 0) {
            offsetX = fmax(offsetX * 0.6, -6) ;
        }else {
            if (rightMargin + fabs(offset.x) > rightViewWidth) {
                x = -rightViewWidth;
                offsetX = fmax(offsetX * 0.6, -6) ;
            }
        }
          x = x + offsetX;
    }
    x = fmin(x, leftViewWidth + QEidtMaxBouncesLength);
    x = fmax(x, -(rightViewWidth + QEidtMaxBouncesLength));

    [self handlerViewLayoutWithContentViewX:x];
   
}

- (void)handlerViewLayoutWithContentViewX:(CGFloat)x{
    CGSize size = self.contentView.frame.size;
    self.contentView.frame = CGRectMake(x, 0, size.width, size.height);
    

    
    if (self.qlx_leftEidtView ) {
        CGFloat width = [self _getOriginWidthView:self.qlx_leftEidtView];
        CGFloat adjustWidth = CGRectGetMinX(self.contentView.frame);
        if (adjustWidth > width + QEidtMaxBouncesLength) {
            //            adjustWidth = width + QEidtMaxBouncesLength;
        }else if(adjustWidth < width){
            adjustWidth = width;
        }
        self.qlx_leftEidtView.frame = CGRectMake(0, 0, adjustWidth, size.height);
    }
    if (self.qlx_rightEidtView) {
        CGFloat width = [self _getOriginWidthView:self.qlx_rightEidtView];
        CGFloat adjustX = CGRectGetMaxX(self.contentView.frame);
        if (adjustX >= size.width - width) {
            adjustX = size.width - width;
        }else if(adjustX < (size.width - width - QEidtMaxBouncesLength)){
            //            adjustX = size.width - width - QEidtMaxBouncesLength;
        }
        self.qlx_rightEidtView.frame = CGRectMake(adjustX, 0, size.width - adjustX, size.height);
    }
    
    if (!self.contentView.translatesAutoresizingMaskIntoConstraints) {
        self.contentView.translatesAutoresizingMaskIntoConstraints = true;
    }
    if (self.contentView.backgroundColor != self.backgroundColor) {
        self.backgroundColor = self.contentView.backgroundColor;
    }
}



- (QLXPanGestureRecognizer *)_getPanGestureRecognizer{
    for (UIGestureRecognizer * gr in self.gestureRecognizers) {
        if ([gr isKindOfClass:[QLXPanGestureRecognizer class]]) {
            return (QLXPanGestureRecognizer *)gr;
        }
    }
    return nil;
}

- (CGFloat)_getOriginWidthView:(UIView *)view{

    if (view && view.q_originWidth <= 0) {
        CGFloat width = 0;
        if (view.frame.size.width > 0) {
            width = view.frame.size.width;
        }else {
            view.frame = CGRectMake(0, 0, 0, self.frame.size.height);
            CGSize  comproessedSize = [view systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
            width = comproessedSize.width;
        }
        NSAssert(width != 0, @"编辑视图宽度未设置");
        view.q_originWidth = width;
    }
    return view ? view.q_originWidth : 0;
    
}



@end
