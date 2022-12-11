import 'local_auth_crypto_method_channel.dart';
import 'model/biometric_prompt_info.dart';

export 'model/biometric_prompt_info.dart';

abstract class LocalAuthCrypto {
  /// Constructs a LocalAuthPlus.
  LocalAuthCrypto() : super();

  static LocalAuthCrypto _instance = MethodChannelLocalAuthCrypto();

  /// The default instance of [LocalAuthCrypto] to use.
  ///
  /// Defaults to [MethodChannelLocalAuthCrypto].
  static LocalAuthCrypto get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [LocalAuthCrypto] when
  /// they register themselves.
  static set instance(LocalAuthCrypto instance) {
    _instance = instance;
  }

  Future<String?> encrypt(String payload) {
    throw UnimplementedError('encrypt() has not been implemented.');
  }

  Future<String?> authenticate(
    BiometricPromptInfo promptInfo,
    String cipherText,
  ) {
    throw UnimplementedError('authenticate() has not been implemented.');
  }
}
