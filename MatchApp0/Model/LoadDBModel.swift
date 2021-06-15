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

protocol GetlikeCountProtocol {
    
    func getLikeCount(likeCount:Int, likeFlag:Bool)
}

protocol GetLikeDataProtocol {
    
    func getLikeDataProtocol(userDataModelArray:[UserDataModel])
}


protocol GetWhoIsMatchListProtocol {
    
    func getWhoIsMatchListProtocol(userDataModelArray:[UserDataModel])
    
}



class LoadDBModel {
    
    var db = Firestore.firestore()
    var profileModelArray = [UserDataModel]()
    var getProfileDataProtocol:GetProfileDataProtocol?
    var getlikeCountProtocol:GetlikeCountProtocol?
    var getLikeDataProtocol:GetLikeDataProtocol?
    var getWhoIsMatchListProtocol:GetWhoIsMatchListProtocol?
    
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
    
    
    func loadLikeCount(uuid:String) {
        
        var likeFlag = Bool()
        db.collection("Users").document(uuid).collection("like").addSnapshotListener { snapShot, error in
            
            if error != nil {
                return
            }
            
            if let snapShotDoc = snapShot?.documents {
                
                for doc in snapShotDoc {
                    
                    let data = doc.data()
                    
                    if doc.documentID == Auth.auth().currentUser?.uid {
                        
                        if let like = data["like"] as? Bool {
                            
                            
                            
                        }
                    }
                }
                
                let docCount = snapShotDoc.count
                self.getlikeCountProtocol?.getLikeCount(likeCount: docCount, likeFlag: likeFlag)
                
            }
        }
    }
    
    
    
    func loadLikeList() {
        
        
        db.collection("Users").document(Auth.auth().currentUser!.uid).collection("like").addSnapshotListener { snapShot, error in
            
            
            if error != nil {
                print(error.debugDescription)
                return
            }
            
            
            if let snapShotDoc = snapShot?.documents {
                
                self.profileModelArray = []
                
                for doc in snapShotDoc {
                    
                    let data = doc.data()
                    if let name = data["name"] as? String, let age = data["age"] as? String, let height = data["height"] as? String, let bloodType = data["bloodType"] as? String, let prefecture = data["prefecture"] as? String, let gender = data["gender"] as? String, let profile = data["profile"] as? String, let profileImageString = data["profileImageString"] as? String, let uid = data["uid"] as? String, let quickWord = data["quickWord"] as? String, let job = data["job"] as? String {
                        
                        let userDataModel = UserDataModel(name: name, age: age, height: height, bloodType: bloodType, prefecture: prefecture, gender: gender, profile: profile, profileImageString: profileImageString, uid: uid, quickWord: quickWord, job: job, date: 0, onlineORNot: true)
                        
                        
                        self.profileModelArray.append(userDataModel)
                        
                    }
                    
                }
                self.getLikeDataProtocol?.getLikeDataProtocol(userDataModelArray: self.profileModelArray)
            }
            
        }
        
    }
    
    
    //collection(macthing)のデータ(人)を取得
    func loadMatchPersonData() {
        
        db.collection("Users").document(Auth.auth().currentUser!.uid).collection("matching").addSnapshotListener { snapShot, error in
            
            if error != nil {
                print(error.debugDescription)
                return
            }
            
            if let snapShotDoc = snapShot?.documents {
                
                self.profileModelArray = []
                
                for doc in snapShotDoc {
                    
                    let data = doc.data()
                    
                    if let name = data["name"] as? String, let age = data["age"] as? String, let height = data["height"] as? String, let bloodType = data["bloodType"] as? String, let prefecture = data["prefecture"] as? String, let gender = data["gender"] as? String, let profile = data["profile"] as? String, let profileImageString = data["profileImageString"] as? String, let uid = data["uid"] as? String, let quickWord = data["quickWord"] as? String, let job = data["job"] as? String {
                        
                        
                        let userDataModel = UserDataModel(name: name, age: age, height: height, bloodType: bloodType, prefecture: prefecture, gender: gender, profile: profile, profileImageString: profileImageString, uid: uid, quickWord: quickWord, job: job, date: 0, onlineORNot: true)
                        
                        self.profileModelArray.append(userDataModel)
                        
                    }
                    
                }
                
                self.getWhoIsMatchListProtocol?.getWhoIsMatchListProtocol(userDataModelArray: self.profileModelArray)
                
            }
            
            
        }
        
    }
    
    
    
    
    
}



