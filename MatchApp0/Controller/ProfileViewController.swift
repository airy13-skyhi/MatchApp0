//
//  ProfileViewController.swift
//  MatchApp0
//
//  Created by Manabu Kuramochi on 2021/06/09.
//

import UIKit



class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    var userDataModel:UserDataModel?
    var likeCount = 0
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(ProfileImageCell.nib(), forCellReuseIdentifier: ProfileImageCell.identifire)
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: ProfileImageCell.identifire, for: indexPath) as! ProfileImageCell
            
            
            cell.configure(profileImageString: (userDataModel?.profileImageString)!, nicnameLabelString: (userDataModel?.name)!, ageLabelString: (userDataModel?.age)!, prefectureLabelString: (userDataModel?.prefecture)!, quickWordLabelString: (userDataModel?.quickWord)!, likeLabelString: String(likeCount))
            
            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTextCell.identifire, for: indexPath) as! ProfileTextCell
            
            cell.profileTextView.text = userDataModel?.profile
            
            return cell
            
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: ProfileDetailCell.identifire, for: indexPath) as! ProfileDetailCell
            
            cell.configure(nicnameLabelString: (userDataModel?.name)!, ageLabelString: (userDataModel?.age)!, prefectureLabelString: (userDataModel?.prefecture)!, heightLabelString: (userDataModel?.height)!, bloodLabelStrng: (userDataModel?.bloodType)!, genderLabelString: (userDataModel?.gender)!, jobLabelString: (userDataModel?.job)!)
            
            return cell
            
        default:
            return UITableViewCell()
            
            
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 1 {
            return 450
        }else if indexPath.row == 2 {
            return 370
        }else if indexPath.row == 3 {
            return 400
        }
        return 1
    }
    
    
    
    

}
