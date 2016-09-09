//
//  NSObject+View.m
//  UICollectionView+QLXDemo
//
//  Created by QLX on 16/9/6.
//  Copyright © 2016年 QLX. All rights reserved.
//

#import "NSObject+View.h"
#import <objc/runtime.h>
#import "QMacros.h"


@implementation NSObject(View)

#pragma mark - publick

-(void)qlx_viewSizeChanged{
    self.qlx_viewWidth = 0;
    self.qlx_viewHeight = 0;
}

-(Class)qlx_reuseIdentifierClass{
    Class cla = objc_getAssociatedObject(self, @selector(qlx_reuseIdentifierClass));
    if (cla == nil) {
        QLXAssert(cla, @"未赋值该复用类名");
    }
    return cla;
}

-(void)setQlx_reuseIdentifierClass:(Class)qlx_reuseIdentifierClass{
    objc_setAssociatedObject(self, @selector(qlx_reuseIdentifierClass), qlx_reuseIdentifierClass, OBJC_ASSOCIATION_ASSIGN);
}


#pragma mark - getter setter


-(CGFloat)qlx_viewWidth{
    NSNumber * width = objc_getAssociatedObject(self, @selector(qlx_viewWidth));
    return [width floatValue];
}

-(void)setQlx_viewWidth:(CGFloat)viewWidth{
    NSNumber * width = [NSNumber numberWithFloat:viewWidth];
    objc_setAssociatedObject(self, @selector(qlx_viewWidth), width, OBJC_ASSOCIATION_RETAIN);
}

-(CGFloat)qlx_viewHeight{
    NSNumber * height = objc_getAssociatedObject(self, @selector(qlx_viewHeight));
    return [height floatValue];
}

-(void)setQlx_viewHeight:(CGFloat)viewHeight{
    NSNumber * height = [NSNumber numberWithFloat:viewHeight];
    objc_setAssociatedObject(self, @selector(qlx_viewHeight), height, OBJC_ASSOCIATION_RETAIN);
}

-(UIEdgeInsets)qlx_secionInset{
    NSValue * sectionInsetValue = objc_getAssociatedObject(self, @selector(qlx_secionInset));
    return [sectionInsetValue UIEdgeInsetsValue];
}

-(void)setQlx_secionInset:(UIEdgeInsets)secionInset{
    NSValue * sectionInsetValue = [NSValue valueWithUIEdgeInsets:secionInset];
    objc_setAssociatedObject(self, @selector(qlx_secionInset), sectionInsetValue, OBJC_ASSOCIATION_RETAIN);
}

-(CGFloat)qlx_minimumInteritemSpacing{
    NSNumber * spacing = objc_getAssociatedObject(self, @selector(qlx_minimumInteritemSpacing));
    return [spacing floatValue];
}

-(void)setQlx_minimumInteritemSpacing:(CGFloat)minimumInteritemSpacing{
    NSNumber * spacing = [NSNumber numberWithFloat:minimumInteritemSpacing];
    objc_setAssociatedObject(self, @selector(qlx_minimumInteritemSpacing), spacing, OBJC_ASSOCIATION_RETAIN);
}

-(CGFloat)qlx_minimumLineSpacing{
    NSNumber * spacing = objc_getAssociatedObject(self, @selector(qlx_minimumLineSpacing));
    return [spacing floatValue];
}

-(void)setQlx_minimumLineSpacing:(CGFloat)minimumLineSpacing{
    NSNumber * spacing = [NSNumber numberWithFloat:minimumLineSpacing];
    objc_setAssociatedObject(self, @selector(qlx_minimumLineSpacing), spacing, OBJC_ASSOCIATION_RETAIN);
}

@end
