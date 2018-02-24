//
//  TestView.m
//  UICollectionView+QLXDemo
//
//  Created by QLX on 2017/11/28.
//  Copyright © 2017年 QLX. All rights reserved.
//

#import "TestView.h"
#import "UICollectionView-QLX.h"

@interface TestView()

@property(nonatomic , strong) UILabel * titleLbl;

@end

@implementation TestView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLbl.text = @"我是一个View";
        
        self.frame = CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width-20, 0);

        self.backgroundColor = [UIColor yellowColor];
        UIGestureRecognizer * tapGS = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onDidSelected)];
        
        [self.titleLbl addGestureRecognizer:tapGS];
        self.titleLbl.userInteractionEnabled = true;

    }
    return self;
}



- (void)onDidSelected{
    self.titleLbl.text = @"我是一个View我是一个View我是一个View我是一个View我是一个View我是一个View我是一个View我是一个View我是一个View我是一个Vi我是一个View我是一个View我是一个Vi我是一个View我是一个View我是一个Vi我是一个View我是一个View我是一个Vi我是一个View我是一个View我是一个Vi我是一个View我是一个View我是一个Vi";
    [self qlx_updateViewWithAnimated:true];
    
    
}

- (void)setTitle:(NSString *)title{
    self.titleLbl.text = title;

}

//- (void)prepareForReuse{
//    [super prepareForReuse];
//}

- (void)qlx_prepareForReuse{
    [super qlx_prepareForReuse];
}




-(void)qlx_reuseWithData:(NSObject *)data indexPath:(NSIndexPath *)indexPath{
    [super qlx_reuseWithData:data indexPath:indexPath];
}



/**
 *  点击
 */

//- (UIView *)contentView{
//    if ([self isKindOfClass:[UICollectionViewCell class]]) {
//        return [super performSelector:@selector(contentView) withObject:nil];
//    }
//    return self;
//}

-(void)qlx_didSelectCell{
    [super qlx_didSelectCell];
    //    NSLog(@"%@",self.qlx_indexPath);
    //    [super qlx_didSelectCell];
}

- (void)qlx_willDisplayCell{
    [super qlx_willDisplayCell];
}



//-(CGSize)qlx_viewSize{
//    return CGSizeMake(self.collectionView.frame.size.width, 50);
//}



-(UILabel *)titleLbl{
    if (!_titleLbl) {
        _titleLbl = [UILabel new];
        _titleLbl.numberOfLines = 0;
        _titleLbl.text = @"个人信息";
        [self addSubview:_titleLbl];
        
        [_titleLbl sizeToFit];
        
        [_titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(20);
            make.left.equalTo(self).offset(10);
            make.bottom.lessThanOrEqualTo(self).offset(-20);
            make.right.lessThanOrEqualTo(self).offset(-20);
        }];
    }
    return _titleLbl;
}


@end
