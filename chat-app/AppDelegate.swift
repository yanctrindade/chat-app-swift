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
    lazy var coordinator: AppCoordinator = AppCoordinator(appDelegate: self, window: window!)

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        PubNub.log.levels = [.all]
        PubNub.log.writers = [ConsoleLogWriter(), FileLogWriter()]
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        coordinator.start()
        
        return true
    }

}

