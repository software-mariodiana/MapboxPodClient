# Uncomment the next line to define a global platform for your project
platform :ios, '10.2'

target 'MapboxPodClient' do
  # Comment the next line if you don't want to use dynamic frameworks
  #use_frameworks!

  # Pods for MapboxPodClient
  # https://github.com/software-mariodiana/mapbox-ios-sdk-legacy
  #
  pod 'Mapbox-iOS-SDK', :path => '../mapbox-ios-sdk-legacy', :share_schemes_for_development_pods => true

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['ENABLE_BITCODE'] = 'NO'
      # The Proj4 library is not where the Mapbox Podspec says it
      # is, because the Mapbox pod is not where it usually is.
      xcconfig_path = config.base_configuration_reference.real_path
      xcconfig = File.read(xcconfig_path)
      xcconfig_mod = xcconfig.gsub(
          "\${PODS_ROOT}\/Mapbox-iOS-SDK\/Proj4", 
          "\${PODS_ROOT}\/\.\.\/\.\.\/mapbox-ios-sdk-legacy\/Proj4")
      File.open(xcconfig_path, "w") { |file| file << xcconfig_mod }
    end
  end
end
