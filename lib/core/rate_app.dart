import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rate_app_dialog/core/constants.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:rate_app_dialog/lang_texts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:in_app_review/in_app_review.dart';

class RateApp {
  final int minimeRequestToShow;
  final int daysToShow;
  final String emailAdmin;
  final Map<String, Map<String, String>>? translations;
  final InAppReview inAppReview = InAppReview.instance;

  RateApp({
    this.minimeRequestToShow = 4,
    this.daysToShow = 0,
    this.emailAdmin = '',
    this.translations,
  });

  requestFromGetMaterial(
    BuildContext context, {
    AlertStyle? alertStyle,
  }) {}

  requestDialog(
    BuildContext context, {
    AlertStyle? alertStyle,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final translate = Translate(newTranslations: translations);
    // 0 - show Alert
    // 1 - liked more dont
    // 2 - liked and rated

    int rated = prefs.getInt(Constants.RATED) ?? 0;
    bool dontLike = prefs.getBool(Constants.DONT_LIKE) ?? false;

    int requestDialogs = prefs.getInt(Constants.REQUEST_DIALOGS) ?? 1;
    int dateInstall = prefs.getInt(Constants.TIME_INSTALL) ?? 0;

    if (dateInstall == 0) {
      await prefs.setInt(
          Constants.TIME_INSTALL, DateTime.now().millisecondsSinceEpoch);
      dateInstall = prefs.getInt(Constants.TIME_INSTALL) ?? 0;
    }

    final dayIn = DateTime.fromMillisecondsSinceEpoch(dateInstall);

    if (requestDialogs >= minimeRequestToShow &&
        dayIn.daysSince >= daysToShow) {
      switch (rated) {
        case 0:
          debugPrint('rated $rated');
          if (!dontLike)
            Alert(
              context: context,
              title: 'title'.translate(translate),
              desc: 'description'.translate(translate),
              buttons: [
                DialogButton(
                  child: Text(
                    'no'.translate(translate),
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  onPressed: () {
                    prefs.setBool(Constants.DONT_LIKE, true);
                    Navigator.pop(context);
                  },
                  color: Color.fromRGBO(0, 179, 134, 1.0),
                ),
                DialogButton(
                  child: Text(
                    'like'.translate(translate),
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  onPressed: () async {
                    prefs.setBool(Constants.DONT_LIKE, true);
                    if (await inAppReview.isAvailable()) {
                      inAppReview.requestReview();
                      prefs.setInt(Constants.RATED, 2);
                    }
                    Navigator.pop(context);
                  },
                  gradient: LinearGradient(colors: [
                    Color.fromRGBO(116, 116, 191, 1.0),
                    Color.fromRGBO(52, 138, 199, 1.0)
                  ]),
                )
              ],
            ).show();
          break;
        case 1:
          debugPrint('rated $rated');
          if (await inAppReview.isAvailable() && !dontLike) {
            inAppReview.requestReview();
            prefs.setInt(Constants.RATED, 2);
          }
          break;
        default:
          debugPrint('rated $rated');
      }
    }
    debugPrint('requestDialogs: $requestDialogs');
    prefs.setInt(Constants.REQUEST_DIALOGS, requestDialogs + 1);
  }

  /// Call this method for testing only! It will reset the saved values so that you can test again and call the dialog.
  resetKeyAndValues() async {
    debugPrint("Rate_App_Dialog | ========> Data key/values Reseted <=======");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(Constants.RATED, 0);
    prefs.setInt(Constants.TIME_INSTALL, 0);
    prefs.setBool(Constants.DONT_LIKE, false);
  }
}
