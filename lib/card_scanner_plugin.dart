import 'package:credit_card_scanner/core/const/channel_conts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Для `iOS` используется библиотека `CreditCardScanner`, которая работает
/// с Apple's Vision API, начиная с версии iOS 13.0 и выше.
///
/// Ссылка: https://github.com/yhkaplan/credit-card-scanner
class CardScannerPlugin extends ChangeNotifier {
  static const _channel = MethodChannel(ChannelConst.channelName);

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
  final card = ValueNotifier<String?>(null);

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
      final a =
          await _channel.invokeMethod(ChannelConst.startCardScannerMethod);
      debugPrint(a.toString());
    } catch (e) {
      throw Exception('Failed to open the camera: $e');
    }
  }

  /// Метод вызывается на стороне нативного приложения. Возвращает название
  /// метода и аргумент с данными карты в формате JSON.
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
      if (methodCall.method == ChannelConst.retrieveCardMethod) {
        card.value = methodCall.arguments;
        notifyListeners();
      } else {
        throw Exception('Method call not found}');
      }
    });
  }
}
