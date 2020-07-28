import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChannelCall {
  /*static final channelName = 'rate_app_dialog';
  final methodChannel = MethodChannel(channelName);

  Future<void> openPlayStore() async {
    var result = await this.methodChannel.invokeMethod("openPlayStore");
    debugPrint("result: $result");
  }*/
  static const MethodChannel _channel = const MethodChannel('rate_app_dialog');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  Future<void> requestReview() async {
    var result = await _channel.invokeMethod("requestReview");
    debugPrint("result: $result");
  }

  Future<bool> isRequestAvaliable() async {
    final String result = await _channel.invokeMethod("isRequestAvaliable");
    debugPrint("result: $result");
    return result == '1';
  }

  Future<void> openPlayStore() async {
    var result = await _channel.invokeMethod("openPlayStore");
    debugPrint("result: $result");
  }

  Future<void> sendEmail(
      {@required String emailAdmin, @required String bodyEmail}) async {
    try {
      var result = await _channel.invokeMethod(
          "sendEmail", {'email': emailAdmin, 'bodyEmail': bodyEmail});
      debugPrint("result: $result");
    } on PlatformException catch (e) {
      throw 'Dont send e-mail ${e.message}';
    }
  }

  Future<String> getDeviceLang() async {
    var langCode = await _channel.invokeMethod("getDeviceLang");
    debugPrint("flutter: langCodeResult: $langCode");
    if (langCode != null)
      return langCode;
    else
      return "en";
  }
}
