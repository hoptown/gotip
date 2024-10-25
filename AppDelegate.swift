//  AppDelegate
//  Go Tip -Swift
//
//  Created by Lawrence Lovelace on 3/10/20
//  Copyright © 2020 Pledge Geek. All rights reserved.
//

import UIKit

//@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  let userDefaults = UserDefaults.standard

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    
    let attrs = [
      NSAttributedString.Key.foregroundColor: UIColor.white,
      NSAttributedString.Key.font: UIFont(name: "Georgia-Bold", size: 24)!
    ]
    
    
    UINavigationBar.appearance().titleTextAttributes = attrs
    
    
    if userDefaults.object(forKey: COLOR_SCHEME) == nil {
      userDefaults.set("light-green", forKey: COLOR_SCHEME)
    }
//    if userDefaults.object(forKey: PREVIOUS_AMOUNT) == nil {
//      userDefaults.set("0.00", forKey: PREVIOUS_AMOUNT)
//    }
    if userDefaults.object(forKey: DEFAULT_TIP) == nil {
      userDefaults.set(15, forKey: DEFAULT_TIP)
    }
    if userDefaults.object(forKey: PEOPLE) == nil {
      userDefaults.set(1, forKey: PEOPLE)
    }
    
    return true
  }

  // MARK: UISceneSession Lifecycle

  func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
  }

  func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
  }


}

