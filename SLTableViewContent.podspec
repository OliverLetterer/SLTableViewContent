Pod::Spec.new do |s|
  s.name         = "SLTableViewContent"
  s.version      = "1.0.0"
  s.summary      = "Multiple contents for one UITableViewController."
  s.homepage     = "https://github.com/OliverLetterer/SLTableViewContent"

  s.license      = 'MIT'

  s.author       = { "Oliver Letterer" => "oliver.letterer@gmail.com" }

  s.source       = { :git => "https://github.com/OliverLetterer/SLTableViewContent.git", :tag => s.version.to_s }
  s.platform     = :ios, '5.0'

  s.source_files  = 'SLTableViewContent/*.{h,m}'

  s.requires_arc = true
  s.frameworks = 'Foundation', 'UIKit', 'QuartzCore'
end
