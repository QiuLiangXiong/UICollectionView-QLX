Pod::Spec.new do |s|
s.name = 'UICollectionView-QLX'
s.version = '2.8.0'
s.license = 'MIT'
s.summary = '一款基于UICollectionView扩展，告别繁琐的代理，一个数组就能搞定数据源，数组自动同步视图， 更好用的UICollectionView'
s.homepage = 'https://github.com/QiuLiangXiong/UICollectionView-QLX'
s.authors = { 'QiuLiangXiong' => '820686089@qq.com' }
s.source = { :git => 'https://github.com/QiuLiangXiong/UICollectionView-QLX.git', :tag => "2.8.0" }
s.requires_arc = true
s.ios.deployment_target = '7.0'
s.source_files = 'UICollectionView+QLX/*.{h,m}'

s.requires_arc = true
s.xcconfig = { "OTHER_LINK_FLAG" => '$(inherited) -ObjC'}
s.framework  = "UIKit"  
  s.default_subspec = 'All'
  s.subspec 'All' do |ss|
    ss.dependency 'UICollectionView+QLX/Core' 
    ss.dependency 'UICollectionView+QLX/Sync' 
    ss.dependency 'UICollectionView+QLX/Delegator' 
    ss.dependency 'UICollectionView+QLX/Eidt'  
    ss.dependency 'UICollectionView+QLX/Resort'  
    ss.dependency 'UICollectionView+QLX/Transition'  
    ss.dependency 'UICollectionView+QLX/Wrap'  
  end


 s.subspec 'Core' do |ss|
 	 ss.dependency 'UICollectionView+QLX/Core' 
    ss.dependency 'UICollectionView+QLX/Sync' 
    ss.dependency 'UICollectionView+QLX/Delegator' 
    ss.dependency 'UICollectionView+QLX/Eidt'  
    ss.dependency 'UICollectionView+QLX/Resort'  
    ss.dependency 'UICollectionView+QLX/Transition'  
    ss.dependency 'UICollectionView+QLX/Wrap' 
    ss.source_files = "UICollectionView+QLX/Core/*.{h,m}"
 end
 s.subspec 'Sync' do |ss|
 	 ss.dependency 'UICollectionView+QLX/Core' 
    ss.dependency 'UICollectionView+QLX/Sync' 
    ss.dependency 'UICollectionView+QLX/Delegator' 
    ss.dependency 'UICollectionView+QLX/Eidt'  
    ss.dependency 'UICollectionView+QLX/Resort'  
    ss.dependency 'UICollectionView+QLX/Transition'  
    ss.dependency 'UICollectionView+QLX/Wrap' 
    ss.source_files = "UICollectionView+QLX/Sync/*.{h,m}"
 end
 s.subspec 'Delegator' do |ss|
 	 ss.dependency 'UICollectionView+QLX/Core' 
    ss.dependency 'UICollectionView+QLX/Sync' 
    ss.dependency 'UICollectionView+QLX/Delegator' 
    ss.dependency 'UICollectionView+QLX/Eidt'  
    ss.dependency 'UICollectionView+QLX/Resort'  
    ss.dependency 'UICollectionView+QLX/Transition'  
    ss.dependency 'UICollectionView+QLX/Wrap' 
    ss.source_files = "UICollectionView+QLX/Delegator/*.{h,m}"
 end
 s.subspec 'Eidt' do |ss|
 	 ss.dependency 'UICollectionView+QLX/Core' 
    ss.dependency 'UICollectionView+QLX/Sync' 
    ss.dependency 'UICollectionView+QLX/Delegator' 
    ss.dependency 'UICollectionView+QLX/Eidt'  
    ss.dependency 'UICollectionView+QLX/Resort'  
    ss.dependency 'UICollectionView+QLX/Transition'  
    ss.dependency 'UICollectionView+QLX/Wrap' 
    ss.source_files = "UICollectionView+QLX/Eidt/*.{h,m}"
 end
 s.subspec 'Resort' do |ss|
 	 ss.dependency 'UICollectionView+QLX/Core' 
    ss.dependency 'UICollectionView+QLX/Sync' 
    ss.dependency 'UICollectionView+QLX/Delegator' 
    ss.dependency 'UICollectionView+QLX/Eidt'  
    ss.dependency 'UICollectionView+QLX/Resort'  
    ss.dependency 'UICollectionView+QLX/Transition'  
    ss.dependency 'UICollectionView+QLX/Wrap' 
    ss.source_files = "UICollectionView+QLX/Resort/*.{h,m}"
 end
 s.subspec 'Transition' do |ss|
 	 ss.dependency 'UICollectionView+QLX/Core' 
    ss.dependency 'UICollectionView+QLX/Sync' 
    ss.dependency 'UICollectionView+QLX/Delegator' 
    ss.dependency 'UICollectionView+QLX/Eidt'  
    ss.dependency 'UICollectionView+QLX/Resort'  
    ss.dependency 'UICollectionView+QLX/Transition'  
    ss.dependency 'UICollectionView+QLX/Wrap' 
    ss.source_files = "UICollectionView+QLX/Transition/*.{h,m}"
 end
 s.subspec 'Wrap' do |ss|
 	 ss.dependency 'UICollectionView+QLX/Core' 
    ss.dependency 'UICollectionView+QLX/Sync' 
    ss.dependency 'UICollectionView+QLX/Delegator' 
    ss.dependency 'UICollectionView+QLX/Eidt'  
    ss.dependency 'UICollectionView+QLX/Resort'  
    ss.dependency 'UICollectionView+QLX/Transition'  
    ss.dependency 'UICollectionView+QLX/Wrap' 
    ss.source_files = "UICollectionView+QLX/Wrap/*.{h,m}"
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


