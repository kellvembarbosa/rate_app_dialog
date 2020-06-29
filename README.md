## What is the rate_app_dialog

This package is designed to increase the ratings in your app, with bad review filter, find out what's bad and get more positive reviews!

<img src="https://github.com/kellvembarbosa/rate_app_dialog/blob/master/screenshots/screen.gif?raw=true" width="320px">

To call up the dialog and request evaluation, add the following code where you think is a good place to request user evaluation or add it to your homepage within initState:

```dart
RateAppDialog(
      context: context, 
      minimeRateIsGood: 4, 
      minimeRequestToShow: 5
    )
  .requestRate();
 ```
  
#### Arguments
- **context:** is required.
- **minimeRateIsGood:** Optional assignment, sets the number of stars that will be requested for evaluation in the store. (default: 4)
- **minimeRequestToShow:** Optional attribute, sets the number of requests to display the popup requesting the stars. (default: 5)
- **afterStarRedirect:** Optional attribute, Redirect to store after user passes ratings filter. (default: false)
- **timeToShow:** Optional attribute, opens the store with ideal delay for strategic points e.g. after a result expected by the user with delay of 5 seconds. (default: 0)
- **emailAdmin:** Optional attribute, email will be sent to the administrator with user feedback,. (default: "")
- **customDialogIOS:** Optional attribute, set true to custom dialog iOS. (default: false)


**Attention:** In order to be counted and displayed it will be necessary to call the method requestRate(), each call in requestRate() will be counted +1 and will be displayed according to the specified condition (minimeRequestToShow); You can specify various conditions in specific places to increase the chance of positive evaluation;


