import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChannelCall {
  /*static final channelName = 'rate_app_dialog';
  final methodChannel = MethodChannel(channelName);

  Future<void> openPlayStore() async {
    var result = await this.methodChannel.invokeMethod("openPlayStore");
    debugPrint("result: $result");
  }*/
  static const MethodChannel _channel =
  const MethodChannel('rate_app_dialog');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  Future<void> openPlayStore() async {
    var result = await _channel.invokeMethod("openPlayStore");
    debugPrint("result: $result");
  }

  Future<int> getDeviceLang() async {
    var langCode = await _channel.invokeMethod("getDeviceLang");
    debugPrint("flutter: langCodeResult: $langCode");
    if(langCode != null)
      switch(langCode) {
        case 'pt':
            return 1;
          break;
        case 'es':
            return 2;
          break;
        default:
          return 0;
      }
    else
      return 0;
  }
}