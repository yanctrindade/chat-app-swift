//
//  UIViewController.swift
//  chat-app
//
//  Created by Yan Correa Trindade on 22/06/21.
//

import UIKit

extension UIViewController {
    
    var appDelegate: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    var coordinator: AppCoordinator {
        return self.appDelegate.coordinator
    }
    
}
