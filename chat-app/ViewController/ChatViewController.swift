import UIKit
import PubNub
import MessageKit
import InputBarAccessoryView

class ChatViewController: MessagesViewController {
    
    var pubnub: PubNub!
    let channels = [Constants.Chat.DEFAULT_CHANNEL]
    let listener = SubscriptionListener(queue: .main)
    
    let sender: MockUser
    var messages: [MockMessage] = []
    
    var uiController: ChatView
    
    init(pubnub: PubNub, sender: MockUser) {
        uiController = ChatView()
        self.pubnub = pubnub
        self.sender = sender
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
        setupMessagesCollectionView()
        configureMessageInputBar()
        setupChatListeners()
    }
    
    func setupChatListeners() {
        listener.didReceiveMessage = { message in
            print("[Message]: \(message)")
            if let msg = message.payload.stringOptional {
                if let publisherID = message.publisher {
                    if self.sender.senderId == publisherID {
                        let msg = MockMessage(text: msg, user: self.sender, messageId: "001", date:Date())
                        self.messages.append(msg)
                    } else {
                        let user = MockUser(senderId: publisherID, displayName: "user\(publisherID)")
                        let msg = MockMessage(text: msg, user: user, messageId: "002", date:Date())
                        self.messages.append(msg)
                    }
                }
                
                self.messagesCollectionView.reloadData()
            }
        }
        
        listener.didReceiveStatus = { status in
            switch status {
                case .success(let connection):
                    if connection == .connected {
                        print("connect to chat websocket")
                    }
                case .failure(let error):
                    print("Status Error: \(error.localizedDescription)")
            }
        }
        
        pubnub.add(listener)
        pubnub.subscribe(to: channels, withPresence: true)
    }
    
    func setupMessagesCollectionView() {
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
    }
    
    func configureMessageInputBar() {
        messageInputBar.delegate = self
        messageInputBar.inputTextView.tintColor = .red
        messageInputBar.sendButton.setTitleColor(.red, for: .normal)
        messageInputBar.sendButton.setTitleColor(
            UIColor.red.withAlphaComponent(0.3),
            for: .highlighted
        )
    }


}

extension ChatViewController: MessagesDataSource {

    func currentSender() -> SenderType {
        return sender
    }

    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messages.count
    }

    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messages[indexPath.section] as MessageType
    }
}

extension ChatViewController: MessagesDisplayDelegate, MessagesLayoutDelegate {
    
}

extension ChatViewController: InputBarAccessoryViewDelegate {
    
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        print("send button pressed")
        self.pubnub.publish(channel: self.channels[0], message: text) { result in
            print(result.map { "Publish Response at \($0.timetokenDate)" })
        }
        inputBar.inputTextView.text = ""
    }
    
    func inputBar(_ inputBar: InputBarAccessoryView, didChangeIntrinsicContentTo size: CGSize) {
        //nada-faz
    }
    
    func inputBar(_ inputBar: InputBarAccessoryView, textViewTextDidChangeTo text: String) {
        //nada-faz
    }
    
    func inputBar(_ inputBar: InputBarAccessoryView, didSwipeTextViewWith gesture: UISwipeGestureRecognizer) {
        //nada-faz
    }
}
