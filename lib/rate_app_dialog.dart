library rateappdialog;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';
import 'rate_dialog.dart';

class RateAppDialog {
  final BuildContext context;
  final int minimeRateIsGood;
  final int minimeRequestToShow;
  final bool afterStarRedirect;
  static Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  RateAppDialog({this.context, this.minimeRateIsGood = 4, this.minimeRequestToShow = 4, this.afterStarRedirect = false});

  requestRate() async {
    int numeroRequest = await _updateRateRequest();
    final SharedPreferences prefs = await _prefs;

    debugPrint("rate_app_dialog:debugPrint | numberOfRequest: $numeroRequest minimeRequestToShow: $minimeRequestToShow");
    if(!(prefs.getBool(Constants.table_rated) ?? false) && numeroRequest >= minimeRequestToShow)
      showDialog(
          context: context,
          builder: (BuildContext context) => RateDialog(
              afterStarRedirect: afterStarRedirect,
              minimeRateIsGood: minimeRateIsGood
          ));
    else
      debugPrint("rate_app_dialog:debugPrint | this user rated");
  }

  Future<int> _updateRateRequest() async {
    final SharedPreferences prefs = await _prefs;
    int minimeRequestToShow = (prefs.getInt(Constants.table_rate_minime_request) ?? 0) + 1;
    int saved = await prefs
        .setInt(Constants.table_rate_minime_request, minimeRequestToShow)
        .then((bool success) {
      return minimeRequestToShow;
    });
    return saved;
  }
}
