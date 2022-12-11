import 'local_auth_plus_method_channel.dart';
import 'model/biometric_prompt_info.dart';

export 'model/biometric_prompt_info.dart';

abstract class LocalAuthPlus {
  /// Constructs a LocalAuthPlus.
  LocalAuthPlus() : super();

  static LocalAuthPlus _instance = MethodChannelLocalAuthPlus();

  /// The default instance of [LocalAuthPlus] to use.
  ///
  /// Defaults to [MethodChannelLocalAuthPlus].
  static LocalAuthPlus get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [LocalAuthPlus] when
  /// they register themselves.
  static set instance(LocalAuthPlus instance) {
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
