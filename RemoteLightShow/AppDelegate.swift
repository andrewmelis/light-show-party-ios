import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        println("hello")
        registerAllNotificationSettings(application)
        
        return true
    }
    
    func registerAllNotificationSettings(application: UIApplication) {
        let types = UIUserNotificationType.Sound | UIUserNotificationType.Alert | UIUserNotificationType.Badge
        let settings = UIUserNotificationSettings(forTypes: types, categories: nil)
        application.registerUserNotificationSettings(settings)
    }
    
    func application(application: UIApplication, didRegisterUserNotificationSettings notificationSettings: UIUserNotificationSettings) {
        println("yo we registered for \(notificationSettings)")
        application.registerForRemoteNotifications()
    }
    
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        println("testing \(deviceToken)")
    }
    
    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        println(error)
    }
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject], fetchCompletionHandler completionHandler:   (UIBackgroundFetchResult) -> Void) {
        println("yeehaw we're in the didReceiveRemoteNotification method with \(userInfo)")
        
        
        let dict = parseNotificationDictionary(userInfo)
        NSNotificationCenter.defaultCenter().postNotificationName("MessageFromServer", object: self, userInfo: dict)
        
        completionHandler(UIBackgroundFetchResult.NoData)
    }
//    
//    func parseNotificationDictionary(notificationDictionary: [NSObject : AnyObject]) -> String {
//        var notificationMessage = "0,0,0"
//        if let apsDict = notificationDictionary["aps"] as? [String : AnyObject], alert = apsDict["alert"] as? String {
//            notificationMessage = alert
//        }
//        println(notificationMessage)
//        return notificationMessage
//    }
    
    func parseNotificationDictionary(notificationDictionary: [NSObject : AnyObject]) -> [String : String] {
        var partyDict = ["name": "coolguy", "rgb": "0.5,0.5,0.5"]
        
        if let parsedDict = notificationDictionary["party"] as? [String : String] {
            partyDict = parsedDict
        }
        println(partyDict)
        return partyDict
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

