#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint gst_mobile.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'gst_mobile'
  s.version          = '0.0.1'
  s.summary          = 'A new Flutter FFI plugin project.'
  s.description      = <<-DESC
A new Flutter FFI plugin project.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }

  # This will ensure the source files in Classes/ are included in the native
  # builds of apps using this FFI plugin. Podspec does not support relative
  # paths, so Classes contains a forwarder C file that relatively imports
  # `../src/*` so that the C sources can be shared among all target platforms.
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '12.0'

  s.xcconfig = {
    'FRAMEWORK_SEARCH_PATHS' => '"${HOME}/Library/Developer/GStreamer/iPhone.sdk"',
  }

  # Flutter.framework does not contain a i386 slice.
  # Ignored arm64 https://gitlab.freedesktop.org/gstreamer/gstreamer/-/issues/3084
  s.pod_target_xcconfig = { 
    'DEFINES_MODULE' => 'YES', 
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386 arm64',
    'HEADER_SEARCH_PATHS' => '"${HOME}/Library/Developer/GStreamer/iPhone.sdk/GStreamer.framework/Headers"',
    'FRAMEWORK_SEARCH_PATHS' => '"${HOME}/Library/Developer/GStreamer/iPhone.sdk"',
  }
  s.frameworks = ['GStreamer', 'CoreFoundation', 'CoreMedia', 'CoreVideo', 'AudioToolbox', 'VideoToolbox', 'AVFoundation', 'AssetsLibrary', 'OpenGLES']
  s.libraries  = ['iconv']
  s.swift_version = '5.0'

end
