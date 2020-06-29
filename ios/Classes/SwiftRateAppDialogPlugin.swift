import Flutter
import UIKit
import StoreKit

public class SwiftRateAppDialogPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "rate_app_dialog", binaryMessenger: registrar.messenger())
    let instance = SwiftRateAppDialogPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    var appId = "com.apple.appstore" //Your App ID on App Store
       if let bundleIdentifier = Bundle.main.bundleIdentifier {
           appId = bundleIdentifier
       }
    
    switch (call.method) {
    case "requestReview":
            if #available(iOS 10.3, *) {
                SKStoreReviewController.requestReview() // Requesting alert view for getting rating from the user.
              result("Later than iOS 10.3 the App will Request the App Review, Users can turn this off in settings for all apps, Apple will manage when to request the review from the user. In Debug it will always show. Requesting review for: " + appId)
            } else {
              // Fallback on earlier versions
              result("Prior to iOS 10.3 App Review from App is not available. You should go to Store Page of App: " + appId + ". If the app is not published the app will not be found.")
            }
        break
    case "isRequestAvaliable":
            if #available(iOS 10.3, *) {
              result("1")
            } else {
              result("0")
            }
        break
    case "openPlayStore" :
            if (appId.count ) == 0 {
                result(FlutterError(code: "ERROR", message: "Empty app id", details: nil))
            } else {
                let iTunesLink = "itms-apps://itunes.apple.com/app/id\(appId )?action=write-review"
                let itunesURL = URL(string: iTunesLink)
                if let itunesURL = itunesURL {
                    if UIApplication.shared.canOpenURL(itunesURL) {
                        UIApplication.shared.openURL(itunesURL)
                    }
                }
                result("launched \(iTunesLink)")
            }
        break
    case "getDeviceLang":
        let language = Bundle.main.preferredLocalizations.first! as NSString
        result(language)
        break
    default:
        result(FlutterMethodNotImplemented)
    }
  }
}
