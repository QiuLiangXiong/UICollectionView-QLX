//
//  UICollectionViewCell+QLX.h
//  UICollectionView+QLXDemo
//
//  Created by QLX on 16/9/7.
//  Copyright © 2016年 QLX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView(QLXCellDelegate)

#pragma mark - cell callback

- (void)qlx_prepareForReuse;

#pragma mark - UICollectionViewDelegate callback

- (void)qlx_didSelectCell;

//note:invaid in header or footer
- (void)qlx_didDeselectCell;

- (void)qlx_willDisplayCell;

- (void)qlx_didEndDisplayingCell;

//note:invaid in header or footer
- (BOOL)qlx_shouldSelectCell;

//note:invaid in header or footer
- (BOOL)qlx_shouldDeselectCell;

//note:invaid in header or footer
- (BOOL)qlx_shouldHighlightCell;

//note:invaid in header or footer
- (void)qlx_didHighlightCell;

//note:invaid in header or footer
- (void)qlx_didUnhighlightCell;

@end
