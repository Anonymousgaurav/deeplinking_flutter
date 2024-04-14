import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
            let channel = FlutterMethodChannel(name: "launchUrl", binaryMessenger: controller.binaryMessenger)
            channel.setMethodCallHandler { (call, result) in
                if call.method == "openUrl" {
                    if let url = call.arguments as? String {
                        if let url = URL(string: url) {
                            if UIApplication.shared.canOpenURL(url) {
                                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                                result(nil)
                            } else {
                                result(FlutterError(code: "UNAVAILABLE", message: "URL cannot be opened", details: nil))
                            }
                        } else {
                            result(FlutterError(code: "INVALID_URL", message: "Invalid URL", details: nil))
                        }
                    } else {
                        result(FlutterError(code: "INVALID_ARGUMENT", message: "Missing URL argument", details: nil))
                    }
                } else {
                    result(FlutterMethodNotImplemented)
                }
            }
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
