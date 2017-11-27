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
#import "ACollectionViewCell.h"
#import "TestCollectionViewCell.h"
#import "ViewHeader.h"
#import "UICollectionView+QLX.h"


@interface ViewController ()<QLXCollectionViewDataSource,UICollectionViewDelegate>

@property(nonatomic , strong)  UICollectionView * cv;

@property(nonatomic , strong)  NSMutableArray * headerDataList;

@property(nonatomic , strong)  NSMutableArray * cellDataList;

@property(nonatomic , strong)  NSMutableArray * footerDataList;

@property(nonatomic , strong)  NSMutableArray * decroationViewClassList;

@property(nonatomic , strong) NSArray * t;

@property(nonatomic , strong) NSArray<QLXSectionData *> * dataList;


@end

@implementation ViewController

-(void)reloadData{
    [self.cv reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self cv];
    [self.cv reloadData];
    


    
    QLXSectionData * sectionData = [QLXSectionData new];
    sectionData.cellDataList = self.cellDataList;
    sectionData.headerData = self.headerDataList.firstObject;
    sectionData.decorationData = self.decroationViewClassList.firstObject;
    sectionData.footerData = self.footerDataList.firstObject;
    self.dataList = @[sectionData];
//
   
    
   
    
 
    UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(0, 100, 50, 50)];
    [button setTitle:@"添加" forState:0];
    [button setBackgroundColor:[UIColor blueColor]];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(addTest) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    
    
//    [self performSelector:@selector(reloadData) withObject:nil afterDelay:2];
    
//    [self performSelector:@selector(reloadData) withObject:nil afterDelay:5];
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)addTest{
    QLXSectionData * sectionData = self.dataList.firstObject;
    NSMutableArray * cellDataList = sectionData.cellDataList;
    if ([cellDataList isKindOfClass:[NSMutableArray class]]) {
        
        
        ACollectionViewData * data = [ACollectionViewData new];
                data.color = [UIColor redColor];
                data.title = @"SD龙卷风大煞风景SD街坊邻居水电费圣诞节发了多少了发生的分时度假发了多少佛挡杀佛";
        [cellDataList qlx_insertObject:data atIndex:0];
        
       
        
    }
}


#pragma mark - QLXCollectionViewDataSource


- (NSArray *)qlx_sectionDataListWithCollectionView:(UICollectionView *)collectionView{
    return self.dataList;
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
        ViewHeader * view = [ViewHeader new];
        view.qlx_minimumLineSpacing = 20;
        [view setTitle:@"我是头部"];
        view.qlx_secionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        
        [_headerDataList addObject:view];
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
//        data.color = [UIColor redColor];
//        data.title = @"SD龙卷风大煞风景SD街坊邻居水电费圣诞节发了多少了发生的分时度假发了多少佛挡杀佛";
//        [_cellDataList addObject:data];
        TestCollectionViewCell * cell = [TestCollectionViewCell new];
        [cell setTitle:@"1.SD凤林街道斯洛伐克束带结第三方的看两集"];
        [_cellDataList addObject:cell];
        

     
        

//        NSMutableArray * res = [NSMutableArray new];
//        [res addObject:_cellDataList];
//        _cellDataList = res;
        
//
       
        
        
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
