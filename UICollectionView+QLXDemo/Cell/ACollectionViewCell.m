//
//  ACollectionViewCell.m
//  UICollectionView+QLXDemo
//
//  Created by QLX on 16/9/8.
//  Copyright © 2016年 QLX. All rights reserved.
//

#import "ACollectionViewCell.h"
#import "ACollectionViewData.h"
#import "UICollectionView+QLX.h"

@interface ACollectionViewCell()

@property(nonatomic , strong)  UILabel * titleLbl;
@property(nonatomic , strong)  UILabel * subTitleLbl;

@end

@implementation ACollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blueColor];
        
        UIGestureRecognizer * tapGS = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onDidSelected)];
        
        [self.titleLbl addGestureRecognizer:tapGS];
        self.titleLbl.userInteractionEnabled = true;
        

    }
    return self;
}

-(void)qlx_reuseWithData:(NSObject *)data indexPath:(NSIndexPath *)indexPath{
    [super qlx_reuseWithData:data indexPath:indexPath];
    ACollectionViewData * rData = (ACollectionViewData *)data;
    self.titleLbl.text = rData.title;
}

/**
 *  点击
 */

-(void)qlx_didSelectCell{
    NSLog(@"%@",self.qlx_indexPath);
}

- (void)onDidSelected{
    ACollectionViewData * rData = (ACollectionViewData *)self.qlx_data;
    rData.title = @"我是一个Data我是一个Data我是一个Data我是一个Data我是一个Data我是一个Data我是一个Data我是一个Data";;
    [self qlx_updateViewWithAnimated:true];
}


//-(CGSize)qlx_viewSize{
//    return CGSizeMake(self.collectionView.frame.size.width, 50);
//}

-(UILabel *)titleLbl{
    if (!_titleLbl) {
        _titleLbl = [UILabel new];
        _titleLbl.numberOfLines = 0;
        _titleLbl.text = @"个人信息";
        [self.contentView addSubview:_titleLbl];
        
        [_titleLbl sizeToFit];
        
        [_titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(20);
            make.left.equalTo(self.contentView).offset(10);
            make.bottom.lessThanOrEqualTo(self.contentView).offset(-20);
            make.right.equalTo(self.contentView).offset(-20);
        }];
    }
    return _titleLbl;
}



//- (UIView *)contentView{
//    return self;
//}

@end
