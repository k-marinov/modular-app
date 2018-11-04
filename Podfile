platform :ios, '10.0'
use_frameworks!

# ignore all warnings from all pods
inhibit_all_warnings!

def common_pods
  pod 'RxSwift', '4.3.0'
  pod 'RxCocoa', '4.3.0'
  pod 'SwiftyJSON', '4.1.0'
  pod 'Kingfisher'
end

def test_pods
  pod 'OHHTTPStubs/Swift', '6.1.0'
  pod 'Quick'
  pod 'Nimble'
end

target 'ModularApp' do
  common_pods
end

target 'ModularAppTests' do
  inherit! :search_paths
  common_pods
  test_pods
end

# after pod install, override default configs for schemes or targets specified
debug_schemes = ['Debug']

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
          if debug_schemes.include? config.name
            # enable faster compilation by building only the active arch for debug schemes
            config.build_settings['ONLY_ACTIVE_ARCH'] = 'YES'
            config.build_settings['ENABLE_TESTABILITY'] = 'YES'
          end
        end
    end
end
