import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:local_auth_plus/local_auth_plus.dart';

/// An implementation of [LocalAuthPlus] that uses method channels.
class MethodChannelLocalAuthPlus extends LocalAuthPlus {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('local_auth_plus');

  @override
  Future<String?> encrypt(String payload) async {
    return await methodChannel.invokeMethod('encrypt', {
      'payload': payload,
    });
  }

  @override
  Future<String?> authenticate(
    BiometricPromptInfo promptInfo,
    String cipherText,
  ) async {
    dynamic arguments = {
      'cipherText': cipherText,
    };
    if (promptInfo.title != null) {
      arguments['title'] = promptInfo.title;
    }
    if (promptInfo.subtitle != null) {
      arguments['subtitle'] = promptInfo.subtitle;
    }
    if (promptInfo.description != null) {
      arguments['description'] = promptInfo.description;
    }
    if (promptInfo.negativeButton != null) {
      arguments['negativeButton'] = promptInfo.negativeButton;
    }
    return await methodChannel.invokeMethod('authenticate', arguments);
  }
}
