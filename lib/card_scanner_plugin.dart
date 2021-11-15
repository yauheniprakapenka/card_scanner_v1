import 'dart:async';
import 'package:flutter/services.dart';

part 'core/config/channel_config.dart';

class CardScannerPlugin  {
  static const _channel = MethodChannel(_ChannelConfig.channelName);
  final streamCntr = StreamController();

  CardScannerPlugin() {
    _channel.setMethodCallHandler((methodCall) async {
      if (methodCall.method == _ChannelConfig.retrieveCardMethod) {
        final json = methodCall.arguments;
        streamCntr.add(json);
      } else {
        throw Exception('Method call not found}');
      }
    });
  }

  void openScanCamera() async {
    try {
      await _channel.invokeMethod(_ChannelConfig.startCardScannerMethod);
    } catch (e) {
      throw Exception('Failed to open the camera: $e');
    }
  }
}
