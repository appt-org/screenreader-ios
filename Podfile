source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '12.0'
use_frameworks!

target 'ScreenReader' do
  #use_frameworks!
  pod 'Firebase/Crashlytics'
  pod 'Firebase/Analytics'
  pod 'R.swift'
end

# Some older pods don't support some architectures, resolve with deployment target
post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
    end
  end
end
