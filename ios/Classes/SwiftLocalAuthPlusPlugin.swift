import Flutter
import UIKit
import SecureBiometricSwift

public class SwiftLocalAuthPlusPlugin: NSObject, FlutterPlugin {
    
    private var secureBiometricSwift: SecureBiometricSwift? = nil
    
    init(secureBiometricSwift: SecureBiometricSwift) {
        self.secureBiometricSwift = secureBiometricSwift
    }
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "local_auth_plus", binaryMessenger: registrar.messenger())
        
        let secureBiometricSwift = LocalSecureBiometricSwift()
        
        let instance = SwiftLocalAuthPlusPlugin(secureBiometricSwift: secureBiometricSwift)
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let args = call.arguments as? Dictionary<String, String>
        
        switch call.method {
        case LocalAuthMethod.ENCRYPT:
            if args != nil {
                guard let bioPayload = args![LocalAuthArgs.BIO_PAYLOAD] else {
                    result(nil)
                    return
                }
                let cipherText = secureBiometricSwift?.encrypt(plainText: bioPayload)
                result(cipherText)
            } else {
                result(nil)
            }
            break
        case LocalAuthMethod.AUTHENTICATE:
            if args != nil {
                guard let bioCipherText = args![LocalAuthArgs.BIO_CIPHER_TEXT] else {
                    result(nil)
                    return
                }
                let plainText = secureBiometricSwift?.decrypt(cipherText: bioCipherText)
                result(plainText)
            } else {
                result(nil)
            }
            break
        default:
            result(nil)
        }
    }
    
}
