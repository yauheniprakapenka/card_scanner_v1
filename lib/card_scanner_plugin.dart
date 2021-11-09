import 'dart:convert';
import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'card_scanner.dart';

part 'core/config/channel_config.dart';
part 'data/mappers/credit_card_mapper.dart';
part 'domain/models/credit_card_ios_model.dart';
part 'domain/models/credit_card_android_model.dart';

/// Для `iOS` используется библиотека `CreditCardScanner`, которая работает
/// с Apple's Vision API. Поддерживает `iOS 13.0` и выше.
///
/// Ссылка: https://github.com/yhkaplan/credit-card-scanner
///
/// Для `Android` используется библиотека `card.io`. Поддерживается `Android 4.1` и выше.
/// 
/// Ссылка: https://github.com/card-io/card.io-Android-SDK
/// 
/// Пример
/// 
///```dart
/// class _CardScannerPageState extends State<CardScannerPage> {
///   final cardScannerPlugin = CardScannerPlugin();
///   
///   @override
///   void initState() {
///     super.initState();
///     cardScannerPlugin.setMethodCallHandler();
///   }
/// 
///   @override
///   void dispose() {
///     cardScannerPlugin.card.dispose();
///     super.dispose();
///   }
/// 
///   @override
///   Widget build(BuildContext context) {
///     return Scaffold(
///       body: Column(
///         children: [
///           ValueListenableBuilder<CreditCardModel?>(
///               valueListenable: cardScannerPlugin.card,
///               builder: (_, creditCard, ___) {
///                 return Center(child: CreditCard(creditCard: creditCard));
///               }),
///           TextButton(
///             onPressed: () => cardScannerPlugin.openScanCamera(),
///             child: const Text('Open card scanner'),
///           )
///         ],
///       ),
///     );
///   }
/// }
/// ```
class CardScannerPlugin extends ChangeNotifier {
  static const _channel = MethodChannel(_ChannelConfig.channelName);

  /// После успешного сканирования карты обновляется `card`.
  /// 
  /// Неообходимо подписаться на обновления через `ValueListenableBuilder` и отписаться в `dispose`.
  final card = ValueNotifier<CreditCardModel?>(null);

  /// Открывает камеру для сканирования кредитной карты.
  void openScanCamera() async {
    try {
      await _channel.invokeMethod(_ChannelConfig.startCardScannerMethod);
    } catch (e) {
      throw Exception('Failed to open the camera: $e');
    }
  }

  /// Метод вызывается на хосте Android (Kotlin, Java) или iOS (Swift, Objective-c) с нативного кода. 
  /// 
  /// Возвращает название вызванного метода и аргумент, содержащих данные карты в формате JSON.
  /// Так как данные в JSON приходят с разными полями, то они приводятся с помощью `CreditCardMapper`.
  /// 
  /// Полученные данные карты присваиваются для переменной `card` и уведомляются все подписанные на `card`.
  ///
  /// Метод необходимо инициализировать в `initState`.
  void setMethodCallHandler() {
    _channel.setMethodCallHandler((methodCall) async {
      if (methodCall.method == _ChannelConfig.retrieveCardMethod) {
        final args = methodCall.arguments;
        card.value = _CreditCardMapper.getCreditCard(args);
        notifyListeners();
      } else {
        throw Exception('Method call not found}');
      }
    });
  }
}

