import UIKit
import Capacitor
import Appier
// Import UserNotifications
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder,
                   UIApplicationDelegate,
                   UNUserNotificationCenterDelegate {

  var window: UIWindow?


  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    
    // Registering Push Notification
        if #available(iOS 10.0, *) {
          let center = UNUserNotificationCenter.current()
          center.delegate = self
          center.requestAuthorization(options: [.badge, .carPlay, .alert, .sound]) { (granted, error) in
            print("Granted: \(granted), Error: \(String(describing: error))")
          }
        } else {
          // Fallback on earlier versions - iOS 8 & 9
          let settings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
          UIApplication.shared.registerUserNotificationSettings(settings)
        }
  
    let deadlineTime = DispatchTime.now() + .seconds(11)
    DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
        print("test")
        QGSdk.getSharedInstance().logEvent("test:146")
    }
    
    
    
    return true
  }

  func applicationWillResignActive(_ application: UIApplication) {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
  }

  func applicationDidEnterBackground(_ application: UIApplication) {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
  }

  func applicationWillEnterForeground(_ application: UIApplication) {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
  }

  func applicationDidBecomeActive(_ application: UIApplication) {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
  }

  func applicationWillTerminate(_ application: UIApplication) {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
  }

  func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
    // Called when the app was launched with a url. Feel free to add additional processing here,
    // but if you want the App API to support tracking app url opens, make sure to keep this call
    return CAPBridge.handleOpenUrl(url, options)
  }
  
  func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
    // Called when the app was launched with an activity, including Universal Links.
    // Feel free to add additional processing here, but if you want the App API to support
    // tracking app url opens, make sure to keep this call
    return CAPBridge.handleContinueActivity(userActivity, restorationHandler)
  }

  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesBegan(touches, with: event)

    let statusBarRect = UIApplication.shared.statusBarFrame
    guard let touchPoint = event?.allTouches?.first?.location(in: self.window) else { return }

    if statusBarRect.contains(touchPoint) {
      NotificationCenter.default.post(CAPBridge.statusBarTappedNotification)
    }
  }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
      let QG = QGSdk.getSharedInstance()
      print("My token is: \(deviceToken.description)")
      QG.setToken(deviceToken as Data)
    }

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
      print("Failed to get token, error: \(error.localizedDescription)")
    }

  // handling the click and deeplink events from push notification
  @available(iOS 10.0, *)
  func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler:@escaping() -> Void) {
    QGSdk.getSharedInstance().userNotificationCenter(center, didReceive: response)
    completionHandler()
  }
  
  // used for silent push handling
  // pass completion handler UIBackgroundFetchResult accordingly
  func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
    let QG = QGSdk.getSharedInstance()
    QG.application(application, didReceiveRemoteNotification: userInfo)
    completionHandler(UIBackgroundFetchResult.noData)
  }
  
  @available(iOS 10.0, *)
  func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    QGSdk.getSharedInstance().userNotificationCenter(center, willPresent: notification)
    completionHandler([.alert, .badge, .sound]);
  }
  /*
  func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
    NotificationCenter.default.post(name: Notification.Name(CAPNotifications.DidFailToRegisterForRemoteNotificationsWithError.name()), object: error)
  }
  */


}

