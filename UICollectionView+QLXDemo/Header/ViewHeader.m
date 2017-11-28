//
//  ViewHeader.m
//  UICollectionView+QLXDemo
//
//  Created by QLX on 2017/11/8.
//  Copyright © 2017年 QLX. All rights reserved.
//

#import "ViewHeader.h"
#import "UICollectionView+QLX.h"
@interface ViewHeader()

@property(nonatomic , strong)  UILabel * titleLbl;
@property(nonatomic , strong)  UILabel * subTitleLbl;

@end

@implementation ViewHeader


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self titleLbl];
        [self subTitleLbl];
        self.backgroundColor = [UIColor redColor];
        self.subTitleLbl.text = @"SDK解放路大煞风景说多累快放假老实点受打击了开发但是就离开手机端发说多累会计法说多累会计法说的放假了可适当方式豆腐";
        
        UIGestureRecognizer * tapGS = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onDidSelected)];
        
        [self.subTitleLbl addGestureRecognizer:tapGS];
        self.subTitleLbl.userInteractionEnabled = true;
        
        
        
        //        static int i = 0;
        //        i++;
        //        NSLog(@"test:%d",i);
        //        self.frame = CGRectMake(0, 0, 375, 200);
    }
    return self;
}



- (void)onDidSelected{
    
    self.subTitleLbl.text = @"SDK解放路大煞风景说多累快放假老实点受打击了开发但是就离开手机端发说多累会计法说多累会计法说的放假了可适当方式豆腐";
    [self qlx_updateViewWithAnimated:true];
}

- (void)setTitle:(NSString *)title{
    self.subTitleLbl.text = title;
}

- (void)prepareForReuse{
    [super prepareForReuse];
}

- (void)qlx_prepareForReuse{
    [super qlx_prepareForReuse];
}

- (void)qlx_willDisplayCell{
    
}

- (void)qlx_didEndDisplayingCell{
    
}






-(void)qlx_reuseWithData:(NSObject *)data indexPath:(NSIndexPath *)indexPath{
    [super qlx_reuseWithData:data indexPath:indexPath];
}



/**
 *  点击
 */

- (UIView *)contentView{
    if ([self isKindOfClass:[UICollectionViewCell class]]) {
        return [super performSelector:@selector(contentView) withObject:nil];
    }
    return self;
}

-(void)qlx_didSelectCell{
    [super qlx_didSelectCell];
    //    NSLog(@"%@",self.qlx_indexPath);
    //    [super qlx_didSelectCell];
}




//-(CGSize)qlx_viewSize{
//    return CGSizeMake(self.collectionView.frame.size.width, 50);
//}



-(UILabel *)titleLbl{
    if (!_titleLbl) {
        _titleLbl = [UILabel new];
        _titleLbl.numberOfLines = 1;
        _titleLbl.text = @"个人信息";
        [self.contentView addSubview:_titleLbl];
        
        [_titleLbl sizeToFit];
        
        [_titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(20);
            make.left.equalTo(self.contentView).offset(10);
            make.bottom.lessThanOrEqualTo(self.contentView).offset(-20);
            make.width.mas_equalTo(@(_titleLbl.frame.size.width));
        }];
    }
    return _titleLbl;
}

-(UILabel *)subTitleLbl{
    if (!_subTitleLbl) {
        _subTitleLbl = [UILabel new];
        _subTitleLbl.numberOfLines = 0;
        [self.contentView addSubview:_subTitleLbl];
        
        [_subTitleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-10);
            make.top.equalTo(self.titleLbl);
            make.bottom.equalTo(self.contentView).offset(-20);
            make.left.greaterThanOrEqualTo(self.titleLbl.mas_right).offset(20);
        }];
        
        
    }
    return _subTitleLbl;
}

@end
