#import "RateAppDialogPlugin.h"
#if __has_include(<rate_app_dialog/rate_app_dialog-Swift.h>)
#import <rate_app_dialog/rate_app_dialog-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "rate_app_dialog-Swift.h"
#endif

@implementation RateAppDialogPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftRateAppDialogPlugin registerWithRegistrar:registrar];
}
@end
