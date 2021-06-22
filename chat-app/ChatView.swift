//
//  ChatView.swift
//  chat-app
//
//  Created by Yan Correa Trindade on 22/06/21.
//
import UIKit

class ChatView: UIView {
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ChatView: RenderViewProtocol {
    
    func buildViewHierarchy() {
        //nada-faz
    }
    
    func setupConstraints() {
        //nada-faz
    }
    
    func additionalViewSetup() {
        //nada-faz
    }
    
}
