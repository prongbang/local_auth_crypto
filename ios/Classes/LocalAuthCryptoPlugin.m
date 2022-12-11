#import "LocalAuthCryptoPlugin.h"
#if __has_include(<local_auth_crypto/local_auth_crypto-Swift.h>)
#import <local_auth_crypto/local_auth_crypto-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "local_auth_crypto-Swift.h"
#endif

@implementation LocalAuthCryptoPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftLocalAuthCryptoPlugin registerWithRegistrar:registrar];
}
@end
