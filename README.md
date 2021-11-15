# Flutter Credit Card Scanner

<p align="center">
  <img src="demo/images/logo.jpg" height=100>
</p>

Плагин для сканирования кредитной карты для Android и iOS.

## iOS

<p align="center">
  <p style="text-align:center;"><img src="demo/images/ios.jpg" height=260>
</p>

Используется библиотека [CreditCardScanner](https://github.com/yhkaplan/credit-card-scanner), которая работает
с Apple's Vision API, начиная с версии `iOS 13.0` и выше.

## Android

<p align="center">
  <p style="text-align:center;"><img src="demo/images/android.jpg" height=260>
</p>

Используется библиотека [card.io](https://github.com/card-io/card.io-Android-SDK), начиная с `Android 4.1` и выше.

## Установка

- Установить CocoaPods
```
cd example/ios
pod install
```

## Как это настроено

### iOS

- Для `info.plist` добавлено разрешение на камеру
```
<key>NSCameraUsageDescription</key>
<string>Приложение запрашивает доступ к камере для автоматического сканирования карты</string>
```

- Для example/ios/Runner.xcworkspace -> PROJECT - Runner - Swift Packages - Кнопка Добавить - Добавлена библиотека
```
https://github.com/yhkaplan/credit-card-scanner.git

0.1.5 версия
```
- При добавлении библиотеки может быть ошибка 
```
Git cloning error: 'fatal: multiple updates for ... ref not allowed'
```
Так как вместе с библиотекой скачиваются еще две. Чтобы разрешить мультизагрузку необходимо выполнить покманду
```
git config --global --unset remote.origin.fetch
```

### Android

- В android/app/build.gradle добавлено две зависимости
```
dependencies {
    implementation 'io.card:android-sdk:5.5.1'        
    implementation 'com.google.code.gson:gson:2.8.9'
}
```