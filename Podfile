platform :ios, '10.0'
use_frameworks!

# ignore all warnings from all pods
inhibit_all_warnings!

def common_pods
  pod 'RxSwift', '4.3.0'
  pod 'RxCocoa', '4.3.0'
  pod 'SwiftyJSON', '4.1.0'
  pod 'Nuke', '7.5.1'
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

target 'Product' do
    workspace 'ModularApp.xcworkspace'
    project 'Product/Product.xcodeproj'
    inherit! :search_paths
    common_pods
end

target 'ProductTests' do
    workspace 'ModularApp.xcworkspace'
    project 'Product/Product.xcodeproj'
    inherit! :search_paths
    common_pods
    test_pods
end

target 'ExchangeRate' do
    workspace 'ModularApp.xcworkspace'
    project 'ExchangeRate/ExchangeRate.xcodeproj'
    inherit! :search_paths
    common_pods
end

target 'ExchangeRateTests' do
    workspace 'ModularApp.xcworkspace'
    project 'ExchangeRate/ExchangeRate.xcodeproj'
    inherit! :search_paths
    common_pods
    test_pods
end

target 'Commons' do
    workspace 'ModularApp.xcworkspace'
    project 'Commons/Commons.xcodeproj'
    inherit! :search_paths
    common_pods
end

target 'CommonsTests' do
    workspace 'ModularApp.xcworkspace'
    project 'Commons/Commons.xcodeproj'
    inherit! :search_paths
    common_pods
    test_pods
end

target 'TestHelpers' do
    workspace 'ModularApp.xcworkspace'
    project 'TestHelpers/TestHelpers.xcodeproj'
    inherit! :search_paths
    common_pods
end

# after pod install, override default configs for schemes or targets specified
debug_schemes = ['Debug']

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
          if debug_schemes.include? config.name
            # enable faster compilation by building only the active arch for debug schemes
            config.build_settings['GCC_OPTIMIZATION_LEVEL'] = '0';
            config.build_settings['SWIFT_OPTIMIZATION_LEVEL'] = '-Onone';
            config.build_settings['SWIFT_COMPILATION_MODE'] = 'wholemodule';
            config.build_settings['DEBUG_INFORMATION_FORMAT'] = 'dwarf';
            config.build_settings['ONLY_ACTIVE_ARCH'] = 'YES'
            config.build_settings['ENABLE_TESTABILITY'] = 'YES'
          end
        end
    end
end
