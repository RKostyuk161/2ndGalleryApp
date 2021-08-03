# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target '2ndGalleryApp' do

  use_frameworks!
  pod 'Kingfisher'
  pod 'RxNetworkApiClient'
  pod 'R.swift'
  pod 'RxSwift', '~> 5.0.1', :inhibit_warnings => true
  pod 'DITranquillity', :inhibit_warnings => true
  pod "DBDebugToolkit", :inhibit_warnings => true

end

deployment_target = '12.0'

post_install do |installer|
    installer.generated_projects.each do |project|
        project.targets.each do |target|
            target.build_configurations.each do |config|
                config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = deployment_target
            end
        end
        project.build_configurations.each do |config|
            config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = deployment_target
        end
    end
end
