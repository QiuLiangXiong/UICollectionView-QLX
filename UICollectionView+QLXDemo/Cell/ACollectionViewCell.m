//
//  ACollectionViewCell.m
//  UICollectionView+QLXDemo
//
//  Created by QLX on 16/9/8.
//  Copyright © 2016年 QLX. All rights reserved.
//

#import "ACollectionViewCell.h"
#import "ACollectionViewData.h"

@interface ACollectionViewCell()

@property(nonatomic , strong)  UILabel * titleLbl;
@property(nonatomic , strong)  UILabel * subTitleLbl;

@end

@implementation ACollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self titleLbl];
        [self subTitleLbl];
        static int i = 0;
        i++;
        NSLog(@"%d",i);
    }
    return self;
}

-(void)qlx_reuseWithData:(NSObject *)data indexPath:(NSIndexPath *)indexPath{
    [super qlx_reuseWithData:data indexPath:indexPath];
    ACollectionViewData * rData = (ACollectionViewData *)data;
    self.contentView.backgroundColor = rData.color;
    self.subTitleLbl.text = rData.title;
}

/**
 *  点击
 */

-(void)qlx_didSelectCell{
    NSLog(@"%@",self.qlx_indexPath);
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
