# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Learning' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Learning
  pod 'Firebase/Core'
  pod 'Firebase/Auth'
  pod 'Firebase/Database'

  target 'LearningEarlGreyTests' do
    project 'Learning'
    inherit! :search_paths
    # Pods for testing
    use_frameworks!
    pod 'EarlGrey'
    pod 'Firebase'
  end

 
  target 'LearningTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'LearningUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end
