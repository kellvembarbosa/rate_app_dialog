import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rate_app_dialog/channel_calls.dart';
import 'package:rate_app_dialog/lang_texts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';
import 'star_rating.dart';

class RateDialog extends StatefulWidget {
  final int minimeRateIsGood;
  final bool afterStarRedirect;
  String btnLater;
  final Image image;
  final String emailAdmin;

  RateDialog({
    @required this.minimeRateIsGood,
    this.image,
    this.afterStarRedirect,
    this.emailAdmin = '',
  });

  @override
  _RateDialogState createState() => _RateDialogState();
}

class _RateDialogState extends State<RateDialog> {
  int isGood = 0;
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  int minimeRateIsGood;
  int ratedStars;

  var _langTexts;
  int langArrayPosition = 0;
  final _formKey = GlobalKey<FormState>();
  final _textController = TextEditingController();
  bool badAvaliationEmpty = false;

  @override
  void initState() {
    super.initState();
    ChannelCall().getDeviceLang().then((value) {
      langArrayPosition = value;
      _langTexts = LangTexts().langText[langArrayPosition];

      setState(() {});
    });

    _langTexts = LangTexts().langText[langArrayPosition];

    minimeRateIsGood = widget.minimeRateIsGood;
    ratedStars = 0;
    _prefs.then((SharedPreferences prefs) {
      ratedStars = prefs.getInt(Constants.table_rated_stars) ?? 0;
      setState(() {
        debugPrint("initState() $ratedStars");
        if (ratedStars >= minimeRateIsGood) isGood = 1;
        if (ratedStars < minimeRateIsGood && ratedStars != 0) isGood = 2;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Constants.padding),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        SingleChildScrollView(
          child: Container(
              padding: EdgeInsets.only(
                //top: Constants.avatarRadius + Constants.padding,
                top: Constants.padding,
                bottom: Constants.padding,
                left: Constants.padding,
                right: Constants.padding,
              ),
              margin: EdgeInsets.only(top: Constants.avatarRadius),
              decoration: new BoxDecoration(
                color:
                    Theme.of(context).scaffoldBackgroundColor, //Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(Constants.padding),
              ),
              child: rateDialog()),
        ),
      ],
    );
  }

  rateDialog() {
    switch (isGood) {
      case 1:
        return _goodRequest();
        break;
      case 2:
        return _badRequest();
        break;
      default:
        return _initialRequest();
    }
  }

  Widget _initialRequest() {
    return Column(
      mainAxisSize: MainAxisSize.min, // To make the card compact
      children: <Widget>[
        Text(
          _langTexts['title'],
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 16.0),
        Text(
          _langTexts['description'],
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
        SizedBox(height: 24.0),
        Center(child: callRating()),
        SizedBox(
          height: 24,
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: FlatButton(
            onPressed: () {
              Navigator.of(context).pop(); // To close the dialog
            },
            child: Text(_langTexts['btnLater']),
          ),
        ),
      ],
    );
  }

  Widget _goodRequest() {
    return Column(
      mainAxisSize: MainAxisSize.min, // To make the card compact
      children: <Widget>[
        Text(
          _langTexts['title'],
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 16.0),
        Container(
          child: Text(_langTexts['goodRateDescription'] ?? '',
              textAlign: TextAlign.center),
        ),
        SizedBox(
          height: 24,
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: FlatButton(
            onPressed: () {
              ChannelCall().openPlayStore();
              _updateRatedDatabase(rated: true);
              Navigator.pop(context);
            },
            child: Text(_langTexts['goodBtnRate']),
          ),
        )
      ],
    );
  }

  Widget _badRequest() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min, // To make the card compact
        children: <Widget>[
          Text(
            _langTexts['title'],
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 16.0),
          Center(child: callRating()),
          SizedBox(height: 16.0),
          Text(
            _langTexts['badRateDescription'],
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
          SizedBox(height: 16.0),
          Align(
            alignment: Alignment.center,
            child: TextFormField(
              controller: _textController,
              maxLines: 4,
              validator: (value) {
                if (value.isEmpty) {
                  return _langTexts['badValidation'];
                }
                return null;
              },
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: _langTexts['badRateTextAreaHinit']),
            ),
          ),
          SizedBox(
            height: 24,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: FlatButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  if (widget.emailAdmin.isNotEmpty) {
                    ChannelCall().sendEmail(
                        emailAdmin: widget.emailAdmin,
                        bodyEmail: _textController.value.text);
                  }
                  Navigator.of(context).pop();
                  _updateRatedDatabase(rated: true);
                }
              },
              child: Text(
                _langTexts['badBtnSend'],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget callRating() => StarRating(
        rating: ratedStars.toDouble(),
        //isReadOnly: false,
        size: 40,
        filledIconData: Icons.star,
        halfFilledIconData: Icons.star_half,
        defaultIconData: Icons.star_border,
        color: Colors.amber,
        borderColor: Colors.amber,
        starCount: 5,
        allowHalfRating: false,
        spacing: 2.0,
        onRatingChanged: (value) {
          print("rating value -> ${value.toInt()} ==== $minimeRateIsGood");

          ratedStars = value.toInt();

          setState(() {});

          if (value.toInt() >= minimeRateIsGood) {
            Timer(Duration(milliseconds: 500), () {
              if (widget.afterStarRedirect) {
                debugPrint("forcedRedirect after stars");
                ChannelCall().openPlayStore();
                _updateRatedDatabase(rated: true);
                setState(() {});
                return;
              }
              isGood = 1;
              _updateRateStarDatabase(intraterStar: value.toInt());
              setState(() {});
            });
            return;
          }

          if (value.toInt() < minimeRateIsGood) {
            isGood = 2;
            _updateRateStarDatabase(intraterStar: value.toInt());
            setState(() {});
          }
        },
      );

  Future<void> _updateRateStarDatabase({@required intraterStar}) async {
    final SharedPreferences prefs = await _prefs;
    prefs
        .setInt(Constants.table_rated_stars, intraterStar)
        .then((bool success) {
      return success;
    });
  }

  Future<void> _updateRatedDatabase({@required rated}) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setBool(Constants.table_rated, rated).then((bool success) {
      return success;
    });
  }
}
