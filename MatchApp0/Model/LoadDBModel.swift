//
//  LoadDBModel.swift
//  MatchApp0
//
//  Created by Manabu Kuramochi on 2021/06/08.
//

import Foundation
import Firebase

protocol GetProfileDataProtocol {
    
    func getProfileData(userDataModelArray:[UserDataModel])
    
    
}



class LoadDBModel {
    
    var db = Firestore.firestore()
    var profileModelArray = [UserDataModel]()
    var getProfileDataProtocol:GetProfileDataProtocol?
    
    
    
    func loadUsersProfile(gender:String) {
        
        db.collection("Users").whereField("gender", isNotEqualTo: gender).addSnapshotListener { snapShot, error in
            
            
            if error != nil {
                print(error.debugDescription)
                return
            }
            
            
            if let snapShotDoc = snapShot?.documents {
                
                self.profileModelArray = []
                
                for doc in snapShotDoc {
                    
                    let data = doc.data()
                    if let name = data["name"] as? String, let age = data["age"] as? String, let height = data["height"] as? String, let bloodType = data["bloodType"] as? String, let prefecture = data["prefecture"] as? String, let gender = data["gender"] as? String, let profile = data["profile"] as? String, let profileImageString = data["profileImageString"] as? String, let uid = data["uid"] as? String, let quickWord = data["quickWord"] as? String, let job = data["job"] as? String, let onlinORNot = data["onlineORNot"] as? Bool {
                        
                        let userDataModel = UserDataModel(name: name, age: age, height: height, bloodType: bloodType, prefecture: prefecture, gender: gender, profile: profile, profileImageString: profileImageString, uid: uid, quickWord: quickWord, job: job, date: 0, onlineORNot: onlinORNot)
                        
                        
                        self.profileModelArray.append(userDataModel)
                        
                    }
                    
                }
                
                self.getProfileDataProtocol?.getProfileData(userDataModelArray: self.profileModelArray)
            }
            
            
        }
        
    }
    
    
}



