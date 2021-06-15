//
//  SendDBModel.swift
//  MatchApp0
//
//  Created by Manabu Kuramochi on 2021/06/04.
//

import Foundation
import Firebase



protocol ProfileSendDone {
    
    func profileSendDone()
    
}

protocol LikeSendDelegate {
    
    func like()
    
}


class SendDBModel {
    
    let db = Firestore.firestore()
    var profileSendDone:ProfileSendDone?
    var likeSendDelegate:LikeSendDelegate?
    
    
    func sendProfileData(userData:UserDataModel, profileImageData:Data) {
        
        
        let iamgeRef = Storage.storage().reference().child("ProfileImage").child("\(UUID().uuidString + String(Date().timeIntervalSince1970))")
        
        
        iamgeRef.putData(profileImageData, metadata: nil) { metaData, error in
            
            if error != nil {
                return
            }
            
            
            iamgeRef.downloadURL { url, error in
                
                if error != nil {
                    return
                }
                
                
                if url != nil {
                    
                    self.db.collection("Users").document(Auth.auth().currentUser!.uid).setData(["name":userData.name as Any, "age":userData.age as Any, "height":userData.height as Any, "bloodType":userData.bloodType as Any, "prefecture":userData.prefecture as Any, "gender":userData.gender as Any, "profile":userData.profile as Any, "profileImageString":url?.absoluteString as Any, "uid":Auth.auth().currentUser!.uid as Any, "quickWord":userData.quickWord as Any, "job":userData.job as Any, "onlineORNot":userData.onlineORNot as Any])
                    
                    
                    KeyChainConfig.setKeyData(value: ["name":userData.name as Any, "age":userData.age as Any, "height":userData.height as Any, "bloodType":userData.bloodType as Any, "prefecture":userData.prefecture as Any, "gender":userData.gender as Any, "profile":userData.profile as Any, "profileImageString":url?.absoluteString as Any, "uid":Auth.auth().currentUser!.uid as Any, "quickWord":userData.quickWord as Any, "job":userData.job as Any], key: "userData")
                    
                    var userData = KeyChainConfig.getkeyData(key: "userData")
                    
                    
                }
                self.profileSendDone?.profileSendDone()
                
            }
        }
    }
    
    
    func sendToLike(likeFlag:Bool, thisUserID:String) {
        
        if likeFlag == false {
            
            self.db.collection("Users").document(thisUserID).collection("like").document(Auth.auth().currentUser!.uid).setData(["like":false])
            
            deleteToLike(thisUserID: thisUserID)
            
            var ownLikeListArray = KeyChainConfig.getKeyArrayListData(key: "ownLikeList")
            ownLikeListArray.removeAll(where: {$0 == thisUserID})
            
            KeyChainConfig.setKeyArrayData(value: ownLikeListArray, key: "ownLikeList")
            
            //自身がlikeした人のID一覧
            print(ownLikeListArray.debugDescription)
            
            
        }else if likeFlag == true {
            
            let userData = KeyChainConfig.getkeyArrayData(key: "userData")
            
            
            self.db.collection("Users").document(thisUserID).collection("like").document(Auth.auth().currentUser!.uid).setData(["like":true, "gender":userData["gender"] as Any, "uid":userData["uid"] as Any, "age":userData["age"] as Any, "height":userData["height"] as Any, "profileImageString":userData["profileImageString"] as Any, "prefecture":userData["prefecture"] as Any, "name":userData["name"] as Any, "quickWord":userData["quickWord"] as Any, "profile":userData["profile"] as Any, "bloodType":userData["bloodType"] as Any, "job":userData["job"] as Any])
            
            self.db.collection("Users").document(Auth.auth().currentUser!.uid).collection("ownLiked").document(thisUserID).setData(["like":true, "gender":userData["gender"] as Any, "uid":userData["uid"] as Any, "age":userData["age"] as Any, "height":userData["height"] as Any, "profileImageString":userData["profileImageString"] as Any, "prefecture":userData["prefecture"] as Any, "name":userData["name"] as Any, "quickWord":userData["quickWord"] as Any, "profile":userData["profile"] as Any, "bloodType":userData["bloodType"] as Any, "job":userData["job"] as Any])
            
            var ownLikeListArray = KeyChainConfig.getKeyArrayListData(key: "ownLikeList")
            ownLikeListArray.append(thisUserID)
            KeyChainConfig.setKeyArrayData(value: ownLikeListArray, key: "ownLikeList")
            
            self.likeSendDelegate?.like()
            
        }
        
    }
    
    
    func deleteToLike(thisUserID:String) {
        
        self.db.collection("Users").document(thisUserID).collection("like").document(Auth.auth().currentUser!.uid).delete()
        
        
        self.db.collection("Users").document(Auth.auth().currentUser!.uid).collection("like").document(thisUserID).delete()
        
        
        self.db.collection("Users").document(Auth.auth().currentUser!.uid).collection("ownLiked").document(thisUserID).delete()
        
    }
    
    
    
    func sendToLikeFromLike(likeFlag:Bool, thisUserID:String, matchName:String, matchID:String) {
        
        if likeFlag == false {
            
            self.db.collection("Users").document(thisUserID).collection("like").document(Auth.auth().currentUser!.uid).setData(["like":false])
            deleteToLike(thisUserID: thisUserID)
            
            var ownLikeListArray = KeyChainConfig.getKeyArrayListData(key: "ownLikeList")
            ownLikeListArray.removeAll(where: {$0 == thisUserID})
            KeyChainConfig.setKeyArrayData(value: ownLikeListArray, key: "ownLikeList")
            
        }else if likeFlag == true {
            
            let userData = KeyChainConfig.getkeyArrayData(key: "userData")
            self.db.collection("Users").document(thisUserID).collection("like").document(Auth.auth().currentUser!.uid).setData(["like":true, "gender":userData["gender"] as Any, "uid":userData["uid"] as Any, "age":userData["age"] as Any, "height":userData["height"] as Any, "profileImageString":userData["profileImageString"] as Any, "prefecture":userData["prefecture"] as Any, "name":userData["name"] as Any, "quickWord":userData["quickWord"] as Any, "profile":userData["profile"] as Any, "bloodType":userData["bloodType"] as Any, "job":userData["job"] as Any])
            
            
            self.db.collection("Users").document(Auth.auth().currentUser!.uid).collection("ownLiked").document(thisUserID).setData(["like":true, "gender":userData["gender"] as Any, "uid":userData["uid"] as Any, "age":userData["age"] as Any, "height":userData["height"] as Any, "profileImageString":userData["profileImageString"] as Any, "prefecture":userData["prefecture"] as Any, "name":userData["name"] as Any, "quickWord":userData["quickWord"] as Any, "profile":userData["profile"] as Any, "bloodType":userData["bloodType"] as Any, "job":userData["job"] as Any])
            
            
            var ownLikeListArray = KeyChainConfig.getKeyArrayListData(key: "ownLikeList")
            ownLikeListArray.append(thisUserID)
            KeyChainConfig.setKeyArrayData(value: ownLikeListArray, key: "ownLikeList")
            
            
            Util.matchNotification(name: matchName, id: matchID)
            
            deleteToLike(thisUserID: Auth.auth().currentUser!.uid)
            deleteToLike(thisUserID: matchID)
            
            self.likeSendDelegate?.like()
        }
        
    }
    
    
    func sendToMatchingList(thisUserID:String, nicname:String, age:String, bloodType:String, height:String, prefecture:String, gender:String, profile:String, profileImageString:String, uid:String, quickWord:String, job:String, userData:[String:Any]) {
        
        if thisUserID != uid {
            
            self.db.collection("Users").document(thisUserID).collection("matching").document(Auth.auth().currentUser!.uid).setData(["gender":gender as Any, "uid":uid as Any, "age":age as Any, "height":height as Any, "profileImageString":profileImageString as Any, "prefecture":prefecture as Any, "name":nicname as Any, "quickWord":quickWord as Any, "profile":profile as Any, "bloodType":bloodType as Any, "job":job as Any])
            
        }else {
            
            
            self.db.collection("Users").document(Auth.auth().currentUser!.uid).collection("matching").document(thisUserID).setData(["gender":gender as Any, "uid":uid as Any, "age":age as Any, "height":height as Any, "profileImageString":profileImageString as Any, "prefecture":prefecture as Any, "name":nicname as Any, "quickWord":quickWord as Any, "profile":profile as Any, "bloodType":bloodType as Any, "job":job as Any])
            
        }
        self.db.collection("Users").document(thisUserID).collection("like").document(Auth.auth().currentUser!.uid).delete()
        
        self.db.collection("Users").document(Auth.auth().currentUser!.uid).collection("like").document(thisUserID).delete()
        
        
        
    }
    
    
    
    
    
    
}


