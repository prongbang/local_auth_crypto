# local_auth_plus

[![pub package](https://img.shields.io/pub/v/local_auth_plus.svg)](https://pub.dartlang.org/packages/local_auth_plus)

Android and iOS devices to allow Local Authentication + Cryptography via Biometric.

![Screenshot](screenshot/screenshot.jpg)

## Features

#### New instance

```dart
final localAuthPlus = LocalAuthPlus.instance;
```

#### Encrypt

```dart
await localAuthPlus.encrypt(message);
```

### PromptInfo

```dart
BiometricPromptInfo(
  title: 'BIOMETRIC',
  subtitle: 'Please scan biometric to decrypt',
  negativeButton: 'CANCEL',
);
```

### Decrypt

```dart
await localAuthPlus.authenticate(promptInfo, cipherText);
```

## Getting started

It is really easy to use! You should ensure that you add the `local_auth_plus` as a dependency in your flutter project.

```yaml
local_auth_plus: "^1.0.0"
```

## Usage

### Flutter

- Encrypt

```dart
final localAuthPlus = LocalAuthPlus.instance;

final message = 'TOKEN';
final cipherText = await localAuthPlus.encrypt(message);
```

- Decrypt

```dart
final localAuthPlus = LocalAuthPlus.instance;

final promptInfo = BiometricPromptInfo(
  title: 'BIOMETRIC',
  subtitle: 'Please scan biometric to decrypt',
  negativeButton: 'CANCEL',
);
final plainText = await localAuthPlus.authenticate(promptInfo, cipherText);
```

### Android

- Update code in `MainActivity.kt` file

```kotlin
import io.flutter.embedding.android.FlutterFragmentActivity

class MainActivity : FlutterFragmentActivity()
```

- Add use-permissions in `AndroidManifest.xml` file

```xml
<uses-permission android:name="android.permission.USE_BIOMETRIC" />
```

### iOS

- Add privacy in `info.plist` file

```xml
<dict>
  <key>NSFaceIDUsageDescription</key>
  <string>This application wants to access your TouchID or FaceID</string>
</dict>
```