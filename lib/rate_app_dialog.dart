library rateappdialog;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';
import 'rate_dialog.dart';

class RateAppDialog {
  final BuildContext context;
  int minimeRateIsGood;
  int rateType;
  int minimeRequestToShow;
  final bool afterStarRedirect;

  static Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  RateAppDialog({this.context, this.minimeRateIsGood, this.rateType, this.minimeRequestToShow, this.afterStarRedirect}){
    _prefs.then((SharedPreferences prefs) {
      debugPrint(
          "retornou ${prefs.getInt(Constants.table_minime_is_good) ?? minimeRateIsGood} && afterStarRedirect: $afterStarRedirect");
      this.minimeRateIsGood =
          prefs.getInt(Constants.table_minime_is_good) ?? minimeRateIsGood;

      minimeRequestToShow =
          prefs.getInt(Constants.table_rate_minime_request) ??
              minimeRequestToShow;
      rateType = prefs.getInt(Constants.table_rate_type) ?? rateType;

      return (prefs.getInt(Constants.table_minime_is_good) ?? minimeRateIsGood);
    });
  }



  requestRate() async {
    int numeroRequest = await _updateRateRequest();

    final SharedPreferences prefs = await _prefs;

    if (!(prefs.getBool(Constants.table_rated) ?? false) &&
        numeroRequest >= minimeRequestToShow)
      showDialog(
          context: context,
          builder: (BuildContext context) => RateDialog(
              rateType: 0,
              afterStarRedirect: afterStarRedirect,
              minimeRateIsGood: minimeRateIsGood));
    else
      debugPrint("this user rated");
  }

  Future<int> _updateRateRequest() async {
    final SharedPreferences prefs = await _prefs;
    int minimeRequestToShow =
        (prefs.getInt(Constants.table_rate_minime_request) ??
                this.minimeRequestToShow) +
            1;
    int saved = await prefs
        .setInt(Constants.table_rate_minime_request, minimeRequestToShow)
        .then((bool success) {
      return minimeRequestToShow;
    });
    return saved;
  }
}
