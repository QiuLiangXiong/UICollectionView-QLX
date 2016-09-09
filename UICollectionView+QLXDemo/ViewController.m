//
//  ViewController.m
//  UICollectionView+QLXDemo
//
//  Created by QLX on 16/9/6.
//  Copyright © 2016年 QLX. All rights reserved.
//

#import "ViewController.h"
#import "ACollectionViewData.h"
#import "ADecroationView.h"
#import "ACollectionViewHeaderData.h"
#import "ACollectionViewFooterData.h"


@interface ViewController ()<QLXCollectionViewDataSource,UICollectionViewDelegate>

@property(nonatomic , strong)  UICollectionView * cv;

@property(nonatomic , strong)  NSMutableArray * headerDataList;

@property(nonatomic , strong)  NSMutableArray * cellDataList;

@property(nonatomic , strong)  NSMutableArray * footerDataList;

@property(nonatomic , strong)  NSMutableArray * decroationViewClassList;

@end

@implementation ViewController

-(void)reloadData{
    [self.cv reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self cv];
    
    [self performSelector:@selector(reloadData) withObject:nil afterDelay:2];
    
    // Do any additional setup after loading the view, typically from a nib.
}



#pragma mark - QLXCollectionViewDataSource

-(NSArray *)qlx_headerDataListWithCollectionView:(UICollectionView *)collectionView{
    return self.headerDataList;
}

-(NSArray *)qlx_cellDataListWithCollectionView:(UICollectionView *)collectionView{
    return self.cellDataList;
}

-(NSArray *)qlx_footerDataListWithCollectionView:(UICollectionView *)collectionView{
    return self.footerDataList;
}

-(NSArray<Class> *)qlx_decorationViewClassListWithCollectionView:(UICollectionView *)collectionView{
    return self.decroationViewClassList;
}

#pragma mark - UICollectionViewDelegate

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}


#pragma mark - getter

-(UICollectionView *)cv{
    if (!_cv) {
        _cv = [UICollectionView createForFlowLayout];
        _cv.frame = self.view.bounds;
        _cv.delegate = self;
        _cv.qlx_dataSource = self;
        [self.view addSubview:_cv];
    }
    return _cv;
}

-(NSMutableArray *)headerDataList{
    if (!_headerDataList) {
        _headerDataList = [NSMutableArray new];
        [_headerDataList addObject:[ACollectionViewHeaderData new]];
    }
    return _headerDataList;
}

-(NSMutableArray *)footerDataList{
    if (!_footerDataList) {
        _footerDataList = [NSMutableArray new];
        [_footerDataList addObject:[ACollectionViewFooterData new]];
    }
    return _footerDataList;
}

-(NSMutableArray *)cellDataList{
    if (!_cellDataList) {
        _cellDataList = [NSMutableArray new];
        ACollectionViewData * data = [ACollectionViewData new];
        data.color = [UIColor redColor];
        data.title = @"SD龙卷风大煞风景SD街坊邻居水电费圣诞节发了多少了发生的分时度假发了多少佛挡杀佛";
        [_cellDataList addObject:data];
        data = [ACollectionViewData new];
        data.color = [UIColor blueColor];
                data.title = @"SD龙卷风大煞风景SD街坊邻居";
        [_cellDataList addObject:data];
        
        
        data = [ACollectionViewData new];
        data.color = [UIColor grayColor];
                data.title = @"SD龙卷风大煞风景SD街坊邻居水电费圣诞节发了多少了发生的分时度假发了多少佛挡杀佛";
        [_cellDataList addObject:data];
        
        data = [ACollectionViewData new];
        data.color = [UIColor cyanColor];
                        data.title = @"SD龙卷风大煞风景SD街坊邻居";
        [_cellDataList addObject:data];
        
        data = [ACollectionViewData new];
        data.color = [UIColor brownColor];
                        data.title = @"SD龙卷风大煞风景SD街坊邻居水电费圣诞节发了多少了发生的分时度假发了多少佛挡杀佛";
        [_cellDataList addObject:data];
        
        data = [ACollectionViewData new];
        data.color = [UIColor yellowColor];
                        data.title = @"SD龙卷风大煞风景SD街坊邻居";
        [_cellDataList addObject:data];
        
        data = [ACollectionViewData new];
        data.color = [UIColor grayColor];
                        data.title = @"SD龙卷风大煞风景SD街坊邻居水电费圣诞节发了多少了发生的分时度假发了多少佛挡杀佛";
        [_cellDataList addObject:data];
        
        data = [ACollectionViewData new];
        data.color = [UIColor blueColor];
        data.title = @"SD龙卷风大煞风景SD街坊邻居";
        [_cellDataList addObject:data];
        
        data = [ACollectionViewData new];
        data.color = [UIColor redColor];
        data.title = @"SD龙卷风大煞风景SD街坊邻居水电费圣诞节发了多少了发生的分时度假发了多少佛挡杀佛";
        [_cellDataList addObject:data];
        
        
        data = [ACollectionViewData new];
        data.color = [UIColor blueColor];
        data.title = @"SD龙卷风大煞风景SD街坊邻居";
        [_cellDataList addObject:data];
        
        
        data = [ACollectionViewData new];
        data.color = [UIColor grayColor];
        data.title = @"SD龙卷风大煞风景SD街坊邻居水电费圣诞节发了多少了发生的分时度假发了多少佛挡杀佛";
        [_cellDataList addObject:data];
        
        data = [ACollectionViewData new];
        data.color = [UIColor cyanColor];
        data.title = @"SD龙卷风大煞风景SD街坊邻居";
        [_cellDataList addObject:data];
        
        data = [ACollectionViewData new];
        data.color = [UIColor brownColor];
        data.title = @"SD龙卷风大煞风景SD街坊邻居水电费圣诞节发了多少了发生的分时度假发了多少佛挡杀佛";
        [_cellDataList addObject:data];
        
        data = [ACollectionViewData new];
        data.color = [UIColor yellowColor];
        data.title = @"SD龙卷风大煞风景SD街坊邻居";
        [_cellDataList addObject:data];
        
        data = [ACollectionViewData new];
        data.color = [UIColor grayColor];
        data.title = @"SD龙卷风大煞风景SD街坊邻居水电费圣诞节发了多少了发生的分时度假发了多少佛挡杀佛";
        [_cellDataList addObject:data];
        
        
        data = [ACollectionViewData new];
        data.color = [UIColor blueColor];
        data.title = @"SD龙卷风大煞风景SD街坊邻居";
        [_cellDataList addObject:data];

        data = [ACollectionViewData new];
        data.color = [UIColor redColor];
        data.title = @"SD龙卷风大煞风景SD街坊邻居水电费圣诞节发了多少了发生的分时度假发了多少佛挡杀佛SD龙卷风大煞风景SD街坊邻居水电费圣诞节发了多少了发生的分时度假发了多少佛挡杀佛";
        [_cellDataList addObject:data];
        data = [ACollectionViewData new];
        data.color = [UIColor blueColor];
        data.title = @"SD龙卷风大煞风景SD街坊邻居";
        [_cellDataList addObject:data];
        
        
        data = [ACollectionViewData new];
        data.color = [UIColor grayColor];
        data.title = @"SD龙卷风大煞风景SD街坊邻居水电费圣诞节发了多少了发生的分时度假发了多少佛挡杀佛SD龙卷风大煞风景SD街坊邻居水电费圣诞节发了多少了发生的分时度假发了多少佛挡杀佛";
        [_cellDataList addObject:data];
        
        data = [ACollectionViewData new];
        data.color = [UIColor cyanColor];
        data.title = @"SD龙卷风大煞风景SD街坊邻居";
        [_cellDataList addObject:data];
        
        data = [ACollectionViewData new];
        data.color = [UIColor brownColor];
        data.title = @"SD龙卷风大煞风景SD街坊邻居水电费圣诞节发了多少了发生的分时度假发了多少佛挡杀佛SD龙卷风大煞风景SD街坊邻居水电费圣诞节发了多少了发生的分时度假发了多少佛挡杀佛";
        [_cellDataList addObject:data];
        
        data = [ACollectionViewData new];
        data.color = [UIColor yellowColor];
        data.title = @"SD龙卷风大煞风景SD街坊邻居";
        [_cellDataList addObject:data];
        
        data = [ACollectionViewData new];
        data.color = [UIColor grayColor];
        data.title = @"SD龙卷风大煞风景SD街坊邻居水电费圣诞节发了多少了发生的分时度假发了多少佛挡杀佛SD龙卷风大煞风景SD街坊邻居水电费圣诞节发了多少了发生的分时度假发了多少佛挡杀佛";
        [_cellDataList addObject:data];
        
        data = [ACollectionViewData new];
        data.color = [UIColor blueColor];
        data.title = @"SD龙卷风大煞风景SD街坊邻居";
        [_cellDataList addObject:data];
        
        data = [ACollectionViewData new];
        data.color = [UIColor redColor];
        data.title = @"SD龙卷风大煞风景SD街坊邻居水电费圣诞节发了多少了发生的分时度假发了多少佛挡杀佛SD龙卷风大煞风景SD街坊邻居水电费圣诞节发了多少了发生的分时度假发了多少佛挡杀佛";
        [_cellDataList addObject:data];
        
        
        data = [ACollectionViewData new];
        data.color = [UIColor blueColor];
        data.title = @"SD龙卷风大煞风景SD街坊邻居";
        [_cellDataList addObject:data];
        
        
        data = [ACollectionViewData new];
        data.color = [UIColor grayColor];
        data.title = @"SD龙卷风大煞风景SD街坊邻居水电费圣诞节发了多少了发生的分时度假发了多少佛挡杀佛SD龙卷风大煞风景SD街坊邻居水电费圣诞节发了多少了发生的分时度假发了多少佛挡杀佛";
        [_cellDataList addObject:data];
        
        data = [ACollectionViewData new];
        data.color = [UIColor cyanColor];
        data.title = @"SD龙卷风大煞风景SD街坊邻居";
        [_cellDataList addObject:data];
        
        data = [ACollectionViewData new];
        data.color = [UIColor brownColor];
        data.title = @"SD龙卷风大煞风景SD街坊邻居水电费圣诞节发了多少了发生的分时度假发了多少佛挡杀佛SD龙卷风大煞风景SD街坊邻居水电费圣诞节发了多少了发生的分时度假发了多少佛挡杀佛";
        [_cellDataList addObject:data];
        
        data = [ACollectionViewData new];
        data.color = [UIColor yellowColor];
        data.title = @"SD龙卷风大煞风景SD街坊邻居";
        [_cellDataList addObject:data];
        
        data = [ACollectionViewData new];
        data.color = [UIColor grayColor];
        data.title = @"SD龙卷风大煞风景SD街坊邻居水电费圣诞节发了多少了发生的分时度假发了多少佛挡杀佛";
        [_cellDataList addObject:data];
        
        
    }
    return _cellDataList;
}

-(NSMutableArray *)decroationViewClassList{
    if (!_decroationViewClassList) {
        _decroationViewClassList = [NSMutableArray new];
        [_decroationViewClassList addObject:[ADecroationView class]];
    }
    return _decroationViewClassList;
}

@end
