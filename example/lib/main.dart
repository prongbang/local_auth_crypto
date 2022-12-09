import 'package:flutter/material.dart';
import 'package:local_auth_plus/local_auth_plus.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _biometricToken = 'BIOMETRIC API FROM SERVER';
  var _biometricTokenCipherText = '';
  var _biometricTokenPlainText = '';
  final _localAuthPlus = LocalAuthPlus.instance;

  @override
  void initState() {
    super.initState();
    _processEncrypt();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('LOCAL AUTH PLUS'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('BIO TOKEN SOURCE: $_biometricToken'),
            const SizedBox(height: 16),
            Text('BIO TOKEN CIPHER TEXT: $_biometricTokenCipherText'),
            const SizedBox(height: 16),
            Text('BIO TOKEN DECRYPTED: $_biometricTokenPlainText'),
            TextButton(
              child: const Text('Decrypt by Biometric'),
              onPressed: () {
                _processDecrypt();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _processEncrypt() async {
    _biometricTokenCipherText = await _localAuthPlus.encrypt(_biometricToken);
    setState(() {});
  }

  void _processDecrypt() async {
    final promptInfo = BiometricPromptInfo(
      title: 'BIOMETRIC',
      subtitle: 'Please scan biometric to decrypt',
      negativeButton: 'CANCEL',
    );
    _biometricTokenPlainText = await _localAuthPlus.authenticate(
      promptInfo,
      _biometricTokenCipherText,
    );
    setState(() {});
  }
}
