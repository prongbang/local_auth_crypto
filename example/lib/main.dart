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
  final String _biometricToken = 'TOKEN FROM SERVER';
  String? _biometricTokenCipherText = '';
  String? _biometricTokenPlainText = '';
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
        body: SafeArea(
          child: Container(
            margin: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'TOKEN',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                CardBox(content: _biometricToken),
                const SizedBox(height: 16),
                Text(
                  'CIPHER TEXT',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                CardBox(content: _biometricTokenCipherText ?? ''),
                const SizedBox(height: 16),
                Text(
                  'PLAIN TEXT',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                CardBox(content: _biometricTokenPlainText ?? ''),
                const SizedBox(height: 46),
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          _processDecrypt();
                        },
                        icon: const Icon(Icons.fingerprint_outlined),
                        iconSize: 80,
                      ),
                      const Text('Decrypt by Biometric'),
                    ],
                  ),
                ),
              ],
            ),
          ),
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
      _biometricTokenCipherText ?? '',
    );
    setState(() {});
  }
}

class CardBox extends StatelessWidget {
  final String content;

  const CardBox({Key? key, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(content),
      ),
    );
  }
}
