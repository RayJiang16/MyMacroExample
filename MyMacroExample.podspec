Pod::Spec.new do |s|
  s.name             = 'MyMacroExample'
  s.version          = '0.1.0'
  s.summary          = 'A proof of concept macro to show they can work with cocoapods.'
  s.description      = <<-DESC
A proof of concept macro to show they can work with cocoapods.
                       DESC
  s.homepage         = 'https://github.com/RayJiang16/MyMacroExample'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'RayJiang16' => 'is.rayjiang@outlook.com', }
  s.source           = { :git => 'https://github.com/RayJiang16/MyMacroExample', :tag => s.version.to_s }
  s.ios.deployment_target = '13.0'
  # 1
  s.source_files = ['Sources/MyMacro/**/*']
  s.swift_version = "5.9"
  # 2
  s.preserve_paths = ["macros/MyMacroMacros"]
  # 3
  s.pod_target_xcconfig = {
    'OTHER_SWIFT_FLAGS' => '-load-plugin-executable ${PODS_ROOT}/MyMacroExample/macros/MyMacroMacros#MyMacroMacros'
  }
  # 4
  s.user_target_xcconfig = {
    'OTHER_SWIFT_FLAGS' => '-load-plugin-executable ${PODS_ROOT}/MyMacroExample/macros/MyMacroMacros#MyMacroMacros'
  }
end
