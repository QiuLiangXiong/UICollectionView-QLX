Pod::Spec.new do |s|
s.name = 'UICollectionView-QLX'
s.version = '2.9.1'
s.license = 'MIT'
s.summary = '一款基于UICollectionView扩展，告别繁琐的代理，一个数组就能搞定数据源，数组自动同步视图， 更好用的UICollectionView'
s.homepage = 'https://github.com/QiuLiangXiong/UICollectionView-QLX'
s.authors = { 'QiuLiangXiong' => '820686089@qq.com' }
s.source = { :git => 'https://github.com/QiuLiangXiong/UICollectionView-QLX.git', :tag => "2.9.1" }
s.requires_arc = true
s.ios.deployment_target = '7.0'
s.source_files = 'UICollectionView-QLX/*.{h,m}'

s.requires_arc = true
s.xcconfig = { "OTHER_LINK_FLAG" => '$(inherited) -ObjC'}
s.framework  = "UIKit"  

s.subspec 'Core' do |ss|	
    ss.source_files = "UICollectionView-QLX/Core/*.{h,m}", "UICollectionView-QLX/Sync/*.{h,m}","UICollectionView-QLX/Common/*.{h,m}","UICollectionView-QLX/Delegator/*.{h,m}","UICollectionView-QLX/Edit/*.{h,m}","UICollectionView-QLX/Resort/*.{h,m}","UICollectionView-QLX/Transition/*.{h,m}","UICollectionView-QLX/Wrap/*.{h,m}"
 end



end

    # ss.subspec 'edit' do |sss|
    #     sss.source_files = "UICollectionView+QLX/Other/edit/*.{h,m}"
     
    # end

    # ss.subspec 'resort' do |sss|
    #     sss.source_files = "UICollectionView+QLX/Other/resort/*.{h,m}"
        
    # end

    # ss.subspec 'sync' do |sss|
    #     sss.source_files = "UICollectionView+QLX/Other/sync/*.{h,m}"
       
    # end
    # ss.subspec 'transition' do |sss|
    #     sss.source_files = "UICollectionView+QLX/Other/transition/*.{h,m}"
        
    # end
    #  ss.subspec 'wrap' do |sss|
    #     sss.source_files = "UICollectionView+QLX/Other/wrap/*.{h,m}"
       
    # end


