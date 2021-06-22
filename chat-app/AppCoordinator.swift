import Foundation
import UIKit
import PubNub

class AppCoordinator {
    
    private var presenter: UINavigationController
    private var window: UIWindow
    private weak var appDelegate: AppDelegate?
    
    init(appDelegate: AppDelegate, window: UIWindow) {
        self.appDelegate = appDelegate
        self.window = window
        self.presenter = UINavigationController()
    }
    
    func start() {
        let controller = UserSelectionViewController()
        self.presenter = UINavigationController(rootViewController: controller)
        self.appDelegate?.window = self.window
        window.rootViewController = presenter
        window.makeKeyAndVisible()
    }
    
    func userSelectionToChat(uuid: String) {
        let config = PubNubConfiguration(publishKey: Constants.Chat.PUBLISH_KEY,
                                         subscribeKey: Constants.Chat.SUBSCRIBE_KEY,
                                         uuid: uuid)
        let pubnub = PubNub(configuration: config)
        let sender = MockUser(senderId: uuid, displayName: "user\(uuid)")
        let controller = ChatViewController(pubnub: pubnub, sender: sender)
        presenter.pushViewController(controller, animated: true)
    }
    
}
