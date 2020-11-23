# Uncomment the next line to define a global platform for your project
# platform :ios, '10.0'

#target 'Tinder' do

  use_frameworks!
  def architecture
    pod 'RIBs', :git => 'https://github.com/uber/RIBs.git', :branch => 'master'
  end

  def realm
    pod 'Realm'
    pod 'RealmSwift'
end

  def database
    realm
  end

  def rx
    pod 'RxSwift'
    pod 'RxCocoa'
    pod 'RxDataSources'
    pod 'Action'
    pod 'RxSwiftExt'
    pod 'RxOptional'
  end


  workspace 'Tinder.xcworkspace'
  target :'Tinder' do
    project 'Tinder.xcodeproj'
    inherit! :search_paths

    architecture
    rx
    database
    
    pod 'R.swift'

    # Tools
    pod 'SwiftLint', :configurations => ['Debug']
    pod 'Kingfisher'
    pod 'Action'
    pod 'Alamofire'
    pod 'ObjectMapper'
  end

  target 'TinderTests' do
    project 'Tinder.xcodeproj'
    inherit! :search_paths
    # Pods for testing
  end

  abstract_target 'APP' do
  target :'HNCommon' do
    project 'APP/HNCommon/HNCommon.xcodeproj'
    inherit! :search_paths
    architecture
    rx
  end

  target :'HNService' do
    project 'APP/HNService/HNService.xcodeproj'
    inherit! :search_paths

    pod 'Alamofire'
    pod 'ObjectMapper'
    rx
  end
 end

#end
