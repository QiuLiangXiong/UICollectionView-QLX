Pod::Spec.new do |s|
s.name = 'UICollectionView-QLX'
s.version = '2.6.0'
s.license = 'MIT'
s.summary = '一款基于UICollectionView扩展，告别繁琐的代理，一个数组就能搞定数据源，数组自动同步视图， 更好用的UICollectionView'
s.homepage = 'https://github.com/QiuLiangXiong/UICollectionView-QLX'
s.authors = { 'QiuLiangXiong' => '820686089@qq.com' }
s.source = { :git => 'https://github.com/QiuLiangXiong/UICollectionView-QLX.git', :tag => "2.6.0" }
s.requires_arc = true
s.ios.deployment_target = '7.0'
s.source_files = 'UICollectionView+QLX/*.{h,m}'

s.requires_arc = true
s.xcconfig = { "OTHER_LINK_FLAG" => '$(inherited) -ObjC'}
s.framework  = "UIKit"  


s.subspec 'Other' do |ss|
    ss.source_files = "UICollectionView+QLX/Other/*.{h,m}"

    ss.subspec 'edit' do |sss|
        sss.source_files = "UICollectionView+QLX/Other/edit/*.{h,m}"
        sss.dependency 'UICollectionView+QLX'
        sss.dependency 'UICollectionView+QLX/Other'
    end

    ss.subspec 'resort' do |sss|
        sss.source_files = "UICollectionView+QLX/Other/resort/*.{h,m}"
        sss.dependency 'UICollectionView+QLX'
        sss.dependency 'UICollectionView+QLX/Other'
    end

    ss.subspec 'sync' do |sss|
        sss.source_files = "UICollectionView+QLX/Other/sync/*.{h,m}"
        sss.dependency 'UICollectionView+QLX'
        sss.dependency 'UICollectionView+QLX/Other'
    end
    ss.subspec 'transition' do |sss|
        sss.source_files = "UICollectionView+QLX/Other/transition/*.{h,m}"
        sss.dependency 'UICollectionView+QLX'
        sss.dependency 'UICollectionView+QLX/Other'
    end
     ss.subspec 'wrap' do |sss|
        sss.source_files = "UICollectionView+QLX/Other/wrap/*.{h,m}"
        sss.dependency 'UICollectionView+QLX'
        sss.dependency 'UICollectionView+QLX/Other'
    end

  end

end



