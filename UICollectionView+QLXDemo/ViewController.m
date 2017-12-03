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
#import "TestView.h"


@interface ViewController ()<QLXCollectionViewDataSource,UICollectionViewDelegate>

@property(nonatomic , strong)  UICollectionView * cv;

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
    

    ViewHeader * headerView = [ViewHeader new];
    headerView.qlx_minimumLineSpacing = 20;
    [headerView setTitle:@"我是头部"];
    headerView.qlx_secionInset = UIEdgeInsetsMake(10, 10, 10, 10);

    NSMutableArray * cellDataList = [NSMutableArray new];
//    TestCollectionViewCell * cell = [TestCollectionViewCell new];
//    [cell setTitle:@"我是一个Cell类型的View"];
    
    NSObject * cellData = [NSObject new];
    cellData.qlx_reuseIdentifierClass = [TestCollectionViewCell class];
    
    cellData.qlx_resortEnable = true;
    
    [cellDataList addObject:cellData];
      [cellDataList addObject:cellData];
      [cellDataList addObject:cellData];
      [cellDataList addObject:cellData];
      [cellDataList addObject:cellData];
    
    
    QLXSectionData * sectionData = [QLXSectionData new];
    sectionData.cellDataList = cellDataList;
    sectionData.headerData = headerView;//支持view 也支持data
    sectionData.decorationData = [ADecroationView class];
    sectionData.footerData = [ACollectionViewFooterData new];
    self.dataList = @[sectionData];
//
   
    
   
    
 
    UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(0, 44, 80, 80)];
    [button setTitle:@"添加" forState:0];
    [button setBackgroundColor:[UIColor blueColor]];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(addTest) forControlEvents:(UIControlEventTouchUpInside)];
    UIButton * button2 = [[UIButton alloc] initWithFrame:CGRectMake(150, 44, 80, 80)];
    [button2 setTitle:@"删除" forState:0];
    [button2 setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:button2];
    [button2 addTarget:self action:@selector(removeTest) forControlEvents:(UIControlEventTouchUpInside)];
    
    

}


- (void)addTest{
    QLXSectionData * sectionData = self.dataList.firstObject;
    NSMutableArray * cellDataList = sectionData.cellDataList;
    if ([cellDataList isKindOfClass:[NSMutableArray class]]) {
        
        
        
        int rand =random()%2;
        for (int i = 0 ; i < 1; i++) {
            
            if(rand == 0){
                ACollectionViewData * data = [ACollectionViewData new];
                data.title = @"我是一个Data";
                [cellDataList qlx_insertObject:data atIndex:0 syncToView:true animated:true];
            }else {
                [cellDataList qlx_insertObject:[TestView new] atIndex:0 syncToView:true animated:true];
            }
            
           
        }
        
       
        
       
        
    }
}
- (void)removeTest{
    
    

    QLXSectionData * sectionData = self.dataList.firstObject;
    NSMutableArray * cellDataList = (NSMutableArray *)sectionData.cellDataList;
    if ([cellDataList isKindOfClass:[NSMutableArray class]]) {
        
        [cellDataList qlx_removeObject:cellDataList.firstObject syncToView:true animated:true];
//        [cellDataList qlx_removeObjectsInArray:cellDataList syncToView:true animated:YES];
        
        
        
        
        
    }
}


#pragma mark - QLXCollectionViewDataSource


- (NSArray<QLXSectionData *> *)qlx_sectionDataListWithCollectionView:(UICollectionView *)collectionView{
    return self.dataList;
}

#pragma mark - UICollectionViewDelegate

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"点击了section:%ld,row:%ld",(long)indexPath.section,(long)indexPath.row);
}




#pragma mark - getter

-(UICollectionView *)cv{
    if (!_cv) {
        _cv = [UICollectionView qlx_createForFlowLayout];
        _cv.frame = self.view.bounds;
        _cv.delegate = self;
        _cv.qlx_dataSource = self;
        [self.view addSubview:_cv];
    }
    return _cv;
}


@end
