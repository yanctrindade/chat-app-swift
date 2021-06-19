//
//  AppDelegate.swift
//  chat-app
//
//  Created by Yan Correa Trindade on 19/06/21.
//

import UIKit
import PubNub

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var pubnub: PubNub!
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        PubNub.log.levels = [.all]
        PubNub.log.writers = [ConsoleLogWriter(), FileLogWriter()]
        var config = PubNubConfiguration(publishKey: "pub-c-fdd20a63-fd16-4a8f-930d-6cb72eb6d916", subscribeKey: "sub-c-60714650-c300-11eb-8a3a-220055b20f11", uuid: "3dcde054-17ec-48ba-88f9-93fca230ca8a")
        pubnub = PubNub(configuration: config)
        
        if #available(iOS 13.0, *) {
            // no-op - UI created in scene delegate
        } else if let rootVC = self.window?.rootViewController as? ViewController {
            rootVC.pubnub = pubnub
        }
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        
    }


}

