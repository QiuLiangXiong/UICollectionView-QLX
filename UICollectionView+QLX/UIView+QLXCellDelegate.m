//
//  UICollectionViewCell+QLX.m
//  UICollectionView+QLXDemo
//
//  Created by QLX on 16/9/7.
//  Copyright © 2016年 QLX. All rights reserved.
//

#import "UIView+QLXCellDelegate.h"
#import <objc/runtime.h>

@implementation UIView(QLXCellDelegate)

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [[UICollectionReusableView class] swizzleSelector:@selector(prepareForReuse) withSelector:@selector(qlx_sw_prepareForReuse)];
    });
}

- (void)qlx_sw_prepareForReuse{
    [self qlx_sw_prepareForReuse];
    [self qlx_prepareForReuse];
}

- (void)qlx_prepareForReuse{
    
}

- (void)qlx_didSelectCell{
    
}

- (void)qlx_didDeselectCell{
    
}

- (void)qlx_willDisplayCell{
    
}

- (void)qlx_didEndDisplayingCell{
    
}

- (BOOL)qlx_shouldSelectCell{
    return true;
}

- (BOOL)qlx_shouldDeselectCell{
    return true;
}

- (BOOL)qlx_shouldHighlightCell{
    return true;
}

- (void)qlx_didHighlightCell{
    
}

- (void)qlx_didUnhighlightCell{
    
}

+ (void)swizzleSelector:(SEL)originalSelector withSelector:(SEL)swizzledSelector {
    Class class = [self class];
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    method_exchangeImplementations(originalMethod, swizzledMethod);
}


@end
