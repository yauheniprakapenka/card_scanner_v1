import 'dart:async';
import 'package:flutter/services.dart';

class CreditCardScannerPlugin {
  static const _channel = MethodChannel('card_scanner_channel');
  final _streamCntr = StreamController<String>();

  Stream<String> get stream => _streamCntr.stream;

  CreditCardScannerPlugin() {
    _channel.setMethodCallHandler((methodCall) async {
      if (methodCall.method == 'retrieve_card_method') {
        _streamCntr.add(methodCall.arguments);
      } else {
        throw Exception('Method call not found}');
      }
    });
  }

  Future<void> openScanCamera() async {
    await _channel.invokeMethod('start_card_scanner_method');
  }
}
