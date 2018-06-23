#
# Be sure to run `pod lib lint JWInfiniteCollectionView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'JWInfiniteCollectionView'
  s.version          = '0.1.1'
  s.summary          = 'JWInfiniteCollectionView provides a convenient way to have a infinitely-scrolling collection view.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC

  Sometimes, your app’s UX designer wants infinite scroll for one of your collection views when the data displayed is limited. When a user scrolls to the very end of the data set, the first piece of data reappears on screen; if the use scrolls the other way, the last piece of data reappears.Traditionally, the solution for an infinite UICollectionView is to have a large duplicated data set (for example, 1000 * original data set) to trick the user into believing the collection view is infinite. 
  But, a large duplicated data will inevitably introduce extra overhead by having a large amount of UICollectionViewLayoutAttributes. Besides, what if the user is bored to death and just sits there for a day to scroll your collection view? The chance for this to happen might be small, but, after all, having a large duplicated data set is not a very elegant solution.
  JWInfiniteCollectionView pads only a few extra duplicated items both at the start and end of your data set. In this way, it avoids the some overhead introduced by having a large duplicated data set. 
                       DESC

  s.homepage         = 'https://github.com/Alex1989Wang/JWInfiniteCollectionView'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Alex1989Wang' => 'alex1989wang@gmail.com' }
  s.source           = { :git => 'https://github.com/Alex1989Wang/JWInfiniteCollectionView.git', :tag => s.version.to_s }
  s.social_media_url = 'http://www.awsomejiang.com/'

  s.ios.deployment_target = '8.0'

  s.source_files = 'JWInfiniteCollectionView/Classes/**/*'
  
  # s.resource_bundles = {
  #   'JWInfiniteCollectionView' => ['JWInfiniteCollectionView/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
