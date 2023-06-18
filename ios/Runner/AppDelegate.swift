import UIKit
import Flutter
import GoogleMaps
import FirebaseCore
// import FirebaseAnalytics

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    FirebaseApp.configure()
    // FirebaseMessaging.instance.delegate = self
    GMSServices.provideAPIKey("AIzaSyDt-QTvmblraCyPdEE5LqKWM2OCVMMgx_w")
    GeneratedPluginRegistrant.register(with: self)
  
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}




// override func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
//    Messaging.messaging().apnsToken = deviceToken
//    super.application(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
//  }