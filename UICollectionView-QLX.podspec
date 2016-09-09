Pod::Spec.new do |s|
s.name = 'UICollectionView-QLX'
s.version = '1.0.0'
s.license = 'MIT'
s.summary = '数据即视图 映射'
s.homepage = 'https://github.com/QiuLiangXiong/UICollectionView-QLX'
s.authors = { 'QiuLiangXiong' => '820686089@qq.com' }
s.source = { :git => 'https://github.com/QiuLiangXiong/UICollectionView-QLX.git', :tag => "1.0.0" }
s.requires_arc = true
s.ios.deployment_target = '7.0'
s.source_files = 'UICollectionView+QLXDemo/UICollectionView+QLX/*'
end
