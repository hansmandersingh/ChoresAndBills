# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'ChoresAndBills' do

  use_modular_headers!
  use_frameworks!
  pod 'GoogleSignIn'
  pod 'FirebaseAuth'
  pod 'FirebaseFirestore'
 


  # Pods for ChoresAndBills

end

post_install do |installer|
  # Existing code to modify build settings
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['DEBUG_INFORMATION_FORMAT'] = 'dwarf-with-dsym'
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '11.0'
      
      if target.respond_to?(:product_type) && target.product_type == "com.apple.product-type.bundle"
        config.build_settings['CODE_SIGNING_ALLOWED'] = 'NO'
      end
    end

    # New code to modify the 'BoringSSL-GRPC' target's compiler flags
    if target.name == 'BoringSSL-GRPC'
      target.source_build_phase.files.each do |file|
        if file.settings && file.settings['COMPILER_FLAGS']
          flags = file.settings['COMPILER_FLAGS'].split
          flags.reject! { |flag| flag == '-GCC_WARN_INHIBIT_ALL_WARNINGS' }
          file.settings['COMPILER_FLAGS'] = flags.join(' ')
        end
      end
    end
  end
end