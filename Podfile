platform :ios, '10.0'
inhibit_all_warnings!
use_frameworks!

target 'ComplexCollectionViewDemo' do

  #Tools
  pod 'R.swift', '~> 4.0.0'
  pod 'SwiftLint', '~> 0.25.1'

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    puts "#{target.name}"
  end
end
