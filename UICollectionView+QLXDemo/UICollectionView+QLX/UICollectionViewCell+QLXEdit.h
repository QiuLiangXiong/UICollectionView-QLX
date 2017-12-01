//
//  UICollectionViewCell+QLXEdit.h
//  UICollectionView+QLXDemo
//  和UITableViewCell 侧滑 编辑功能一致
//
//  Created by QLX on 2017/11/30.
//  Copyright © 2017年 QLX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICollectionViewCell(QLXEdit)

/*左侧滑出来的视图（左边编辑视图）*/
@property(nonatomic , strong,nullable) UIView * qlx_leftEidtView;
/*右侧滑出来的视图（右边编辑视图）*/
@property(nonatomic , strong,nullable) UIView * qlx_rightEidtView;

/**
 结束编辑状态
 note:一般用于操作了编辑按钮，手动调用该方法来结束编辑状态
 param：animated  是否带动画
 */
- (void)qlx_finishEditWithAnimated:(BOOL)animated;

/**
 是否处于编辑状态
 */
- (BOOL)qlx_isEditing;

/**
 打开左边编辑视图（这种手动打开的情况，一般用不到）
 */
- (void)qlx_openLeftEditView;

/**
  打开右边编辑视图（这种手动打开的情况，一般用不到）
 */
- (void)qlx_openRightEditView;

@end
