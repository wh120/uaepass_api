# uaepass_api

Un-official UAE PASS Flutter package for authentication capability.


## Why uaepass_api?

- 🚀 Easy to use
- ⚡  Fullscreen window
- ❤ Supports app installed scenario
- ❤ Supports app not installed scenario
- 🛡️ Null safety

## Getting Started

- Add the plugin to your pubspec.yaml file

```yaml
uaepass_api: ^1.0.3
```

- Run flutter pub get

```bash
flutter pub get
```

- Import the package

```dart
import 'package:uaepass_api/uaepass_api.dart';

UaePassAPI uaePassAPI =UaePassAPI(
    clientId: "<clientId>",
    redirectUri: "<redirectUri>",
    clientSecrete: "<clientSecrete>",
    appScheme: "<Your App Scheme>",
    language: "en",
    isProduction: false);
```



- Get user code

```dart
    String? code =  await uaePassAPI.signIn(context);
```


- Get user AccessToken

```dart
    String? token =  await uaePassAPI.getAccessToken(code);
```


- Get user info

```dart
    String? token =  await uaePassAPI.getUserProfile(token);
```

- Logout

```dart
  await uaePassAPI.logout(context);
```




## iOS Setup

- Add the following to your Info.plist file

```xml
  <key>LSApplicationQueriesSchemes</key>
    <array>
      <string>uaepass</string>
      <string>uaepassqa</string>
      <string>uaepassdev</string>
      <string>uaepassstg</string>
    </array>
  <key>CFBundleURLTypes</key>
  <array>
    <dict>
      <key>CFBundleTypeRole</key>
      <string>Editor</string>
      <key>CFBundleURLName</key>
      <string>You App URL Scheme here</string>
      <key>CFBundleURLSchemes</key>
      <array>
        <string>You App URL Scheme here</string>
      </array>
    </dict>
  </array>
```

## Android Setup

- Update android:launchMode="singleTask" the AndroidManifest.xml file

```xml

 <activity
            android:name=".MainActivity"
            android:exported="true"

            android:launchMode="singleTask"

            android:theme="@style/LaunchTheme"
            android:configChanges="orientation|keyboardHidden|keyboard|screenSize|smallestScreenSize|locale|layoutDirection|fontScale|screenLayout|density|uiMode"
            android:hardwareAccelerated="true"
            android:windowSoftInputMode="adjustResize">
            .....

            </activity>

```

- Set up the intent filter in your AndroidManifest.xml file

```xml
            <intent-filter >
                <action android:name="android.intent.action.VIEW" />

                <category android:name="android.intent.category.DEFAULT" />
                <category android:name="android.intent.category.BROWSABLE" />


                <data
                    android:host="success"
                    android:scheme="<Your App Scheme>" />

                <data
                    android:host="failure"
                    android:scheme="<Your App Scheme>" />

            </intent-filter>

```

Note: incase kotlin error, add the following to your build.gradle file

```gradle
buildscript {
    // update this line
    ext.kotlin_version = '1.7.10'
```

[Read Common issues](https://docs.uaepass.ae/faq/common-integration-issues)
