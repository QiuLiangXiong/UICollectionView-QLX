//
//  UICollectionView+QLX.m
//
//
//  Created by QLX on 15/9/6.
//  Copyright © 2016年 QLX. All rights reserved.
//

#import "UICollectionView+QLX.h"
#import "UICollectionViewDataSourceDelegator.h"
#import "UICollectionViewDataSourceDelegator+CollectionViewDelegator.h"
#import "QLXWeakObject.h"
#import <objc/runtime.h>

@implementation UICollectionView(QLX)

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleSelector:@selector(setDelegate:) withSelector:@selector(qlx_setDelegate:)];
    });
}

+ (instancetype) createForFlowLayout{
    UICollectionViewFlowLayout * layout = [UICollectionViewFlowLayout new];
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    
    CGSize size = [UIScreen mainScreen].bounds.size;
    
    UICollectionView * instance = [[[self class] alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height - 64) collectionViewLayout:layout];
    instance.backgroundColor = [UIColor clearColor];
    
    return instance;
}



#pragma mark - swizzle

- (void)qlx_setDelegate:(id<UICollectionViewDelegate>)delegate{
    [self qlx_setDelegate:delegate];
    if (self.qlx_dataSource) {
        [[self dataSourceDelegator] updateCollectionViewDelegateIfNeed];
    }
}


#pragma mark - setter
- (void)setQlx_dataSource:(id<QLXCollectionViewDataSource>)qlx_dataSource{
    if (self.qlx_dataSource != qlx_dataSource ) {
        QLXWeakObject * dataSource = [QLXWeakObject new];
        dataSource.weakObject = qlx_dataSource;
        
        objc_setAssociatedObject(self, @selector(qlx_dataSource), dataSource, OBJC_ASSOCIATION_RETAIN);
    
        UICollectionViewDataSourceDelegator * delegator = [self dataSourceDelegator];
        delegator.delegate = qlx_dataSource;
        if (qlx_dataSource) {
          [self setDataSource:delegator];
        }else {
           [self setDataSource:nil];
        }
        [delegator updateCollectionViewDelegateIfNeed];
    }
}


#pragma mark - getter

- (id<QLXCollectionViewDataSource>)qlx_dataSource{
    QLXWeakObject * dataSource = objc_getAssociatedObject(self, @selector(qlx_dataSource));
    return dataSource.weakObject;
}

- (UICollectionViewDataSourceDelegator *)dataSourceDelegator{
    UICollectionViewDataSourceDelegator * delegator = objc_getAssociatedObject(self, @selector(dataSourceDelegator));
    if (!delegator) {
        delegator = [UICollectionViewDataSourceDelegator new];
        delegator.collectionView = self;
        objc_setAssociatedObject(self, @selector(dataSourceDelegator), delegator, OBJC_ASSOCIATION_RETAIN);
    }
    return delegator;
}


+ (void)swizzleSelector:(SEL)originalSelector withSelector:(SEL)swizzledSelector {
    Class class = [self class];
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    method_exchangeImplementations(originalMethod, swizzledMethod);
}


@end
