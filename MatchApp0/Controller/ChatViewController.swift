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


class ChatViewController: MessagesViewController, MessagesDataSource, MessagesLayoutDelegate, MessagesDisplayDelegate, InputBarAccessoryViewDelegate, MessageCellDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    var userDataModel:UserDataModel?
    var userData = [String:Any]()
    var currentUser = Sender(senderId: Auth.auth().currentUser!.uid, displayName: "")
    var otherUser = Sender(senderId: "", displayName: "")
    var message = [Message]()
    
    
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
            
            
            
            //閉じる処理
            picker.dismiss(animated: true, completion: nil)
        }
    }
    
    
    // 撮影がキャンセルされた時に呼ばれる
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    

    func currentSender() -> SenderType {
        <#code#>
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        <#code#>
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        <#code#>
    }
    
    

}
