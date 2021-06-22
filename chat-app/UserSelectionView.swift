//
//  UserSelectionView.swift
//  chat-app
//
//  Created by Yan Correa Trindade on 22/06/21.
//
import UIKit

class UserSelectionView: UIView {
    
    let userOneButton = UIButton()
    let userTwoButton = UIButton()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UserSelectionView: RenderViewProtocol {
    
    func buildViewHierarchy() {
        userOneButton.translatesAutoresizingMaskIntoConstraints = false
        userTwoButton.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(userOneButton)
        addSubview(userTwoButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            userOneButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            userOneButton.centerYAnchor.constraint(equalTo: self.centerYAnchor,constant: -64),
            userOneButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 32),
            userOneButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -32),
            userOneButton.heightAnchor.constraint(equalToConstant: 40.0)
        ])
        
        NSLayoutConstraint.activate([
            userTwoButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            userTwoButton.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 64),
            userTwoButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 32),
            userTwoButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -32),
            userTwoButton.heightAnchor.constraint(equalToConstant: 40.0)
        ])
    }
    
    func additionalViewSetup() {
        backgroundColor = .white
        
        userOneButton.backgroundColor = .blue
        userOneButton.setTitle("User One", for: .normal)
        
        userTwoButton.backgroundColor = .red
        userTwoButton.setTitle("User Two", for: .normal)
    }
    
}
