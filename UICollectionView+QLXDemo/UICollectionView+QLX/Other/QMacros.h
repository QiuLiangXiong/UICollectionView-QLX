//
//  QMacros.h
//  UICollectionView+QLXDemo
//
//  Created by QLX on 16/9/6.
//  Copyright © 2016年 QLX. All rights reserved.
//

#import <Foundation/Foundation.h>
#define kBlockWeakSelf __weak typeof(&*self) weakSelf = self
#ifdef DEBUG
#define QLXAssert(condition , description)  if(!(condition)){ NSLog(@"%@",description); assert(0);}
#else
#define QLXAssert(condition , description)
#endif

#ifdef DEBUG
#define QAssert(condition)  if(!(condition)){ assert(0);}
#else
#define QAssert(condition)
#endif
