import UIKit
import Flutter
import GoogleMaps
import FirebaseCore
// import FirebaseAnalytics

// class MyExtensionContext: NSExtensionContext {
//   override class func _allowedItemPayloadClasses() -> Set<AnyClass> {
//     return super._allowedItemPayloadClasses().union([NSExtensionItem.self])
//   }
// }

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    FirebaseApp.configure()
    // FirebaseMessaging.instance.delegate = self
    GMSServices.setMetalRendererEnabled(true)
    GMSServices.provideAPIKey("AIzaSyDQ2a3xgarJk8qlNGzNCLzrH3H_XmGSUaY")

  if CLLocationManager.locationServicesEnabled() {
    let locationManager = CLLocationManager()
    locationManager.requestWhenInUseAuthorization()
  }
    
    GeneratedPluginRegistrant.register(with: self)
  
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}




// override func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
//    Messaging.messaging().apnsToken = deviceToken
//    super.application(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
//  }