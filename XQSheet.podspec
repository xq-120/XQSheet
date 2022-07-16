Pod::Spec.new do |s|

  s.name         = "XQSheet"
  s.author       = { "xq-120" => "1204556447@qq.com" }
  s.version      = "2.1.2"
  s.summary      = "A convenient sheet presented from bottom."
  s.description  = <<-DESC
                   A convenient sheet presented from bottom, which implement by Objective-C.
                   DESC

  s.homepage     = "https://github.com/xq-120/XQSheet"
  
  s.license      = "MIT"
  
  s.platform     = :ios, "9.0"

  s.source       = { :git => "https://github.com/xq-120/XQSheet.git", :tag => s.version.to_s }
  s.source_files  = "XQSheet/*"
  
  s.frameworks = "Foundation", "UIKit"
  
  s.requires_arc = true
  s.swift_versions = "5.0"
  s.dependency "XQGrandPopupView", "~> 1.0.1"

end
