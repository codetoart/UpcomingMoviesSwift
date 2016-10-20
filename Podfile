
use_frameworks!

target 'UpcomingMovies' do

	pod 'Alamofire', '~> 3.5.0'
	pod 'SwiftyJSON', '~> 2.4.0'
	pod 'AsyncImageView', '1.6'
	pod 'HCSStarRatingView', '~> 1.4.3'
	pod 'SnapKit', '0.22.0'
	pod 'ImageSliderView', :git => 'git@github.com:codetoart/ImageSliderView.git'

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '2.3'
    end
  end
end

