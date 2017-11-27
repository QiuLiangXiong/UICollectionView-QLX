//
//  UICollectionView+QLX_Sync.m
//  UICollectionView+QLXDemo
//
//  Created by QLX on 2017/11/20.
//  Copyright © 2017年 QLX. All rights reserved.
//

#import "UICollectionView+QLX_Sync.h"
#import <objc/runtime.h>
#import "QMacros.h"

#import "QLXDataSource.h"
#import "QLXWeakObject.h"
#import "QLXCollectionViewUpdateUtil.h"



@interface UICollectionView()

@property(nonatomic , strong) QLXDataSource * qlx_oldDataSource;

@end


@implementation UICollectionView(QLX_Sync)

- (void)qlx_copyDataSource{
    dispatch_queue_t queue = [[self class] getSyncToViewQueue];
    __weak typeof(&*self) weakSelf = self;
    dispatch_async(queue, ^{
        @try
        {
            [UICollectionView qlx_addCollectionViewInsanceIfNeed:weakSelf];
            weakSelf.qlx_oldDataSource = [QLXDataSource createWithCollectionView:weakSelf];
        }@catch (NSException * e) {
            QLXAssert(false, [e description])
        }
       
    });
}

+ (void)qlx_syncToViewWithAnimated:(BOOL)animated  completed:(void (^)())completed{
    dispatch_queue_t queue = [[self class] getSyncToViewQueue];
    __weak typeof(&*self) weakSelf = self;
    dispatch_async(queue, ^{
        [weakSelf _syncToViewWithAnimated:animated completed:completed];
    });
}

#pragma mark private

+ (dispatch_queue_t)getSyncToViewQueue{
    static dispatch_queue_t  qlx_queue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!qlx_queue) {
            qlx_queue = dispatch_queue_create("qlx.sync.queue", DISPATCH_QUEUE_SERIAL);
        }
    });
    return qlx_queue;
}

+ (NSMutableDictionary *)getcollectionViewInsatncesDic{
    static NSMutableDictionary *  collectionViewInsatncesDic;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!collectionViewInsatncesDic) {
            collectionViewInsatncesDic = [NSMutableDictionary new];
        }
    });
    return collectionViewInsatncesDic;
}


+ (void)qlx_addCollectionViewInsanceIfNeed:(UICollectionView *)collectionView{
    if ([collectionView isKindOfClass:[UICollectionView class]]) {
        NSString * key = [NSString stringWithFormat:@"%ld",(long)collectionView];
        if (key) {
            NSMutableDictionary * dic = [self getcollectionViewInsatncesDic];
            QLXWeakObject * value = [dic objectForKey:key];
            if (!value || !value.weakObject) {
                value = [QLXWeakObject new];
                value.weakObject = collectionView;
                [dic setObject:value forKey:key];
            }
        }
    }
    
}

+ (NSMutableArray *)qlx_getAllCollectionViewInsatnces{
    NSMutableDictionary * dic = [self getcollectionViewInsatncesDic];
    NSMutableArray * res = [NSMutableArray new];
    NSArray * keys = [dic.allKeys copy];
    for (NSString * key in keys) {
        QLXWeakObject * value = dic[key];
        if (value.weakObject) {
            [res addObject:value];
        }else {
            [dic removeObjectForKey:key];
        }
    }
    return res;
}


+ (void)_syncToViewWithAnimated:(BOOL)animated  completed:(void (^)())completed{
    
    NSMutableArray * collectionViews = [self qlx_getAllCollectionViewInsatnces];
    for (QLXWeakObject * weakObject in collectionViews) {
        UICollectionView * collectionView = weakObject.weakObject;
        if (collectionView) {
           QLXDataSource * newSourceData = [QLXDataSource createWithCollectionView:collectionView];
           QLXDataSource * oldSourceData = collectionView.qlx_oldDataSource;
            [QLXCollectionViewUpdateUtil performUpdatesWithNewData:newSourceData oldData:oldSourceData  view:collectionView animated:animated];
        }
    }
    if (completed) {
        completed();
    }
}



#pragma mark - getter/setter

- (QLXDataSource *)qlx_oldDataSource{
    return objc_getAssociatedObject(self, @selector(qlx_oldDataSource));
}

- (void)setQlx_oldDataSource:(QLXDataSource *)qlx_oldDataSource{
     objc_setAssociatedObject(self, @selector(qlx_oldDataSource), qlx_oldDataSource, OBJC_ASSOCIATION_RETAIN);
}

@end
