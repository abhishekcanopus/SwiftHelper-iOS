
Pod::Spec.new do |s|

  s.name         = "SwiftHelper-iOS"
  s.version      = "1.0.0"
  s.summary      = "This Project has some very userfull swift helper classes and tools which needed almost in all projects."

  s.homepage     = "https://github.com/abhishekcanopus/SwiftHelper-iOS"

  s.license      = "MIT"

  s.author             = { "abhishekcanopus" => "abhishek.chandani@canopusinfosystems.com" }

  s.source       = { :git => "https://github.com/abhishekcanopus/SwiftHelper-iOS.git", :tag => s.version.to_s }

  s.source_files  = "Source/*.swift"
  s.platform     = :ios, "10.0"

end
