#
# Be sure to run `pod lib lint ABC.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#
#use tag
Pod::Spec.new do |s|
  s.name             = 'ABC'
  s.version          = '0.1.4.Freamwork'
  #s.version          = '0.1.4.Binary'
  #s.version          = '0.1.4'
  s.summary          = 'A short description of ABC.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/srs888001/BinaryLib'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '603722906@qq.com' => 'sirusheng@agora.io' }
  s.source           = { :git => 'https://github.com/srs888001/BinaryLib.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'

  if s.version.to_s.include?'Binary'
    puts '-------------------------------------------------------------------'
    puts 'Notice:ABC is binary now'
    puts '-------------------------------------------------------------------'
    
    s.prepare_command = '/bin/bash ./build_lib.sh'
    s.source_files = 'Pod/Products/include/**'
    s.ios.vendored_libraries = 'Pod/Products/lib/*.a'
    s.public_header_files = 'Pod/Products/include/*.h'
  
    s.pod_target_xcconfig = {
      'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64'
    }
    s.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
    
  elsif s.version.to_s.include?'Freamwork'
    puts '-------------------------------------------------------------------'
    puts 'Notice:ABC is freamWork now'
    puts '-------------------------------------------------------------------'
    
    s.prepare_command = '/bin/bash ./build_freamwork.sh'
    s.vendored_framework = 'Pod/Products/*.framework'

    s.pod_target_xcconfig = {
      'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64'
    }
    s.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }

  else
    puts '-------------------------------------------------------------------'
    puts 'Notice:ABC is source code now'
    puts '-------------------------------------------------------------------'

    s.source_files = 'ABC/Classes/**/*'
end

  # s.resource_bundles = {
  #   'ABC' => ['ABC/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
