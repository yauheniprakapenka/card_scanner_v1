import 'dart:convert';
import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:credit_card_scanner/card_scanner.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
class CardScannerPlugin extends ChangeNotifier {
  static const _channel = MethodChannel(_ChannelConfig.channelName);

  /// После успешного сканирования карты возвращает данные карты в формате JSON.
  ///
  /// ```
  /// ValueListenableBuilder<String?>(
  ///   valueListenable: cardScannerPlugin.card,
  ///   builder: (context, value, child) {
  ///     return Center(child: Text(value ?? ''));
  /// }),
  /// ```
  ///
  /// От переменной необходимо избавляться в методе `dispose`
  /// ```
  /// final cardScannerPlugin = CardScannerPlugin();
  ///
  /// @override
  /// void dispose() {
  ///   cardScannerPlugin.dispose();
  ///   super.dispose();
  /// }
  /// ```
  final card = ValueNotifier<CreditCardModel?>(null);

  /// Открывает камеру для сканирования кредитной карты.
  ///
  /// Пример
  /// ```
  /// final cardScannerPlugin = CardScannerPlugin();
  ///
  /// TextButton(
  ///   onPressed: () => openScanCamera(),
  ///   child: const Text('Открыть камеру'),
  /// )
  /// ```
  void openScanCamera() async {
    try {
      await _channel.invokeMethod(_ChannelConfig.startCardScannerMethod);
    } catch (e) {
      throw Exception('Failed to open the camera: $e');
    }
  }

  /// Метод вызывается на стороне нативного приложения. Возвращает название
  /// метода и аргумент с данными карты в формате JSON. Anroid и iOS возвращает разные JSON.
  /// Для приведения в одну модель используется `CreditCardMapper`.
  ///
  /// Полученные данные карты присваиваются для переменной `card` и уведомляются подписчики,
  /// подписанные на `card`.
  ///
  /// Метод необходимо инициализировать в `initState`
  /// Пример
  /// ```
  /// @override
  /// void initState() {
  ///   super.initState();
  ///   cardScannerPlugin.setMethodCallHandler();
  /// }
  ///```
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
