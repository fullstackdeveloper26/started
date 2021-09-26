# Uncomment the next line to define a global platform for your project
platform :ios, '9.0'
inhibit_all_warnings!

install! 'cocoapods', :deterministic_uuids => false

target 'started' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Networking
  pod 'Alamofire'
  pod 'SwiftyJSON'
  pod 'RealmSwift'

  pod 'SDWebImage'
  pod 'MBProgressHUD', '~> 1.2.0'

  target 'startedTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'startedUITests' do
    # Pods for testing
  end
end

