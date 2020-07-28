import 'package:flutter/material.dart';
import 'package:rate_app_dialog/rate_app_dialog.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  RateAppDialog rateAppDialog;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  void initState() {
    super.initState();

    /**
     * All keys to translate
    "en": {
      "title": "Rating this App",
      "description": "Are you enjoying the app? \n Can you rate our app now?",
      "btnLater": "Later",
      "badRateDescription": "Tell us why you don't like this app?",
      "badRateTextAreaHinit": "Leave feedback here.",
      "badValidation": "Required!",
      "badBtnSend": "Submit",
      "goodRateDescription": "Help us rate our app on the PlayStore.",
      "goodBtnRate": "Rate now!",
    }

    ======================================== example ====================================

    to add custom lang Code
    Example: 
    var langs = "fr": {
      "title": "Noter cette application",
      ...
    }
    **/

    var langs = {
      "en" : {
        "title" : "My APP - Custom text Lang",
        "description": "Are you enjoying the app? \n Can you rate our app now?",
      }
    };

    rateAppDialog = RateAppDialog(
        context: context,
        langTexts: langs,
        afterStarRedirect: true,
        emailAdmin: "kellvem222@gmail.com",
        customDialogIOS: true,
        minimeRequestToShow: 4,
        minimeRateIsGood: 4);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          // Call this method for testing only! It will reset the saved values so that you can test again and call the dialog.
          IconButton(
              icon: Icon(Icons.restore),
              onPressed: () => rateAppDialog.resetKeyAndValues())
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          rateAppDialog?.requestRate();
          _incrementCounter();
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
