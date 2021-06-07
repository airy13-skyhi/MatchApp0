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


class SendDBModel {
    
    let db = Firestore.firestore()
    var profileSendDone:ProfileSendDone?
    
    
    
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
                    
                    
                    
                }
                self.profileSendDone?.profileSendDone()
                
            }
        }
    }
    
    
    
    
}


