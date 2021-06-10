//
//  HumansViewController.swift
//  MatchApp0
//
//  Created by Manabu Kuramochi on 2021/06/08.
//

import UIKit
import Firebase
import SDWebImage


class HumansViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, GetProfileDataProtocol {
    
    
    let sectionInsets = UIEdgeInsets(top: 10.0, left: 2.0, bottom: 2.0, right: 2.0)
    let itemsPerRow:CGFloat = 2
    var searchORNot = Bool()
    var userDataModelArray = [UserDataModel]()
    
    
    
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var ashiatoButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
        
        
        if Auth.auth().currentUser?.uid != nil && searchORNot == false {
            
            
            collectionView.delegate = self
            collectionView.dataSource = self
            
            
            let userData = KeyChainConfig.getkeyArrayData(key: "userData")
            print(userData["gender"])
            
            var loadDBModel = LoadDBModel()
            loadDBModel.getProfileDataProtocol = self
            loadDBModel.loadUsersProfile(gender: userData["gender"] as! String)
            
            
        }else if Auth.auth().currentUser?.uid != nil && searchORNot == true {
            
            collectionView.reloadData()
            
            
            
        }else {
            performSegue(withIdentifier: "inputVC", sender: nil)
            
        }
        
        
    }
    
    
    
    func getProfileData(userDataModelArray: [UserDataModel]) {
        self.userDataModelArray = userDataModelArray
        collectionView.reloadData()
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userDataModelArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem + 42)
                
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        
        return sectionInsets
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 10
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        
        cell.layer.cornerRadius = cell.frame.width/2
        cell.layer.borderWidth = 0.0
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 0)
        cell.layer.shadowRadius = 5.0
        cell.layer.shadowOpacity = 1.0
        cell.layer.masksToBounds = true
        
        let imageView = cell.contentView.viewWithTag(1) as! UIImageView
        imageView.sd_setImage(with: URL(string: userDataModelArray[indexPath.row].profileImageString!), completed: nil)
        imageView.layer.cornerRadius = imageView.frame.width/2
        
        let ageLabel = cell.contentView.viewWithTag(2) as! UILabel
        ageLabel.text = userDataModelArray[indexPath.row].age
        
        let prefectureLabel = cell.contentView.viewWithTag(3) as! UILabel
        prefectureLabel.text = userDataModelArray[indexPath.row].prefecture
        
        let onLineMarkImageView = cell.contentView.viewWithTag(4) as! UIImageView
        onLineMarkImageView.layer.cornerRadius = onLineMarkImageView.frame.width/2
        
        if userDataModelArray[indexPath.row].onlineORNot == true {
            
            onLineMarkImageView.image = UIImage(named: "online")
            
        }else {
            
            onLineMarkImageView.image = UIImage(named: "offline")
            
        }
        
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let profileVC = self.storyboard?.instantiateViewController(identifier: "profileVC") as! ProfileViewController
        
        profileVC.userDataModel = userDataModelArray[indexPath.row]
        self.navigationController?.pushViewController(profileVC, animated: true)
    }
    
    
    
    
}
