#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint local_auth_crypto.podspec --verbose --no-clean --allow-warnings` to validate before publishing.
# Run `pod install --repo-update --verbose` to uppdate new version.
#
Pod::Spec.new do |s|
  s.name             = 'local_auth_crypto'
  s.version          = '1.0.0'
  s.summary          = 'Android and iOS devices to allow Local Authentication + Cryptography via Biometric.'
  s.description      = <<-DESC
Android and iOS devices to allow Local Authentication + Cryptography via Biometric.
                       DESC
  s.homepage         = 'https://github.com/prongbang/local_auth_crypto'
  s.license          = { :file => '../LICENSE' }
  s.author           = 'prongbang'
  s.source           = { :path => '.' }
  s.source_files     = 'Classes/**/*'
  s.dependency       'Flutter'
  s.dependency       'SecureBiometricSwift', '~> 0.0.2'
  s.platform         = :ios, '11.0'
  s.swift_version    = ["4.0", "4.1", "4.2", "5.0", "5.1", "5.2", "5.3", "5.4", "5.5"]
end