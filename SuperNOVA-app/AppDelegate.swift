//
//  AppDelegate.swift
//  SuperNOVA-app
//
//  Created by y-okada on 2016/09/24.
//  Copyright © 2016年 SuperNOVA. All rights reserved.
//

import UIKit
import GoogleMaps
import FBSDKCoreKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    //let googleMapsApiKey = "AIzaSyC3J5uA2FEqxAGTWAFsZ8J-RJ5eqmUnnRQ"
    let googleMapsApiKey = "AIzaSyCCzVo0V3wCuQYetuSKCD97PVQOlHlUCjA" //rinrin key
    //let API_ROOT = ""
    var _userid   :String!
    var _image    :String!
    var _fullname :String!
    var _firstname :String!
    var _lastname :String!
    var _place     :String!
    var _id       :String!
    var _idpartner       :String!
    var _lang     :String!
    var _native     :String!
    var _lat      :String!
    var _lng      :String!
    var _time      :String!
    var _partner  :String!
    var _partnerName :String!
    var _partnerimage :String!
    var _shoplat:   CLLocationDegrees!
    var _shoplng:  CLLocationDegrees!
    var _shoptitle :String!
    var _shopsnippet :String!
    var _status: CLAuthorizationStatus!
    var _application: UIApplication!
    var _pushId :String!
    var _shopimage :String!
    
    // marker size
    var _mw = 20
    var _mh = 30
    // usagi icon size
    var _uiw = 30
    var _uih = 35
    
    // 
    //var initializedLocation: Bool = false;
    //
    //var networkErrorChecked = false;
    
    //
    var zoom: Float = 15
    //
    let distance_filter: CLLocationDistance = 50;
    
    //BackGroundGeoLocation
    var backgroundTaskID : UIBackgroundTaskIdentifier = 0
    
    var pushLocationManager: CLLocationManager!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //
        GMSServices.provideAPIKey(googleMapsApiKey)
        
        _application = application
        
        //ローカルプッシュ許可
        if #available(iOS 8.0, *) {
            // iOS8以上
            //forTypesは.Alertと.Soundと.Badgeがある
            let notiSettings = UIUserNotificationSettings(types:[.alert,.sound,.badge], categories:nil)
            application.registerUserNotificationSettings(notiSettings)
            application.registerForRemoteNotifications()
        } else{
            // iOS7以前
            application.registerForRemoteNotifications( matching: [.alert,.sound,.badge] )
        }
        
        //バックグラウンド位置情報取得の事前設定
        setupBackGroundGeoLocation()
        //初回位置情報取得
        pushLocationManager.startUpdatingLocation()
        
        _lang = ""
        _time = ""
        _place = ""
        _shopimage = ""

        //Facebook
        return FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    func application(_ application: UIApplication,open url: URL,sourceApplication: String?,annotation: Any) -> Bool {
        //Facebook
        return FBSDKApplicationDelegate.sharedInstance().application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
    }
    

    //バックグラウンド遷移移行直前に呼ばれる
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
        
        NSLog("---AppDelegate applicationWillResignActive");
        _application = application
        
        //BackGroundGeoLocation
        //self.backgroundTaskID = application.beginBackgroundTask()(expirationHandler: {
        self.backgroundTaskID = application.beginBackgroundTask(expirationHandler: {
            [weak self] in
            application.endBackgroundTask((self?.backgroundTaskID)!)
            self?.backgroundTaskID = UIBackgroundTaskInvalid
        })
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    //アプリがアクティブになる度に呼ばれる
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        //Facebook
        FBSDKAppEvents.activateApp()
        
        //BackGroundGeoLocation
        application.endBackgroundTask(self.backgroundTaskID)
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    //バックグラウンド位置情報取得の事前設定
    func setupBackGroundGeoLocation(){
        NSLog("---AppDelegate setupBackGroundGeoLocation")
        
        //位置情報認証
        let status = CLLocationManager.authorizationStatus()
        if status == CLAuthorizationStatus.restricted || status == CLAuthorizationStatus.denied {
            return
        }
        
        pushLocationManager = CLLocationManager()
//        pushLocationManager.delegate = self
        
        if status == CLAuthorizationStatus.notDetermined {
            pushLocationManager.requestAlwaysAuthorization()
        }
        
        if !CLLocationManager.locationServicesEnabled() {
            return
        }
        
        //位置情報取得開始
        pushLocationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        pushLocationManager.distanceFilter = 1
    }
    
    //位置情報取得時処理
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        NSLog("---AppDelegate locationManager")
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate //AppDelegateのインスタンスを取得
        let lastLocation = locations.last
        if let last = lastLocation {
            let eventDate = last.timestamp
            if abs(eventDate.timeIntervalSinceNow) < 15.0 {
                if let location = manager.location {
                    appDelegate._lat = location.coordinate.latitude.description
                    appDelegate._lng = location.coordinate.longitude.description
                }
            }
        }
    }
    
    // 座標が取得できない場合の処理
    func locationManager(_ manager: CLLocationManager, didFailWithError error: NSError){
        NSLog("---AppDelegate locationManager Error getting Location")
    }


}

