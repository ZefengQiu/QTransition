
Pod::Spec.new do |s|
  s.name             = 'QTransition'
  s.version          = '0.1.2'
  s.summary          = 'A Library help in view transitioning in iOS.'
  s.homepage         = 'https://github.com/ZefengQiu/QTransition'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'ZefengQiu' => 'z9qiu@uwaterloo.ca' }
  s.source           = { :git => 'https://github.com/ZefengQiu/QTransition.git', :tag => s.version.to_s }
  s.ios.deployment_target = '10.0'
  s.source_files = 'QTransition/Classes/**/*'
  s.frameworks = 'UIKit'
  
  # s.resource_bundles = {
  #   'QTransition' => ['QTransition/Assets/*.png']
  # }

end
