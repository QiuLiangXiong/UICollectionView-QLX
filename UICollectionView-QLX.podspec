Pod::Spec.new do |s|
s.name = 'UICollectionView-QLX'
s.version = '2.0.0'
s.license = 'MIT'
s.summary = '数据即视图 映射'
s.description  = '基于UICollectionView的扩展，更好用的UICollectionView'
s.homepage = 'https://github.com/QiuLiangXiong/UICollectionView-QLX'
s.authors = { 'QiuLiangXiong' => '820686089@qq.com' }
s.source = { :git => 'https://github.com/QiuLiangXiong/UICollectionView-QLX.git', :tag => "2.0.0" }
s.requires_arc = true
s.ios.deployment_target = '7.0'
s.source_files = 'UICollectionView+QLXDemo/UICollectionView+QLX/**/*.{h,m,mm,c}'
s.requires_arc = true
s.xcconfig = { "OTHER_LINK_FLAG" => '$(inherited) -ObjC'}
s.framework  = "UIKit"
end
