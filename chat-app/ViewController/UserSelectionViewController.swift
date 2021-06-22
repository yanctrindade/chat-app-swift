//
//  UserSelectionViewController.swift
//  chat-app
//
//  Created by Yan Correa Trindade on 22/06/21.
//

import UIKit

class UserSelectionViewController: UIViewController {

    var uiController: UserSelectionView
    
    init() {
        uiController = UserSelectionView()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = uiController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtons()
    }
    
    func setupButtons() {
        uiController.userOneButton.addTarget(self, action: #selector(pressedUserOneButton(_ :)), for: .touchUpInside)
        uiController.userTwoButton.addTarget(self, action: #selector(pressedUserTwoButton(_ :)), for: .touchUpInside)
    }
    
    @objc func pressedUserOneButton(_ sender: UIButton) {
        coordinator.userSelectionToChat(uuid: "001")
    }
    
    @objc func pressedUserTwoButton(_ sender: UIButton) {
        coordinator.userSelectionToChat(uuid: "002")
    }
}
