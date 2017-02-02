# Uncomment this line to define a global platform for your project
# platform :ios, '9.0'

target 'SuperNOVA-app' do
  # Comment this line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for SuperNOVA-app
  source 'https://github.com/CocoaPods/Specs.git'
  platform :ios, '9.3'
  pod 'GoogleMaps'
  pod 'Alamofire'
  pod 'ObjectMapper', '~> 2.0.0'
  pod 'SVProgressHUD'

  target 'SuperNOVA-appTests' do
    inherit! :search_paths
    # Pods for testing
    pod 'Quick','~> 1.0.0'
    pod 'Nimble','~> 5.0.0'
    pod 'Mockingjay'
    source 'https://github.com/CocoaPods/Specs.git'
    platform :ios, '9.3'
    pod 'GoogleMaps'
  end

  target 'SuperNOVA-appUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |configuration|
            configuration.build_settings['SWIFT_VERSION'] = "3.0"
        end
    end
end
