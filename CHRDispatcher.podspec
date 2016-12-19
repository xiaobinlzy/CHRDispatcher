#
# Be sure to run `pod lib lint CHRDispatcher.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'CHRDispatcher'
  s.version          = '0.1.1'
  s.summary          = 'Dispatcher是统一调用（跳转）组件。'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Dispatcher是统一调用（跳转）组件，用于动态隐式的通讯、跳转、调用。
                       DESC

  s.homepage         = 'http://gitlab.58corp.com/ChinaHR-iOS/CHRDispatcher'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'xiaobinlzy' => 'xiaobinlzy@163.com' }
  s.default_subspec  = 'Binary'
  s.source  = { :git => 'http://gitlab.58corp.com/ChinaHR-iOS/CHRDispatcher.git', :tag => s.version.to_s }
  s.public_header_files = 'CHRDispatcher/Classes/*.h'
  s.source_files = 'CHRDispatcher/Classes/*.h'
  s.ios.deployment_target = '8.0'
  
  s.subspec 'Source' do |source| 
    source.source_files = 'CHRDispatcher/Classes/**'
    source.requires_arc = true
  end

  s.subspec 'Binary' do |binary|
    binary.vendored_libraries = 'libCHRDispatcher.a'
  end
  
end
