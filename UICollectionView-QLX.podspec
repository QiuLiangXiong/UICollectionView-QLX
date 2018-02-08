Pod::Spec.new do |s|
s.name = 'UICollectionView-QLX'
s.version = '2.5.0'
s.license = 'MIT'
s.summary = '一款基于UICollectionView扩展，告别繁琐的代理，一个数组就能搞定数据源，数组自动同步视图， 更好用的UICollectionView'
s.homepage = 'https://github.com/QiuLiangXiong/UICollectionView-QLX'
s.authors = { 'QiuLiangXiong' => '820686089@qq.com' }
s.source = { :git => 'https://github.com/QiuLiangXiong/UICollectionView-QLX.git', :tag => "2.5.0" }
s.requires_arc = true
s.ios.deployment_target = '7.0'
s.source_files = 'UICollectionView+QLXDemo/UICollectionView+QLX/**/*.{h,m,mm,c}','UICollectionView+QLXDemo/UICollectionView+QLX/*','UICollectionView+QLXDemo/UICollectionView+QLX/Other/**/*.{h,m,mm,c}'
s.requires_arc = true
s.xcconfig = { "OTHER_LINK_FLAG" => '$(inherited) -ObjC'}
s.framework  = "UIKit"  
end



