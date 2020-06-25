library rateappdialog;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';
import 'rate_dialog.dart';

class RateAppDialog {
  static final RateAppDialog _instance = RateAppDialog._internal();
  RateAppDialog._internal();

  BuildContext context;

  int minimeRateIsGood;
  int rateType;
  int minimeRequestToShow;

  bool afterStarRedirect;

  static Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  factory RateAppDialog({
    @required context,
    minimeRateIsGood = 4,
    rateType = 0,
    minimeRequestToShow = 3,
    afterStarRedirect = false,
  }) {
    _instance.context = context;
    _instance.minimeRateIsGood = minimeRateIsGood;
    _instance.minimeRequestToShow = minimeRequestToShow;
    _instance.afterStarRedirect = afterStarRedirect;

    _prefs.then((SharedPreferences prefs) {
      debugPrint(
          "retornou ${prefs.getInt(Constants.table_minime_is_good) ?? minimeRateIsGood} && afterStarRedirect: ${_instance.afterStarRedirect}");
      _instance.minimeRateIsGood =
          prefs.getInt(Constants.table_minime_is_good) ?? minimeRateIsGood;

      _instance.minimeRequestToShow =
          prefs.getInt(Constants.table_rate_minime_request) ??
              minimeRequestToShow;
      _instance.rateType = prefs.getInt(Constants.table_rate_type) ?? rateType;

      return (prefs.getInt(Constants.table_minime_is_good) ?? minimeRateIsGood);
    });
    return _instance;
  }

  static RateAppDialog get instance => _instance;

  requestRate() async {
    int numeroRequest = await _updateRateRequest();

    final SharedPreferences prefs = await _prefs;

    if (!(prefs.getBool(Constants.table_rated) ?? false) &&
        numeroRequest >= _instance.minimeRequestToShow)
      showDialog(
          context: _instance.context,
          builder: (BuildContext context) => RateDialog(
              rateType: 0,
              afterStarRedirect: _instance.afterStarRedirect,
              minimeRateIsGood: _instance.minimeRateIsGood));
    else
      debugPrint("this user rated");
  }

  Future<int> _updateRateRequest() async {
    final SharedPreferences prefs = await _prefs;
    int minimeRequestToShow =
        (prefs.getInt(Constants.table_rate_minime_request) ??
                _instance.minimeRequestToShow) +
            1;
    int saved = await prefs
        .setInt(Constants.table_rate_minime_request, minimeRequestToShow)
        .then((bool success) {
      return minimeRequestToShow;
    });
    return saved;
  }
}
