Pod::Spec.new do |spec|
  spec.name         = "Cardimation"
  spec.version      = "0.0.1"
  spec.summary      = "Simple cards animation"
  spec.description  = "The Cardimation is a customizable view that can be used in any iOS app, with previous/forward swipe possibility."
  spec.homepage     = "https://github.com/Cyklet/Cardimation"
  spec.license      = { type: 'MIT', file: 'LICENSE' }
  spec.authors      = { "Petre Plotnic" => "www.linkedin.com/in/petre-plotnic" }
  spec.platform     = :ios, "12.0"
  spec.swift_version = "4.2"
  spec.requires_arc = true
  spec.source = { :git => "https://github.com/Cyklet/Cardimation.git", :tag => "#{spec.version}"}
  spec.source_files = "Cardimation/Cardimation/**/*.{h,swift}"
end
