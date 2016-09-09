//
//  UICollectionViewCell+QLX.h
//  UICollectionView+QLXDemo
//
//  Created by QLX on 16/9/7.
//  Copyright © 2016年 QLX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICollectionViewCell(QLX)

#pragma mark - UICollectionViewDelegate callback

- (void)qlx_didSelectCell;

- (void)qlx_didDeselectCell;

- (void)qlx_willDisplayCell;

- (BOOL)qlx_shouldSelectCell;

- (BOOL)qlx_shouldDeselectCell;

- (BOOL)qlx_shouldHighlightCell;

- (void)qlx_didHighlightCell;

- (void)qlx_didUnhighlightCell;

@end
