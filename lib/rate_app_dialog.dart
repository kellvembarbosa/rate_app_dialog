library rateappdialog;

import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rate_app_dialog/channel_calls.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';
import 'rate_dialog.dart';

class RateAppDialog {
  final BuildContext context;
  final int minimeRateIsGood;
  final int minimeRequestToShow;
  final bool afterStarRedirect;
  final bool customDialogIOS;
  final int timeToShow;
  final String emailAdmin;

  static Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  RateAppDialog(
      {this.context,
      this.minimeRateIsGood = 4,
      this.minimeRequestToShow = 4,
      this.afterStarRedirect = false,
      this.customDialogIOS = false,
      this.timeToShow = 0,
      this.emailAdmin = ''});

  requestRate() async {
    int numeroRequest = await _updateRateRequest();
    final SharedPreferences prefs = await _prefs;
    bool isAvaliableRequest = false;

    debugPrint(
        "rate_app_dialog:debugPrint | numberOfRequest: $numeroRequest minimeRequestToShow: $minimeRequestToShow");

    if(Platform.isIOS){
      isAvaliableRequest = await ChannelCall().isRequestAvaliable();
    }

    if (!(prefs.getBool(Constants.table_rated) ?? false) &&
        numeroRequest >= minimeRequestToShow){

      if(customDialogIOS == false && isAvaliableRequest){
        await ChannelCall().requestReview();
        _updateRatedDatabase(rated: true);
        return;
      }

      Timer(
          Duration(seconds: timeToShow),
          () => showDialog(
              context: context,
              builder: (BuildContext context) => RateDialog(
                  afterStarRedirect: afterStarRedirect,
                  minimeRateIsGood: minimeRateIsGood,
                  emailAdmin: emailAdmin)));
    }else
      debugPrint("rate_app_dialog:debugPrint | this user rated");
  }

  Future<int> _updateRateRequest() async {
    final SharedPreferences prefs = await _prefs;
    int minimeRequestToShow =
        (prefs.getInt(Constants.table_rate_minime_request) ?? 0) + 1;
    int saved = await prefs
        .setInt(Constants.table_rate_minime_request, minimeRequestToShow)
        .then((bool success) {
      return minimeRequestToShow;
    });
    return saved;
  }

  Future<void> _updateRatedDatabase({@required rated}) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setBool(Constants.table_rated, rated).then((bool success) {
      return success;
    });
  }
}
