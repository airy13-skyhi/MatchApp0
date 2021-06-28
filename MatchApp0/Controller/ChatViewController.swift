//
//  ChatViewController.swift
//  MatchApp0
//
//  Created by Manabu Kuramochi on 2021/06/15.
//

import UIKit
import MessageKit
import Firebase
import InputBarAccessoryView
import SDWebImage
import Hex


struct Sender:SenderType {
    
    var senderId: String
    var displayName: String
}


class ChatViewController: MessagesViewController, MessagesDataSource, MessagesLayoutDelegate, MessagesDisplayDelegate, InputBarAccessoryViewDelegate, MessageCellDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, GetAttachProtocol {
    
    
    
    
    var userDataModel:UserDataModel?
    var userData = [String:Any]()
    var currentUser = Sender(senderId: Auth.auth().currentUser!.uid, displayName: "")
    var otherUser = Sender(senderId: "", displayName: "")
    var messages = [Message]()
    
    
    let imageView = UIImageView()
    let blackView = UIView()
    let db = Firestore.firestore()
    
    lazy var formatter:DateFormatter = {
        
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "MMdHm", options: 0, locale: Locale(identifier: "ja_JP"))
        formatter.timeStyle = .short
        formatter.dateStyle = .short
        
       return formatter
        
    }()
    
    var attachImage:UIImage?
    var attachImageString = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentUser = Sender(senderId: Auth.auth().currentUser!.uid, displayName: userData["name"] as! String)
        
        otherUser = Sender(senderId: userDataModel!.uid!, displayName: (userDataModel!.name)!)
        
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        messagesCollectionView.messageCellDelegate = self
        
        maintainPositionOnKeyboardFrameChanged = true
        messageInputBar.sendButton.setTitle("送信", for: .normal)
        messageInputBar.delegate = self
        
        
        let newMassageInputBar = InputBarAccessoryView()
        newMassageInputBar.delegate = self
        
        messageInputBar = newMassageInputBar
        messageInputBar.separatorLine.isHidden = true
        messageInputBar.inputTextView.layer.borderWidth = 0.0
        
        
        let items = [makeButton(image: UIImage(named: "album")!).onTextViewDidChange({button,  textView in
            
            button.isEnabled = textView.text.isEmpty
            
            
        })]
        
        
        messageInputBar.setLeftStackViewWidthConstant(to: 100, animated: true)
        messageInputBar.setStackViewItems(items, forStack: .left, animated: true)
        
    }
    
    func makeButton(image:UIImage) -> InputBarButtonItem {
        
        return InputBarButtonItem()
            
            .configure {
             $0.spacing = .fixed(10)
             $0.image = image.withRenderingMode(.alwaysTemplate)
             $0.setSize(CGSize(width: 30, height: 30), animated: true)
                
                
        }.onSelected {
            $0.tintColor = .systemBlue
            
            print("タップ")
            self.openCamera()
            
        }.onDeselected {
            
            $0.tintColor = UIColor.lightGray
        }
        
    }
    
    
    func openCamera() {
        let sourceType:UIImagePickerController.SourceType = .photoLibrary
        // カメラが利用可能かチェック
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            // インスタンスの作成
            let cameraPicker = UIImagePickerController()
            cameraPicker.sourceType = sourceType
            cameraPicker.delegate = self
            cameraPicker.allowsEditing = true
            //cameraPicker.showsCameraControls = true
            present(cameraPicker, animated: true, completion: nil)
            
        }else {
            
        }
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        if let pickedImage = info[.editedImage] as? UIImage {
            
            attachImage = pickedImage
            let sendDBModel = SendDBModel()
            
            //imageを送信
            sendDBModel.getAttachProtocol = self
            sendDBModel.sendImageData(image: attachImage!, senderID: Auth.auth().currentUser!.uid, toID: (userDataModel?.uid)!)
            
        }
        
        //閉じる処理
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    // 撮影がキャンセルされた時に呼ばれる
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    

    
    func getAttachProtocol(attachImageString: String) {
        
        self.attachImageString = attachImageString
    }
    
    //massageの下の文字列
    func messageTopLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        
        let dateString = formatter.string(from: message.sentDate)
        return NSAttributedString(string: dateString, attributes: [NSAttributedString.Key.font:UIFont.preferredFont(forTextStyle: .caption2)])
    }
    
    func configureMediaMessageImageView(_ imageView: UIImageView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
        
        if case MessageKind.photo(let media) = message.kind {
            
            imageView.sd_setImage(with: URL(string: messages[indexPath.section].messageImageString), completed: nil)
            
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //messageを受信
        loadMessage()
    }
    
    func loadMessage() {
        
        db.collection("User").document(Auth.auth().currentUser!.uid).collection("matching").document(userDataModel!.uid!).collection("chat").order(by: "date").addSnapshotListener { snapShot, error in
            
            if error != nil {
                return
            }
            
            
            if let snapShotDoc = snapShot?.documents {
                
                self.messages = []
                
                for doc in snapShotDoc {
                    
                    let data = doc.data()
                    
                    if let text = data["text"] as? String, let senderID = data["senderUD"] as? String, let imageURLString = data["imageURLString"] as? String, let date = data["date"] as? TimeInterval {
                        
                        
                        //sender
                        
                        if senderID == Auth.auth().currentUser?.uid {
                            
                            self.currentUser = Sender(senderId: Auth.auth().currentUser!.uid, displayName: self.userData["name"] as! String)
                            
                            let message = Message(sender: self.currentUser, messageId: senderID, sentDate: Date(timeIntervalSince1970: date), kind: .text(text), userImagePath: imageURLString, date: date, messageImageString: "")
                            
                            self.messages.append(message)
                            
                        }else {
                            
                            self.otherUser = Sender(senderId: senderID, displayName: self.userData["name"] as! String)
                            
                            let message = Message(sender: self.otherUser, messageId: senderID, sentDate: Date(timeIntervalSince1970: date), kind: .text(text), userImagePath: imageURLString, date: date, messageImageString: "")
                            
                            self.messages.append(message)
                        }
                    }
                    
                    if let senderID = data["senderID"] as? String, let profileImageString = data["imageURLString"] as? String, let date = data["date"] as? TimeInterval, let attachImageString = data["attachImageString"] as? String {
                        
                        //senderを探索、検証し、IDで振り分け、両者のmessageを２つ作成
                        
                        if senderID == Auth.auth().currentUser?.uid {
                            
                            self.currentUser = Sender(senderId: Auth.auth().currentUser!.uid, displayName: self.userData["name"] as! String)
                            
                            let message = Message(sender: self.currentUser, messageId: senderID, sentDate: Date(timeIntervalSince1970: date), kind: .photo(ImageMediaItem(imageURL: URL(string: attachImageString)!)), userImagePath: profileImageString, date: date, messageImageString: attachImageString)
                            
                            self.messages.append(message)
                            
                        }else {
                            
                            self.otherUser = Sender(senderId: senderID, displayName: "")
                            
                            let message = Message(sender: self.otherUser, messageId: senderID, sentDate: Date(timeIntervalSince1970: date), kind: .photo(ImageMediaItem(imageURL: URL(string: attachImageString)!)), userImagePath: profileImageString, date: date, messageImageString: attachImageString)
                            
                            self.messages.append(message)
                            
                            
                        }
                        
                    }
                    
                }
                
                self.messagesCollectionView.reloadData()
                self.messagesCollectionView.scrollToLastItem()
            }
            
        }
        
    }
    
    
    func getImageByUrl(url:String) -> UIImage {
        
        let url = URL(string: url)
        
        do {
            let data = try Data(contentsOf: url!)
            return UIImage(data: data)!
        } catch let error {
            
            print(error)
        }
        return UIImage()
    }
    
    
    func currentSender() -> SenderType {
        return currentUser
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        
        return messages[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        
        return messages.count
    }
    
    
    
    //sendButtonが押されたら呼ばれるmethod
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        
        inputBar.sendButton.startAnimating()
        let sendDBModel = SendDBModel()
        
        inputBar.inputTextView.text = ""
        
        sendDBModel.sendMesage(senderID: Auth.auth().currentUser!.uid, toID: (userDataModel?.uid)!, text: text, displayName: userData["name"] as! String, imageURLString: userData["profileImageString"] as! String)
        
        
        
        inputBar.sendButton.stopAnimating()
    }
    
    
    //送信者と受信者の顔
    func configureAvatarView(_ avatarView: AvatarView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
        
        avatarView.sd_setImage(with: URL(string: messages[indexPath.section].userImagePath), completed: nil)
        
    }
    
    func messageTopLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        return 16
    }
    
    
    func messageBottomLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        
        return 16
    }
    
    
    func backgroundColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        
        return isFromCurrentSender(message: message) ? Util.setChatColor(me: true):Util.setChatColor(me: false)
        
    }
    
    
    
    func messageStyle(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageStyle {
        
        let corner:MessageStyle.TailCorner = isFromCurrentSender(message: message) ? .bottomRight: .bottomLeft
        
        
        return .bubbleTail(corner, .curved)
    }
    
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if self.imageView.alpha == 1.0 {
            
            UIView.animate(withDuration: 0.2) {
                
                self.blackView.alpha = 0.0
                self.imageView.alpha = 0.0
                
                
            } completion: { finish in
                
                self.blackView.removeFromSuperview()
                self.imageView.removeFromSuperview()
            }

        }
    }
    
    func didTapAvatar(in cell: MessageCollectionViewCell) {
        
        guard let indexPath = messagesCollectionView.indexPath(for: cell) else {
            
            return
        }
        zoomSystem(imageString: messages[indexPath.section].userImagePath, avatorOrNot: true)
        
        
    }
    
    func didTapImage(in cell: MessageCollectionViewCell) {
        
        guard let indexPath = messagesCollectionView.indexPath(for: cell) else {
            
            return
        }
        
        if messages[indexPath.section].messageImageString.isEmpty != true {
            
            zoomSystem(imageString: messages[indexPath.section].messageImageString, avatorOrNot: false)
            
        }else {
            
            return
        }
        
        
        
    }
    
    
    
    func zoomSystem(imageString:String, avatorOrNot:Bool) {
        
        blackView.frame = view.bounds
        blackView.backgroundColor = .darkGray
        blackView.alpha = 0.0
        
        imageView.frame = CGRect(x: 0, y: view.frame.size.width/2, width: view.frame.size.width, height: view.frame.size.width)
        imageView.isUserInteractionEnabled = true
        imageView.alpha = 0.0
        
        if avatorOrNot == true {
            
            imageView.layer.cornerRadius = imageView.frame.width/2
            
        }else {
            
            imageView.contentMode = .scaleToFill
            imageView.clipsToBounds = true
            
            UIView.animate(withDuration: 0.2) {
                
                self.blackView.alpha = 0.9
                self.imageView.alpha = 1.0
                
            } completion: { finish in
                
            }
            
            imageView.sd_setImage(with: URL(string: imageString), completed: nil)
            view.addSubview(blackView)
            view.addSubview(imageView)
        }
        
    }
    
    
    
    
    
}
