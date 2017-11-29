
[![Platform](https://img.shields.io/badge/platform-iOS-red.svg)](https://developer.apple.com/iphone/index.action)
[![Language](http://img.shields.io/badge/language-OC-yellow.svg?style=flat
)](https://en.wikipedia.org/wiki/Objective-C)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](http://mit-license.org)
![CocoaPods Version](https://img.shields.io/badge/pod-v1.0.0-brightgreen.svg)

本库已经配置到cocoapods。
_在podfile文件中加入_ `pod 'UICollectionView-QLX', '~> 2.0.0'` _或_ `pod "UICollectionView-QLX"`
<br />_使用_ `pod install`_即可一键引入_
# UICollectionView-QLX
一款基于UICollectionView扩展，告别繁琐的代理，一个数组就能搞定数据源，数组自动同步视图， 更好用的UICollectionView。


特性
==============
- **简单**: 基于UICollectinView扩展， 使用起来就是一个数组就可以完成列表显示，一个数组的事儿，批量操作数组后，视图自动同步到CollectionView，真正做到数据驱动视图。
- **高性能**: Cell高度自动缓存，避免realodData重复计算。
- **灵活**: 支持view实例作为数据源直接被cell使用，可以提高因为cell复用过程带来的性能消耗，一般用于不复用的Cell，可以用view直接作为数据源。
- **安全**: 当数据和视图布局不同步时，，框架会自动返回默认空Cell，并且高度为0.01， 以保证返回值安全，避免崩溃问题。
- **轻量**: 该框架只有少量个文件 (包括.h文件)。

使用方法
==============

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
