
[![Platform](https://img.shields.io/badge/platform-iOS-red.svg)](https://developer.apple.com/iphone/index.action)
[![Language](http://img.shields.io/badge/language-OC-yellow.svg?style=flat
)](https://en.wikipedia.org/wiki/Objective-C)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](http://mit-license.org)
![CocoaPods Version](https://img.shields.io/badge/pod-v1.0.0-brightgreen.svg)

本库已经配置到cocoapods。
_在podfile文件中加入_ `pod 'UICollectionView-QLX', '~> 2.3.0'` _或_ `pod "UICollectionView-QLX"`
<br />_使用_ `pod install`_即可一键引入_
# UICollectionView-QLX
一款基于UICollectionView扩展，告别繁琐的代理，一个数组就能搞定数据源，数组自动同步视图， 更好用的UICollectionView。


特性
==============
- **简单**: 基于UICollectinView扩展， 使用起来就是一个数组就可以完成列表显示，一个数组的事儿，批量操作数组后，视图自动同步到CollectionView，真正做到数据驱动视图。
- **高效**:1.Cell高度自动缓存，避免realodData重复计算;2.数组的元素改变，会自动只更新差异化的元素，做到只更新改变的，因此比起realodData的要全部重新计算布局以及渲染对应Cell，性能更优。
- **灵活**: 支持view实例作为数据源直接当做cell使用，好比是UIScroller里面添加了一个View，因此， 可以提高因为cell复用过程带来的性能消耗，一般用于不复用的Cell，可以用view直接作为数据源。
- **安全**: 当数据源数组和CollectionView 对应Cell不同步时，框架会自动返回默认空Cell，并且高度为0.01， 以保证返回值安全，避免崩溃问题。
- **轻量**: 该框架只有少量个文件 (包括.h文件)。
- **支持编辑模式**: 功能和UITableViewCell的 侧滑编辑一致，不过更好用，只需设置Cell 的rightEditView 或者leftEiditView 即可侧滑。
- **支持拖拽重排**: 一行代码实现重排，只需设置data 的resortEnable 为true即可自动拖拽重排。


使用方法
==============

```objc
   
  创建UICollectionView
    {
       UICollectionView * collectionView = [UICollectionView qlx_createForFlowLayout];
        collectionView.frame = self.view.bounds;
        collectionView.delegate = self;
        collectionView.qlx_dataSource = self;
        [self.view addSubview:collectionView];
    }
    
    
//实现数据源代理
#pragma mark - QLXCollectionViewDataSource
- (NSArray<QLXSectionData *> *)qlx_sectionDataListWithCollectionView:(UICollectionView *)collectionView{
    return self.dataList;
}
//提供数据
  QLXSectionData * sectionData = [QLXSectionData new];
    sectionData.cellDataList = cellDataList;
    sectionData.headerData = headerView;//支持view 也支持data
    sectionData.decorationData = [ADecroationView class];
    sectionData.footerData = [ACollectionViewFooterData new];
    self.dataList = @[sectionData];

//更多使用方法下载Demo学习...
```

安装
==============
### CocoaPods

1. 在 Podfile 中添加 `pod 'UICollectionView-QLX'`。
2. 执行 `pod install` 或 `pod update`。
3. 导入 `UICollectionView+QLX.h`。
### 手动安装

1. 下载Demo内 UICollectionView+QLX 文件夹内的所有内容。
2. 将 UICollectionView+QLX 文件夹添加(拖放)到你的工程。
3. 导入 `UICollectionView+QLX.h`。


文档
==============
你可以在 [CocoaDocs](http://cocoadocs.org/docsets/UICollectionView-QLX/) 查看在线 API 文档，也可以用 [appledoc](https://github.com/tomaz/appledoc) 本地生成文档。


系统要求
==============
该项目最低支持 `iOS 7.0` 和 `Xcode 8.0`。


许可证
==============
UICollectionView-QLX 使用 MIT 许可证，详情见 LICENSE 文件。
