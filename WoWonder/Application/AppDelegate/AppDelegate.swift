
import UIKit
import DropDown
import Reachability
import SwiftEventBus
import IQKeyboardManagerSwift
import SwiftyBeaver
import Async
//import OneSignal
//import FBSDKLoginKit
import GoogleSignIn
import WowonderMessengerSDK
import FBAudienceNetwork
import GoogleMaps
import CoreData

let log = SwiftyBeaver.self
let googleApiKey = "AIzaSyAR6R-G3VEcrIKEA09yYb0UyMSESw4u4Y8"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    static var shared: AppDelegate {
        get {
            return UIApplication.shared.delegate as! AppDelegate
        }
    }
    
    var window: UIWindow?
    
    var userManager: UserManager? = nil
    
    var isInternetConnected = Connectivity.isConnectedToNetwork()
    var reachability = try! Reachability()
    
    let hostNames = ["google.com", "google.com", "google.com"]
    var hostIndex = 0
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let path = FileManager
            .default
            .urls(for: .applicationSupportDirectory, in: .userDomainMask)
            .last?
            .absoluteString
            .replacingOccurrences(of: "file://", with: "")
            .removingPercentEncoding
        
        print("DB Path :: \(path ?? "Not found")")
        print("Api =>\(AppInstance.instance._sessionId)")
        //ApplicationDelegate.initialize()
        //ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        
        startHost(at: 0)
        initFrameworks(application: application, launchOptions: launchOptions)
        DropDown.startListeningToKeyboard()
        FBAdSettings.addTestDevice(FBAdSettings.testDeviceHash())
        
        // Replace 'YOUR_APP_ID' with your OneSignal App ID.
//        OneSignal.initWithLaunchOptions(launchOptions)
//        OneSignal.setAppId(ControlSettings.oneSignalAppId)
//
//        // Recommend moving the below line to prompt for push after informing the user about
//        //   how your app will use them.
//        OneSignal.promptForPushNotifications(userResponse: { accepted in
//            print("User accepted notifications: \(accepted)")
//        })
//        OneSignal.add(self as OSSubscriptionObserver)
        
        GMSServices.provideAPIKey(googleApiKey)
        window?.tintColor = .mainColor
        
        return true
    }
    
    func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        
       // let handled: Bool = ApplicationDelegate.shared.application(application, open: url, sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String, annotation: options[UIApplication.OpenURLOptionsKey.annotation])
        // Add any custom logic here.
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
        let data  = ["from_id": AppInstance.instance.sessionId]
        SocketHelper.shared.emit(emitName: "ping_for_lastseen", params: data as [String : Any])
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        SocketHelper.shared.connectSocket { (success) in
            print("success ==> \(success)")
        }
        let data  = ["from_id": AppInstance.instance.sessionId]
        SocketHelper.shared.emit(emitName: "on_user_loggedin", params: data as [String : Any])
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        stopNotifier()
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        
        let data  = ["from_id": AppInstance.instance.sessionId]
        SocketHelper.shared.emit(emitName: "on_user_loggedoff", params: data as [String : Any])
        SocketHelper.shared.emit(emitName: "ping_for_lastseen", params: data as [String : Any])
        SocketHelper.shared.disconnectSocket()
    }
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "WoWonder")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

// MARK: - SUBSCRIPTION OBSERVER

//extension AppDelegate: OSSubscriptionObserver {
extension AppDelegate {
    func UserSession() -> Bool {
        if !UserDefaults.standard.getUserSessions(Key: Local.USER_SESSION.User_Session).isEmpty {
            return true
        }else {
            return false
        }
    }
    
    func initFrameworks(application: UIApplication, launchOptions: [UIApplication.LaunchOptionsKey: Any]?){
        //        UINavigationBar.appearance().barTintColor = UIColor(red: 234.0/255.0, green: 46.0/255.0, blue: 73.0/255.0, alpha: 1.0)
        //        UINavigationBar.appearance().tintColor = UIColor.white
        
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.label]
        
        GIDSignIn.sharedInstance().clientID = ControlSettings.googleClientKey
        let status = UserDefaults.standard.getDarkMode(Key: "darkMode")
        if #available(iOS 13.0, *) {
            if status{
                window?.overrideUserInterfaceStyle = .dark
                
            }else{
                window?.overrideUserInterfaceStyle = .light
                
            }
        }
        
        let preferredLanguage = NSLocale.preferredLanguages[0]
        if preferredLanguage.starts(with: "ar"){
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
        } else{
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
        }        /* Decryption of Cert Key */
        
        ServerCredentials.setServerDataWithKey(key: AppConstant.key)
        SocketHelper.shared.connectSocket { (success) in
            print("success ==> \(success)")
        }
        
        /* IQ Keyboard */
        IQKeyboardManager.shared.enable = true
        DropDown.startListeningToKeyboard()
        
        
        /* Init Swifty Beaver */
        let console = ConsoleDestination()
        let file = FileDestination()
        log.addDestination(console)
        log.addDestination(file)
    }
    
//    func onOSSubscriptionChanged(_ stateChanges: OSSubscriptionStateChanges) {
//        if !stateChanges.from.isSubscribed && stateChanges.to.isSubscribed {
//        }
//        
//        //The player id is inside stateChanges. But be careful, this value can be nil if the user has not granted you permission to send notifications.
//        if let playerId = stateChanges.to.userId {
//            //            print("Current playerId \(playerId)")
//            UserDefaults.standard.setDeviceId(value: playerId , ForKey: "deviceID")
//        }
//    }
    
    func startHost(at index: Int) {
        stopNotifier()
        setupReachability(hostNames[index], useClosures: false)
        startNotifier()
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            self.startHost(at: (index + 1) % 3)
        }
    }
    
    func setupReachability(_ hostName: String?, useClosures: Bool) {
        let reachability:  Reachability?
        if let hostName = hostName {
            reachability = try! Reachability(hostname: hostName)
            
        } else {
            reachability = try! Reachability()
        }
        self.reachability = try! reachability ??  Reachability.init()
        if useClosures {
        } else {
            NotificationCenter.default.addObserver(
                self,
                selector: #selector(reachabilityChanged(_:)),
                name: .reachabilityChanged,
                object: reachability
            )
        }
    }
    
    func startNotifier() {
        do {
            try reachability.startNotifier()
        } catch {
            return
        }
    }
    
    func stopNotifier() {
        reachability.stopNotifier()
        NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: nil)
    }
    
    @objc func reachabilityChanged(_ note: Notification) {
        Async.main({
            let reachability = note.object as! Reachability
            switch reachability.connection {
            case .wifi:
                self.isInternetConnected = true
                SwiftEventBus.post(EventBusConstants.EventBusConstantsUtils.EVENT_INTERNET_CONNECTED)
                SwiftEventBus.post(EventBusConstants.EventBusConstantsUtils.EVENT_CONNECT_SOCKET_CALL)
                
            case .cellular:
                self.isInternetConnected = true
                SwiftEventBus.post(EventBusConstants.EventBusConstantsUtils.EVENT_INTERNET_CONNECTED)
                
            case .none:
                self.isInternetConnected = false
                SwiftEventBus.post(EventBusConstants.EventBusConstantsUtils.EVENT_INTERNET_DIS_CONNECTED)
                
            default:
                break
            }
        })
    }
    
    @objc func reachabilityChanged(note: Notification) {
        
    }
}
