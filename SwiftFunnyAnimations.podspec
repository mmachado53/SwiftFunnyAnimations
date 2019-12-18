#
# Be sure to run `pod lib lint SwiftFunnyAnimations.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SwiftFunnyAnimations'
  s.version          = '0.1.0'
  s.summary          = 'For now only 2 simple animations set.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Its simple set of particle animations for iOS in swift 4.0
                       DESC

  s.homepage         = 'https://github.com/mmachado53/SwiftFunnyAnimations'
  s.screenshots     = 'https://raw.githubusercontent.com/mmachado53/SwiftFunnyAnimations/develop/readmefiles/1.gif'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'mmachado53' => 'mmachado53@gmail.com' }
  s.source           = { :git => 'https://github.com/mmachado53/SwiftFunnyAnimations.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'
  s.swift_versions = '4.0'

  s.source_files = 'SwiftFunnyAnimations/Classes/**/*'
  
  # s.resource_bundles = {
  #   'SwiftFunnyAnimations' => ['SwiftFunnyAnimations/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
